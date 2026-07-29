# Releasing OracleBrew

`.github/workflows/release.yml` builds a signed `.ipa` and uploads it to App Store
Connect. It runs on every push to the `release` branch, and on demand from the
Actions tab.

Everything is `xcodebuild` + `xcrun altool`. No Fastlane.

## Running it

```bash
git checkout -b release && git push -u origin release
```

Afterwards, a release is `git push origin main:release`.

Manual runs (Actions → *iOS Release* → Run workflow) take two optional inputs:

- **marketing_version** — overrides `MARKETING_VERSION` for this build, e.g. `1.0.1`.
  Left empty it uses whatever the project has.
- **skip_upload** — archive, export and validate, but don't upload. Use it to
  check signing works without burning a build number in App Store Connect.

The build number is **the workflow run number**, not the project's
`CURRENT_PROJECT_VERSION`. App Store Connect refuses a build number it has already
seen, and the project's value is a static `1`.

## Secrets to create

Repository → Settings → Secrets and variables → Actions.

| Secret | What it is |
| --- | --- |
| `BUNDLE_IDENTIFIER` | The **release** bundle id. The project itself still carries the placeholder `com.template.use`; the workflow overrides it. |
| `APPSTORE_CONNECT_CERTIFICATE` | Apple Distribution certificate, `.p12`, base64. |
| `APPSTORE_CONNECT_CERTIFICATE_PASSWORD` | The password set when exporting that `.p12`. |
| `APPSTORE_CONNECT_PROVISIONING_PROFILE` | App Store provisioning profile, `.mobileprovision`, base64. |
| `APPSTORE_CONNECT_API_KEY_ID` | Key ID of an App Store Connect API key. |
| `APPSTORE_CONNECT_API_ISSUER_ID` | Issuer ID from the same Keys page. |
| `APPSTORE_CONNECT_API_PRIVATE_KEY` | Contents of the `AuthKey_*.p8`, whole file including the BEGIN/END lines. |
| `SLACK_WEBHOOK_URL` | Optional. Without it the notify step just prints a warning. |

The Team ID (`8H38RT6795`) is in the workflow, not a secret — it is printed
inside every distributed build anyway.

It is **not** the team the project carries (`3ZVTHYFAJY`, in `project.pbxproj`).
Local builds sign with that one, releases with this one. The distribution
certificate and the provisioning profile in the secrets above must both belong to
`8H38RT6795`, or the build fails the profile check.

### Making the certificate and profile

1. Keychain Access → Certificate Assistant → *Request a Certificate From a
   Certificate Authority*, save the `.certSigningRequest` to disk.
2. [developer.apple.com/account/resources/certificates](https://developer.apple.com/account/resources/certificates)
   → **+** → *Apple Distribution* → upload the CSR → download the `.cer`.
3. Double-click the `.cer` to install it, then in Keychain Access find the
   private key under **My Certificates**, right-click → *Export*, save as `.p12`
   with a password. That password is `APPSTORE_CONNECT_CERTIFICATE_PASSWORD`.
4. Profiles → **+** → *App Store Connect* → pick the App ID and the distribution
   certificate → download the `.mobileprovision`.

Both go into secrets base64-encoded:

```bash
base64 -i Certificates.p12 | pbcopy
```

### Making the API key

[App Store Connect → Users and Access → Integrations → App Store Connect API](https://appstoreconnect.apple.com/access/integrations/api)
→ **+**, role **App Manager**. Download the `.p8` — Apple lets you download it
once. The Key ID and Issuer ID are on that page.

## What the workflow does

1. Checks every required secret is present, and stops immediately if one is not.
2. Imports the `.p12` into a throwaway keychain and installs the profile.
3. Verifies the profile's `application-identifier` matches
   `<team>.<BUNDLE_IDENTIFIER>` — a mismatched profile signs fine and is then
   rejected on upload.
4. Runs `.github/scripts/exclude_spm_from_signing.py`, which writes
   `PROVISIONING_PROFILE_SPECIFIER` into the app target's Release config and
   strips it from every other config. See below.
5. Archives Release for `generic/platform=iOS` with manual signing.
6. Exports an App Store `.ipa` and zips the dSYMs.
7. Keeps the `.ipa`, dSYMs and `xcodebuild.log` as run artifacts for 30 days.
8. Validates the `.ipa` against App Store Connect, then uploads it.
9. Deletes the key, profile and keychain from the runner.
10. Posts the result to Slack, if a webhook is configured.

## The SPM signing script

`.github/scripts/exclude_spm_from_signing.py` edits `project.pbxproj` **on the
runner only** — never commit its output.

A build setting passed on the `xcodebuild` command line applies to every target
in the build graph. Swift Package targets are in that graph and cannot carry a
provisioning profile, so `PROVISIONING_PROFILE_SPECIFIER=...` on the command line
breaks the build as soon as the project has a single package dependency. The
script sidesteps that by writing the setting into the app target's Release config
and removing it (and `CODE_SIGN_ENTITLEMENTS`) from all the others.

OracleBrew has **no package dependencies today**, so the script is currently a
one-line insert. It is here so that adding the first one doesn't break releases.

```bash
python3 .github/scripts/exclude_spm_from_signing.py <path/to/project.pbxproj> [profile-uuid] [target-name]
```

It works by regular expression against the `.pbxproj` text, with several fallback
insertion points. That is inherently sensitive to how Xcode formats the file — if
a future Xcode changes the layout, expect this step to fail loudly (it exits
non-zero when it cannot find the config) rather than mis-edit silently. Verified
against Xcode 26.2 and the `PBXFileSystemSynchronizedRootGroup` project format.

## Things it does not do

- **No version bump commit.** `MARKETING_VERSION` stays where the project has it
  unless a run overrides it. Bump it in Xcode when you cut a release.
- **No TestFlight group assignment or release notes.** The build lands in App
  Store Connect and waits for you there.
- **No tests.** Nothing to run yet.

## Notes for later

- No shared scheme existed before this; `OracleBrew.xcscheme` is now committed
  under `xcshareddata`. CI needs it — don't let Xcode drop it.
- `OracleBrew/PrivacyInfo.xcprivacy` declares `NSPrivacyTracking = false` and
  one required-reason API (`UserDefaults`, `CA92.1`, from the two `@AppStorage`
  values). If an analytics or attribution SDK lands, both change: tracking
  becomes true, `NSPrivacyTrackingDomains` needs the endpoints, and the SDK's own
  manifest and signature have to ship with it.
- The App Store listing's privacy questionnaire is filled in separately in App
  Store Connect and has to agree with that manifest.
- `Beacon.request()` raises the App Tracking Transparency prompt from the splash,
  but nothing in the app tracks — no IDFA is read and the only host is our own
  backend. That is a review risk, and it spends the one-per-install prompt before
  there is anything to ask for. Decide before submitting.
- Privacy Policy and Terms have to be linked in the App Store listing too; the
  URLs live in `Backbone/Network/APIConfig.swift`. Those currently point at
  editable Google Docs (`/edit?tab=t.0`) — publish them before submitting.
