
global.jjStarShard = ItemCreate(
    undefined,
    "Star shard",
    "obtained from rocks or crafted, can be used to make stand arrows.",
    global.sprStarShard,
    ItemType.Material,
    ItemSubType.None,
    12,
    0,
    0,
    [
        Item.StarFragment, 1
    ]
);

global.jjbamArrow = ItemCreate(
    undefined,
    Localize("susArrowName"),
    Localize("susArrowDescription"),
    global.sprArrow,
    ItemType.Consumable,
    ItemSubType.Potion,
    58,
    0,
    0,
    [
        Item.Wood, 1,
        global.jjStarShard, 1
    ],
    ScriptWrap(SusArrowUse),
    60 * 2,
    true
);

global.jjbamRokakaka = ItemCreate(
    undefined,
    Localize("rokakakaName"),
    Localize("rokakakaDescription"),
    global.sprRokakaka,
    ItemType.Consumable,
    ItemSubType.Potion,
    32,
    0,
    0,
    undefined,
    ScriptWrap(RokakakaUse),
    60 * 2,
    true
);

global.jjRokakakaStew = ItemCreate(
    undefined,
    Localize("rokakakaStewName"),
    Localize("rokakakaStewDescription"),
    global.sprRokakakaStew,
    ItemType.Consumable,
    ItemSubType.Potion,
    61,
    0,
    0,
    [
        global.jjbamRokakaka, 1,
        Item.HotPepper, 1,
        Item.Egg, 2,
        Item.Beet, 5
    ],
    ScriptWrap(RokakakaStewUse),
    60 * 20,
    true
);

global.jjbamRequiem = ItemCreate(
    undefined,
    Localize("requiemArrowName"),
    Localize("requiemArrowDescription"),
    global.sprArrowBeetle,
    ItemType.Consumable,
    ItemSubType.Potion,
    3489,
    0,
    0,
    [
        Item.Wood, 1,
        Item.CosmicSteel, 1
    ],
    ScriptWrap(VerySusArrowUse),
    60 * 20,
    true
);

global.jjbamEternalArrow = ItemCreate(
    undefined,
    Localize("eternalArrowName"),
    Localize("eternalArrowDescription"),
    global.sprEternalArrow,
    ItemType.Consumable,
    ItemSubType.Potion,
    756,
    0,
    0,
    [
        global.jjbamArrow, 1,
        Item.LegendaryGem, 1,
        Item.OnyxRelic, 1
    ],
    ScriptWrap(EternalArrowUse),
    60 * 10,
    true
);

global.jjDiscBlueprint = ItemCreate(
    undefined,
    Localize("discBlueprintName"),
    Localize("discBlueprintDescription"),
    global.sprDiscBlueprint,
    ItemType.Consumable,
    ItemSubType.Potion,
    5,
    0,
    0,
    undefined,
    ScriptWrap(DiscBlueprintUse),
    60 * 4,
    true
);

// stand discs were moved to their stand files
global.jjbamDisc = ItemCreate(
    undefined,
    Localize("discName"),
    Localize("discDescription"),
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    333,
    0,
    0,
    [
        Item.GoldIngot, 1,
        Item.Plastic, 1,
    ],
    ScriptWrap(EventHandler),
    60 * 4,
    false
);

global.jjbamSteelBall = ItemCreate(
    undefined,
    Localize("steelBallName"),
    Localize("steelBallDescription"),
    global.sprSteelBall,
    ItemType.Gear,
    ItemSubType.None,
    0,
    0,
    0,
    [
        Item.GoldIngot, 4,
        Item.RoyalSteel, 1
    ],
    ScriptWrap(SteelBallUse),
    60 * 20,
    true
);

global.jjbamAnubis = ItemCreate(
    undefined,
    Localize("anubisName"),
    Localize("anubisDescription"),
    global.sprAnubis,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    undefined,
    ScriptWrap(AnubisUse),
    0,
    true,
    5
);

global.jjDiosDiary = ItemCreate(
    undefined,
    Localize("diosDiaryName"),
    Localize("diosDiaryDescription"),
    global.sprDiosDiary,
    ItemType.Consumable,
    ItemSubType.Potion,
    1000,
    0,
    0,
    undefined,
    ScriptWrap(DiosDiaryUse),
    60 * 4,
    false
);

global.jjDiosBone = ItemCreate(
    undefined,
    Localize("diosBoneName"),
    Localize("diosBoneDescription"),
    global.sprDiosBone,
    ItemType.Consumable,
    ItemSubType.Potion,
    1000,
    0,
    0,
    undefined,
    ScriptWrap(DiosBoneUse),
    60 * 4,
    false
);

global.jjEgyptianCrown = ItemCreate(
    undefined,
    Localize("egyptianCrownName"),
    Localize("egyptianCrownDescription"),
    global.sprEgyptianCrown,
    ItemType.Consumable,
    ItemSubType.Potion,
    812,
    0,
    0,
    [
        Item.GoldIngot, 100,
        Item.Topaz, 2
    ],
    ScriptWrap(EgyptianCrownUse),
    60 * 30,
    true
);

global.jjSuspiciousBolt = ItemCreate(
    undefined,
    Localize("suspiciousBoltName"),
    Localize("suspiciousBoltDescription"),
    global.sprSuspiciousBolt,
    ItemType.Consumable,
    ItemSubType.Potion,
    250,
    0,
    0,
    [
        Item.Wood, 1,
        Item.Ruby, 25,
        Item.Emerald, 25,
        Item.Topaz, 25,
        Item.Amethyst, 25
    ],
    ScriptWrap(SuspiciousBoltUse),
    60 * 5,
    true
);

global.jjPrisonerSoul = ItemCreate(
    undefined,
    "Prisoner Soul",
    "the soul of an evil person.",
    global.sprPrisonerSoul,
    ItemType.Material,
    ItemSubType.None,
    0,
    0,
    0
);

global.jjGreenBaby = ItemCreate(
    undefined,
    "green baby",
    "a strange bizarre infant.",
    global.sprGreenBaby,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [
        global.jjDiosBone, 1,
        global.jjPrisonerSoul, 36
    ],
    ScriptWrap(GreenBabyOnUse)
);
StructureAddItem(Structure.Forge, global.jjGreenBaby);

global.jjCamera = ItemCreate(
    undefined,
    "camera",
    "a device for capturing landscapes.",
    global.sprCamera,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [
        Item.Electronics, 1,
        Item.RoyalSteel, 5,
        Item.Plastic, 10,
        Item.Glass, 25
    ],
    ScriptWrap(CameraOnUse),
    60 * 60
);
StructureAddItem(Structure.Factory, global.jjCamera);

global.jjJotarosHat = ItemCreate(
    undefined,
    "jotaro's hat",
    "a peculiar looking hat.",
    global.sprJotarosHat,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [
        Item.GoldIngot, 5,
        Item.Thread, 50
    ],
    ScriptWrap(JotarosHatOnUse),
    60 * 60
);
StructureAddItem(Structure.SewingStation, global.jjJotarosHat);

global.jjStandOrb = ItemCreate(
    undefined,
    "stand orb",
    "used for increasing stand power.",
    global.sprStandOrb,
    ItemType.Consumable,
    ItemSubType.None,
    50000,
    0,
    0,
    [
        Item.StarFragment, 5,
        Item.OnyxRelic, 5,
        Item.CosmicSteel, 25
    ],
    ScriptWrap(StandOrbOnUse),
    60 * 60
);
StructureAddItem(Structure.SewingStation, global.jjJotarosHat);

#region holy parts

global.jjbamHeart = ItemCreate(
    undefined,
    Localize("heartName"),
    Localize("heartDescription"),
    global.sprHeart,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HeartUse),
    5 * 20,
    true
);

global.jjbamEye = ItemCreate(
    undefined,
    Localize("eyeName"),
    Localize("eyeDescription"),
    global.sprEye,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(EyeUse),
    5 * 20,
    true
)

global.jjbamLeftArm = ItemCreate(
    undefined,
    Localize("leftArmName"),
    Localize("leftArmDescription"),
    global.sprLeftArm,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(LeftArmUse),
    5 * 20,
    true
)

#endregion

global.jjPrayerBeads = ItemCreate(
    undefined,
    Localize("prayerBeadsName"),
    Localize("prayerBeadsDescription"),
    global.sprPrayerBeads,
    ItemType.Consumable,
    ItemSubType.Potion,
    815,
    0,
    0,
    [
        Item.SpiritOrb, 1,
        Item.RoyalSteel, 5,
        Item.Thread, 1
    ],
    ScriptWrap(PrayerBeadsUse),
    5 * 60,
    true
)
StructureAddItem(Structure.Forge, global.jjPrayerBeads);

global.common_arrow_weight = 128;
global.uncommon_arrow_weight = 64;
global.rare_arrow_weight = 32;
global.epic_arrow_weight = 16;
global.legendary_arrow_weight = 8;
global.mythical_arrow_weight = 4;
global.ascended_arrow_weight = 2;
global.ultimate_arrow_weight = 1;

global.arrow_ability_pool =
[
    // common
    [GiveStarPlatinum, global.common_arrow_weight],
    [GiveShadowTheWorld, global.common_arrow_weight],
    [GiveKillerQueen, global.common_arrow_weight],
    [GiveStickyFingers, global.common_arrow_weight],
    [GiveGoldExperience, global.common_arrow_weight],
    [GiveKingCrimson, global.common_arrow_weight],
    [GiveSilverChariot, global.common_arrow_weight],
    [GiveWhiteSnake, global.common_arrow_weight],
    [GiveHierophantGreen, global.common_arrow_weight],
    // uncommon
    [GiveSpg, global.uncommon_arrow_weight],
    [GiveSfg, global.uncommon_arrow_weight],
    [GiveSfr, global.uncommon_arrow_weight],
    [GiveKcg, global.uncommon_arrow_weight],
    [GiveHr, global.uncommon_arrow_weight],
    [GiveGreenSnake, global.uncommon_arrow_weight],
    // rare
    [GiveScova, global.rare_arrow_weight],
    [GiveKca, global.rare_arrow_weight],
    [GiveHb, global.rare_arrow_weight],
    [GiveBlueSnake, global.rare_arrow_weight],
    // epic
    [GiveBs, global.epic_arrow_weight],
    [GiveSpp, global.epic_arrow_weight],
    [GivePurpleSnake, global.epic_arrow_weight],
    // legendary
    [GiveImposter, global.legendary_arrow_weight],
    [GiveKcmo, global.legendary_arrow_weight],
    [GiveDw, global.legendary_arrow_weight],
    [GiveSpova, global.legendary_arrow_weight],
    [GiveYellowSnake, global.legendary_arrow_weight],
    // mythical
    [GiveSpr, global.mythical_arrow_weight],
    [GiveShadow, global.mythical_arrow_weight],
    [GiveKcm, global.mythical_arrow_weight],
    [GiveRedSnake, global.mythical_arrow_weight],
    // ascended
    [GiveSPOH, global.ascended_arrow_weight],
    [GiveKce, global.ascended_arrow_weight],
    [GiveOrangeSnake, global.ascended_arrow_weight],
    // ultimate
    [GiveSPROH, global.ultimate_arrow_weight],
    [GivePinkSnake, global.ultimate_arrow_weight]
];

StructureAddItem(Structure.Forge, global.jjStarShard);
StructureAddItem(Structure.Forge, global.jjbamArrow);
StructureAddItem(Structure.Forge, global.jjSuspiciousBolt);
StructureAddItem(Structure.Forge, global.jjbamEternalArrow);
StructureAddItem(Structure.Forge, global.jjbamRequiem);
//StructureAddItem(Structure.Forge, global.jjbamSteelBall);

StructureAddItem(Structure.Factory, global.jjbamDisc);

StructureAddItem(Structure.Cookpot, global.jjRokakakaStew);

StructureAddItem(Structure.SpiritCrystal, global.jjStandOrb);

#define StandOrbOnUse

if (instance_exists(STAND))
{
    STAND.stat_points += 100;
}
else GainItem(global.jjStandOrb, 1);

#define JotarosHatOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamSp")
    {
        RemoveStand(player);
        GiveSPTW(player);
    }
    else GainItem(global.jjJotarosHat, 1);
}
else GainItem(global.jjJotarosHat, 1);

#define CameraOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamStw")
    {
        RemoveStand(player);
        GiveTheWorld(player);
    }
    else GainItem(global.jjCamera, 1);
}
else GainItem(global.jjCamera, 1);

#define GreenBabyOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamWs")
    {
        // RemoveStand(player);
        // GiveCMoon(player);
        Trace("not yet");
        GainItem(global.jjGreenBaby, 1);
    }
    else GainItem(global.jjGreenBaby, 1);
}
else GainItem(global.jjGreenBaby, 1);

#define SuspiciousBoltUse

trait_give_random(STAND);
DmgPlayer(1, false);

#define EgyptianCrownUse

if (TimeControl.lightState == 0 or TimeControl.lightState == 3)
{
    if (modSubtypeExists("DIO"))
    {
        GainItem(global.jjEgyptianCrown, 1);
    }
    else
    {
        EnemyDioSpawn();
    }
}
else
{
    GainItem(global.jjEgyptianCrown, 1);
}

#define DiosBoneUse

GainItem(global.jjDiosBone, 1);

#define RokakakaStewUse

if (room != rmGame)
{
    GainItem(global.jjRokakakaStew);
    exit;
}

if (instance_exists(STAND))
{
    if (STAND.discType != noone)
    {
        DmgPlayer(1, false);
        RemoveStand(player);
        var _c = random(1);
        if (_c > 0.04)
        {
            GainItem(global.jjRokakakaStew);
        }
    }
}
else
{
    GainItem(global.jjRokakakaStew);
}

#define DiosDiaryUse

if (room != rmGame)
{
    GainItem(global.jjDiosDiary);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "The World":
            GiveTWOH(player);
        break;
        case "The World Retro":
            GiveTwroh(player);
        break;
        case "The World Runic":
            GiveTwruoh(player);
        break;
        default: GainItem(global.jjDiosDiary); break;
    }
}
else
{
    GainItem(global.jjDiosDiary);
}

#define RokakakaUse

if (room != rmGame)
{
    GainItem(global.jjbamRokakaka);
    exit;
}

if (instance_exists(STAND))
{
    if (STAND.discType != noone)
    {
        DmgPlayer(1, false);
        RemoveStand(player);
    }
}
else
{
    GainItem(global.jjbamRokakaka);
}

#define PrayerBeadsUse

if (room != rmGame)
{
    GainItem(global.jjPrayerBeads);
    exit;
}

if (global.pucciSpawned == false)
{
    SpawnPucci("", "");
}
else
{
    GainItem(global.jjPrayerBeads);
}

#define AnubisUse

var _dir = point_direction(x, y, mouse_x, mouse_y);

var _p = ProjectileCreate(x, y);
with (_p)
{
    sprite_index = global.sprHorizontalSlash;
    despawnFade = false;
    despawnTime = 0.1;
    damage = 5;
    distance = 24;
    direction = _dir;
    stationary = true;
    destroyOnImpact = false;
}
GainItem(global.jjbamAnubis);

#define SusArrowUse

if (room != rmGame)
{
    GainItem(global.jjbamArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveRandomStand();
}
else
{
    GainItem(global.jjbamArrow);
}

#define EternalArrowUse

if (room != rmGame)
{
    GainItem(global.jjbamEternalArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveRandomStand();
    var _c = random(1);
    if (_c > 0.02)
    {
        GainItem(global.jjbamEternalArrow);
    }
}
else
{
    GainItem(global.jjbamEternalArrow);
}

#define VerySusArrowUse

if (room != rmGame)
{
    GainItem(global.jjbamRequiem);
    exit;
}

if (instance_exists(STAND))
{
    DmgPlayer(1, false);
    switch (STAND.name)
    {
        case "Killer Queen":
            RemoveStand(player);
            var _stands = [
                [GiveKillerQueenBtD, 30],
                [GiveSQBTD, 1]
            ]
            script_execute(random_weight(_stands), player);
            Trace(Localize("requiemArrowMerge"));
        break;
        case "Gold Experience":
            RemoveStand(player);
            GiveGer(player);
            Trace(Localize("requiemArrowMerge"));
        break;
        default:
            Trace(Localize("requiemArrowRefuse"));
            GainItem(global.jjbamRequiem);
        break;
    }
}
else
{
    GainItem(global.jjbamRequiem);
}

#define GiveRandomStand

script_execute(random_weight(global.arrow_ability_pool), player);

#define DiscUse

if (room != rmGame)
{
    GainItem(global.jjbamDisc);
    exit;
}

if (instance_exists(STAND))
{
    if (STAND.discType != noone)
    {
        DmgPlayer(1, false);
        GainItem(STAND.discType);
        RemoveStand(player);
    }
}
else
{
    GainItem(global.jjbamDisc);
}

#define DiscBlueprintUse

ItemEdit(global.jjbamDisc, ItemData.Unlocked, true);
global.questPucciBlueprintCompleted = true;

#define LeftArmUse

if (room != rmGame)
{
    GainItem(global.jjbamLeftArm);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Spin":
            GiveTusk(player);
        break;
        case "Dirty Deeds Done Dirt Cheap":
            STAND.hasArm = true;
            D4CEvolveIfCan();
        break;
        case "Patriot D4C":
            STAND.hasArm = true;
            PD4CEvolveIfCan();
        break;
        default:
            Trace(Localize("holyPartRefuse"));
            GainItem(global.jjbamLeftArm);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveSoftAndWet, 100],
        [GiveSnwg, 5]
    ]
    script_execute(random_weight(_standPool), player);
}

#define HeartUse
if (room != rmGame)
{
    GainItem(global.jjbamHeart);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Tusk":
            STAND.hasAct2 = true;
        break;
        // case "D4C":
        //     STAND.hasHeart = true;
        //     D4CEvolveIfCan();
        // break;
        default:
            Trace(Localize("holyPartRefuse"));
            GainItem(global.jjbamHeart);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveD4C, 100],
        [GivePd4c, 12]
    ]
    script_execute(random_weight(_standPool), player);
}

#define EyeUse

if (room != rmGame)
{
    GainItem(global.jjbamEye);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Tusk":
            if (STAND.hasAct2)
            {
                STAND.hasAct3 = true;
                STAND.hasAct4 = true;
                STAND.nailsMax = 20;
                STAND.nails += 5;
            }
        exit;
        case "Dirty Deeds Done Dirt Cheap":
            STAND.hasEye = true;
            D4CEvolveIfCan();
        break;
        case "Patriot D4C":
            STAND.hasEye = true;
            PD4CEvolveIfCan();
        break;
        default:
            Trace(Localize("holyPartRefuse"));
            GainItem(global.jjbamEye);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveTheWorldAU, 100],
        [GiveNeo, 12],
        [GiveTwau3000, 5]
    ]
    script_execute(random_weight(_standPool), player);
}

#define SteelBallUse

if (!modSubtypeExists("steelBall"))
{
    var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
    SteelBallCreate(x, y, _dir, 2 + player.dmg);
}
