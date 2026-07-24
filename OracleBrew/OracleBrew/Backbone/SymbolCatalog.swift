import UIKit

/// The icon and keyword for each cup-reading symbol.
///
/// Split by who owns what: the backend decides *which* symbols a reading has
/// and writes their name and interpretation in the reading's language, so those
/// come over the wire. The keyword and the icon are fixed design vocabulary —
/// they belong to the app, and keeping them here is what lets them be
/// translated at all: the server's symbol table is English-only.
enum SymbolCatalog {
    struct Entry {
        let name: String
        let keyword: String
        /// Asset name. Empty-rendering until the artwork is imported.
        let icon: String

        var hasIcon: Bool { UIImage(named: icon) != nil }
    }

    static func entry(forSlug slug: String) -> Entry? { all[slug] }

    static let all: [String: Entry] = [
        "sun": Entry(name: String(localized: "symbol.sun.name"), keyword: String(localized: "symbol.sun.keyword"), icon: "SymbolSun"),
        "moon": Entry(name: String(localized: "symbol.moon.name"), keyword: String(localized: "symbol.moon.keyword"), icon: "SymbolMoon"),
        "cloud": Entry(name: String(localized: "symbol.cloud.name"), keyword: String(localized: "symbol.cloud.keyword"), icon: "SymbolCloud"),
        "wave": Entry(name: String(localized: "symbol.wave.name"), keyword: String(localized: "symbol.wave.keyword"), icon: "SymbolWave"),
        "star": Entry(name: String(localized: "symbol.star.name"), keyword: String(localized: "symbol.star.keyword"), icon: "SymbolStar"),
        "flower": Entry(name: String(localized: "symbol.flower.name"), keyword: String(localized: "symbol.flower.keyword"), icon: "SymbolFlower"),
        "tree": Entry(name: String(localized: "symbol.tree.name"), keyword: String(localized: "symbol.tree.keyword"), icon: "SymbolTree"),
        "mountain": Entry(name: String(localized: "symbol.mountain.name"), keyword: String(localized: "symbol.mountain.keyword"), icon: "SymbolMountain"),
        "sprout": Entry(name: String(localized: "symbol.sprout.name"), keyword: String(localized: "symbol.sprout.keyword"), icon: "SymbolSprout"),
        "snowflake": Entry(name: String(localized: "symbol.snowflake.name"), keyword: String(localized: "symbol.snowflake.keyword"), icon: "SymbolSnowflake"),
        "mushroom": Entry(name: String(localized: "symbol.mushroom.name"), keyword: String(localized: "symbol.mushroom.keyword"), icon: "SymbolMushroom"),
        "bird": Entry(name: String(localized: "symbol.bird.name"), keyword: String(localized: "symbol.bird.keyword"), icon: "SymbolBird"),
        "butterfly": Entry(name: String(localized: "symbol.butterfly.name"), keyword: String(localized: "symbol.butterfly.keyword"), icon: "SymbolButterfly"),
        "beetle": Entry(name: String(localized: "symbol.beetle.name"), keyword: String(localized: "symbol.beetle.keyword"), icon: "SymbolBeetle"),
        "pig": Entry(name: String(localized: "symbol.pig.name"), keyword: String(localized: "symbol.pig.keyword"), icon: "SymbolPig"),
        "dog": Entry(name: String(localized: "symbol.dog.name"), keyword: String(localized: "symbol.dog.keyword"), icon: "SymbolDog"),
        "snake": Entry(name: String(localized: "symbol.snake.name"), keyword: String(localized: "symbol.snake.keyword"), icon: "SymbolSnake"),
        "fish": Entry(name: String(localized: "symbol.fish.name"), keyword: String(localized: "symbol.fish.keyword"), icon: "SymbolFish"),
        "horse": Entry(name: String(localized: "symbol.horse.name"), keyword: String(localized: "symbol.horse.keyword"), icon: "SymbolHorse"),
        "eagle": Entry(name: String(localized: "symbol.eagle.name"), keyword: String(localized: "symbol.eagle.keyword"), icon: "SymbolEagle"),
        "cat": Entry(name: String(localized: "symbol.cat.name"), keyword: String(localized: "symbol.cat.keyword"), icon: "SymbolCat"),
        "rabbit": Entry(name: String(localized: "symbol.rabbit.name"), keyword: String(localized: "symbol.rabbit.keyword"), icon: "SymbolRabbit"),
        "turtle": Entry(name: String(localized: "symbol.turtle.name"), keyword: String(localized: "symbol.turtle.keyword"), icon: "SymbolTurtle"),
        "elephant": Entry(name: String(localized: "symbol.elephant.name"), keyword: String(localized: "symbol.elephant.keyword"), icon: "SymbolElephant"),
        "heart": Entry(name: String(localized: "symbol.heart.name"), keyword: String(localized: "symbol.heart.keyword"), icon: "SymbolHeart"),
        "gift": Entry(name: String(localized: "symbol.gift.name"), keyword: String(localized: "symbol.gift.keyword"), icon: "SymbolGift"),
        "plane": Entry(name: String(localized: "symbol.plane.name"), keyword: String(localized: "symbol.plane.keyword"), icon: "SymbolPlane"),
        "broken_heart": Entry(name: String(localized: "symbol.broken_heart.name"), keyword: String(localized: "symbol.broken_heart.keyword"), icon: "SymbolBrokenHeart"),
        "fire": Entry(name: String(localized: "symbol.fire.name"), keyword: String(localized: "symbol.fire.keyword"), icon: "SymbolFire"),
        "crown": Entry(name: String(localized: "symbol.crown.name"), keyword: String(localized: "symbol.crown.keyword"), icon: "SymbolCrown"),
        "ring": Entry(name: String(localized: "symbol.ring.name"), keyword: String(localized: "symbol.ring.keyword"), icon: "SymbolRing"),
        "car": Entry(name: String(localized: "symbol.car.name"), keyword: String(localized: "symbol.car.keyword"), icon: "SymbolCar"),
        "book": Entry(name: String(localized: "symbol.book.name"), keyword: String(localized: "symbol.book.keyword"), icon: "SymbolBook"),
        "sword": Entry(name: String(localized: "symbol.sword.name"), keyword: String(localized: "symbol.sword.keyword"), icon: "SymbolSword"),
        "key": Entry(name: String(localized: "symbol.key.name"), keyword: String(localized: "symbol.key.keyword"), icon: "SymbolKey"),
        "lightning": Entry(name: String(localized: "symbol.lightning.name"), keyword: String(localized: "symbol.lightning.keyword"), icon: "SymbolLightning"),
        "lock": Entry(name: String(localized: "symbol.lock.name"), keyword: String(localized: "symbol.lock.keyword"), icon: "SymbolLock"),
        "chain": Entry(name: String(localized: "symbol.chain.name"), keyword: String(localized: "symbol.chain.keyword"), icon: "SymbolChain"),
        "tulip": Entry(name: String(localized: "symbol.tulip.name"), keyword: String(localized: "symbol.tulip.keyword"), icon: "SymbolTulip"),
        "trophy": Entry(name: String(localized: "symbol.trophy.name"), keyword: String(localized: "symbol.trophy.keyword"), icon: "SymbolTrophy"),
        "diamond": Entry(name: String(localized: "symbol.diamond.name"), keyword: String(localized: "symbol.diamond.keyword"), icon: "SymbolDiamond"),
        "house": Entry(name: String(localized: "symbol.house.name"), keyword: String(localized: "symbol.house.keyword"), icon: "SymbolHouse"),
        "anchor": Entry(name: String(localized: "symbol.anchor.name"), keyword: String(localized: "symbol.anchor.keyword"), icon: "SymbolAnchor"),
        "castle": Entry(name: String(localized: "symbol.castle.name"), keyword: String(localized: "symbol.castle.keyword"), icon: "SymbolCastle"),
        "bell": Entry(name: String(localized: "symbol.bell.name"), keyword: String(localized: "symbol.bell.keyword"), icon: "SymbolBell"),
        "boat": Entry(name: String(localized: "symbol.boat.name"), keyword: String(localized: "symbol.boat.keyword"), icon: "SymbolBoat"),
        "wheat": Entry(name: String(localized: "symbol.wheat.name"), keyword: String(localized: "symbol.wheat.keyword"), icon: "SymbolWheat"),
        "bridge": Entry(name: String(localized: "symbol.bridge.name"), keyword: String(localized: "symbol.bridge.keyword"), icon: "SymbolBridge"),
        "clock": Entry(name: String(localized: "symbol.clock.name"), keyword: String(localized: "symbol.clock.keyword"), icon: "SymbolClock"),
        "door": Entry(name: String(localized: "symbol.door.name"), keyword: String(localized: "symbol.door.keyword"), icon: "SymbolDoor"),
        "phone": Entry(name: String(localized: "symbol.phone.name"), keyword: String(localized: "symbol.phone.keyword"), icon: "SymbolPhone"),
        "horseshoe": Entry(name: String(localized: "symbol.horseshoe.name"), keyword: String(localized: "symbol.horseshoe.keyword"), icon: "SymbolHorseshoe"),
        "feather": Entry(name: String(localized: "symbol.feather.name"), keyword: String(localized: "symbol.feather.keyword"), icon: "SymbolFeather"),
        "light_bulb": Entry(name: String(localized: "symbol.light_bulb.name"), keyword: String(localized: "symbol.light_bulb.keyword"), icon: "SymbolLightBulb"),
        "money": Entry(name: String(localized: "symbol.money.name"), keyword: String(localized: "symbol.money.keyword"), icon: "SymbolMoney"),
        "envelope": Entry(name: String(localized: "symbol.envelope.name"), keyword: String(localized: "symbol.envelope.keyword"), icon: "SymbolEnvelope"),
        "suitcase": Entry(name: String(localized: "symbol.suitcase.name"), keyword: String(localized: "symbol.suitcase.keyword"), icon: "SymbolSuitcase"),
        "hourglass": Entry(name: String(localized: "symbol.hourglass.name"), keyword: String(localized: "symbol.hourglass.keyword"), icon: "SymbolHourglass"),
        "spiral": Entry(name: String(localized: "symbol.spiral.name"), keyword: String(localized: "symbol.spiral.keyword"), icon: "SymbolSpiral"),
        "eye": Entry(name: String(localized: "symbol.eye.name"), keyword: String(localized: "symbol.eye.keyword"), icon: "SymbolEye"),
        "bow": Entry(name: String(localized: "symbol.bow.name"), keyword: String(localized: "symbol.bow.keyword"), icon: "SymbolBow"),
        "man": Entry(name: String(localized: "symbol.man.name"), keyword: String(localized: "symbol.man.keyword"), icon: "SymbolMan"),
        "woman": Entry(name: String(localized: "symbol.woman.name"), keyword: String(localized: "symbol.woman.keyword"), icon: "SymbolWoman"),
        "child": Entry(name: String(localized: "symbol.child.name"), keyword: String(localized: "symbol.child.keyword"), icon: "SymbolChild"),
        "couple": Entry(name: String(localized: "symbol.couple.name"), keyword: String(localized: "symbol.couple.keyword"), icon: "SymbolCouple"),
        "crossroads": Entry(name: String(localized: "symbol.crossroads.name"), keyword: String(localized: "symbol.crossroads.keyword"), icon: "SymbolCrossroads"),
        "spiral_path": Entry(name: String(localized: "symbol.spiral_path.name"), keyword: String(localized: "symbol.spiral_path.keyword"), icon: "SymbolSpiralPath"),
        "compass": Entry(name: String(localized: "symbol.compass.name"), keyword: String(localized: "symbol.compass.keyword"), icon: "SymbolCompass"),
    ]
}
