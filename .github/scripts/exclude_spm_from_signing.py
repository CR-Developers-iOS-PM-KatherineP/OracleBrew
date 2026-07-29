#!/usr/bin/env python3
"""
Exclude SPM targets from manual signing settings.
Adds PROVISIONING_PROFILE_SPECIFIER only to the main app target Release config.
"""

import re
import sys
import os


def find_release_config_variants(content, release_config_id):
    variants = []
    patterns = [
        (rf'(\t\t{re.escape(release_config_id)} /\* Release \*\/ = \{{)(.*?)(\t\t\}};)', "VARIANT_1"),
        (rf'(\t\t{re.escape(release_config_id)} = \{{)(.*?)(\t\t\}};)', "VARIANT_2"),
        (rf'(\t\t{re.escape(release_config_id)} /\* [^*]+ \*/ = \{{)(.*?)(\t\t\}};)', "VARIANT_3"),
    ]
    for pattern, name in patterns:
        match = re.search(pattern, content, flags=re.DOTALL)
        if match:
            variants.append((name, match))
    return variants


def add_provisioning_profile_variants(config_body, profile_uuid):
    variants = []
    clean_body = re.sub(r'\t\t\t\tPROVISIONING_PROFILE_SPECIFIER\s*=\s*[^;]+;\s*\n?', '', config_body)

    if 'CODE_SIGN_ENTITLEMENTS' in clean_body:
        new_body = re.sub(
            r'(CODE_SIGN_ENTITLEMENTS = [^;]+;)',
            rf'\1\n\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = {profile_uuid};',
            clean_body
        )
        variants.append(("INSERT_AFTER_ENTITLEMENTS", new_body))

    for key, label in [
        ('CODE_SIGN_STYLE', "INSERT_AFTER_CODE_SIGN_STYLE"),
        ('DEVELOPMENT_TEAM', "INSERT_AFTER_DEVELOPMENT_TEAM"),
        ('PRODUCT_BUNDLE_IDENTIFIER', "INSERT_AFTER_BUNDLE_ID"),
        ('CODE_SIGN_IDENTITY', "INSERT_AFTER_CODE_SIGN_IDENTITY"),
    ]:
        if key in clean_body:
            new_body = re.sub(
                rf'({key} = [^;]+;)',
                rf'\1\n\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = {profile_uuid};',
                clean_body
            )
            variants.append((label, new_body))

    if 'buildSettings = {' in clean_body:
        lines = clean_body.split('\n')
        new_lines = []
        inserted = False
        for line in lines:
            new_lines.append(line)
            if 'buildSettings = {' in line and not inserted:
                new_lines.append(f'\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = {profile_uuid};')
                inserted = True
        variants.append(("INSERT_AFTER_BUILD_SETTINGS", '\n'.join(new_lines)))

    variants.append(("INSERT_FALLBACK", f'\t\t\t\tPROVISIONING_PROFILE_SPECIFIER = {profile_uuid};\n' + clean_body.lstrip('\t')))
    return variants


def find_main_target_config_list(content, main_target):
    patterns = [
        rf'PBXNativeTarget "{re.escape(main_target)}" = \{{.*?buildConfigurationList = (\w{{24}})',
        rf'(\w{{24}}) /\* {re.escape(main_target)} \*/ = \{{.*?buildConfigurationList = (\w{{24}})',
        rf'(\w{{24}}) /\* Build configuration list for PBXNativeTarget "{re.escape(main_target)}" \*/',
    ]

    for i, pattern in enumerate(patterns):
        match = re.search(pattern, content, flags=re.DOTALL)
        if match:
            config_list_id = match.group(2 if i == 1 else 1)
            print(f"✅ Found config list for '{main_target}': {config_list_id}")
            return config_list_id

    print(f"❌ Error: Could not find main target '{main_target}'")
    sys.exit(1)


def exclude_spm_from_signing(pbxproj_path, profile_uuid=None, main_target="OracleBrew"):
    if not os.path.exists(pbxproj_path):
        print(f"❌ Error: File {pbxproj_path} not found")
        sys.exit(1)

    with open(pbxproj_path, 'r') as f:
        content = f.read()

    original_content = content
    new_content = content
    changes_made = False

    config_list_id = find_main_target_config_list(content, main_target)

    config_list_pattern = rf'{re.escape(config_list_id)} /\* Build configuration list[^}}]*?buildConfigurations = \(([^)]+)\);'
    config_list_match = re.search(config_list_pattern, content, flags=re.DOTALL)
    if not config_list_match:
        config_list_pattern_alt = rf'{re.escape(config_list_id)}[^=]*=.*?buildConfigurations\s*=\s*\(([^)]+)\);'
        config_list_match = re.search(config_list_pattern_alt, content, flags=re.DOTALL)

    if not config_list_match:
        print("❌ Error: Could not find build configurations list")
        sys.exit(1)

    main_config_ids = set()
    release_config_id = None
    config_ids_text = config_list_match.group(1)

    for match in re.finditer(r'(\w{24}) /\* (Debug|Release) \*/', config_ids_text):
        config_id = match.group(1)
        config_type = match.group(2)
        main_config_ids.add(config_id)
        if config_type == 'Release':
            release_config_id = config_id

    if not release_config_id:
        print("❌ Error: Could not find Release configuration ID")
        sys.exit(1)

    print(f"✅ Main target Release config: {release_config_id}")

    config_section_pattern = r'(\t\t)(\w{24}) (/\* [^*]+ \*/ = \{)(.*?)(\t\t\};)'

    def clean_non_main_configs(match):
        nonlocal changes_made
        indent, config_id, config_header, config_body, config_footer = match.groups()
        if config_id not in main_config_ids:
            original_body = config_body
            config_body = re.sub(r'\t\t\t\tPROVISIONING_PROFILE_SPECIFIER\s*=\s*[^;]+;\s*\n?', '', config_body)
            config_body = re.sub(r'\t\t\t\tCODE_SIGN_ENTITLEMENTS\s*=\s*[^;]+;\s*\n?', '', config_body)
            if original_body != config_body:
                changes_made = True
                return indent + config_id + ' ' + config_header + config_body + config_footer
        return match.group(0)

    new_content = re.sub(config_section_pattern, clean_non_main_configs, new_content, flags=re.DOTALL)

    if profile_uuid:
        find_variants = find_release_config_variants(new_content, release_config_id)
        if not find_variants:
            print("❌ Error: Could not find Release config section")
            sys.exit(1)

        success = False
        for _, find_match in find_variants:
            config_header, config_body, config_footer = find_match.group(1), find_match.group(2), find_match.group(3)
            if f'PROVISIONING_PROFILE_SPECIFIER = {profile_uuid}' in config_body:
                success = True
                break
            for _, new_config_body in add_provisioning_profile_variants(config_body, profile_uuid):
                if f'PROVISIONING_PROFILE_SPECIFIER = {profile_uuid}' in new_config_body:
                    new_content = (
                        new_content[:find_match.start()]
                        + config_header + new_config_body + config_footer
                        + new_content[find_match.end():]
                    )
                    changes_made = True
                    success = True
                    break
            if success:
                break

        if not success:
            print("❌ Error: Could not add PROVISIONING_PROFILE_SPECIFIER")
            sys.exit(1)

    if changes_made or new_content != original_content:
        with open(pbxproj_path, 'w') as f:
            f.write(new_content)
        print(f"✅ Changes saved to {pbxproj_path}")
    else:
        print("ℹ️ No changes needed")


if __name__ == "__main__":
    if len(sys.argv) < 2 or len(sys.argv) > 4:
        print("Usage: exclude_spm_from_signing.py <pbxproj_path> [profile_uuid] [main_target]")
        sys.exit(1)

    pbxproj_path = sys.argv[1]
    profile_uuid = sys.argv[2] if len(sys.argv) > 2 else None
    main_target = sys.argv[3] if len(sys.argv) > 3 else "OracleBrew"
    exclude_spm_from_signing(pbxproj_path, profile_uuid, main_target)
