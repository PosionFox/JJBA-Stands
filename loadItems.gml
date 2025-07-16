
global.jjsStarChunk = ItemCreate(
    undefined,
    "jjsStarChunk",
    "",
    global.sprStarChunk,
    ItemType.Material,
    ItemSubType.None,
    12,
    0,
    0,
    [
        Item.StarFragment, 1
    ]
);
ItemEdit(global.jjsStarChunk, ItemData.Name, tr("star_chunk_name"));
ItemEdit(global.jjsStarChunk, ItemData.Description, tr("star_chunk_desc"));
StructureAddItem(Structure.Forge, global.jjsStarChunk);

global.jjsSuspiciousArrow = ItemCreate(
    undefined,
    "jjsSuspiciousArrow",
    "",
    global.sprArrow,
    ItemType.Consumable,
    ItemSubType.Potion,
    58,
    0,
    0,
    [
        Item.Wood, 1,
        global.jjsStarChunk, 1
    ],
    ScriptWrap(SusArrowUse),
    60 * 2,
    true
);
ItemEdit(global.jjsSuspiciousArrow, ItemData.Name, tr("susArrowName"));
ItemEdit(global.jjsSuspiciousArrow, ItemData.Description, tr("susArrowDescription"));
StructureAddItem(Structure.Forge, global.jjsSuspiciousArrow);

global.jjsRokakakaFruit = ItemCreate(
    undefined,
    "jjsRokakakaFruit",
    "",
    global.sprRokakaka,
    ItemType.Consumable,
    ItemSubType.Potion,
    12,
    0,
    0,
    undefined,
    ScriptWrap(RokakakaUse),
    60 * 2,
    true
);
ItemEdit(global.jjsRokakakaFruit, ItemData.Name, tr("rokakaka_fruit_name"));
ItemEdit(global.jjsRokakakaFruit, ItemData.Description, tr("rokakaka_fruit_desc"));

global.jjsRokakakaStew = ItemCreate(
    undefined,
    "jjsRokakakaStew",
    "",
    global.sprRokakakaStew,
    ItemType.Consumable,
    ItemSubType.Potion,
    25,
    0,
    0,
    [
        global.jjsRokakakaFruit, 1,
        Item.HotPepper, 1,
        Item.Egg, 2,
        Item.Beet, 5
    ],
    ScriptWrap(RokakakaStewUse),
    60 * 20,
    true
);
ItemEdit(global.jjsRokakakaStew, ItemData.Name, tr("rokakakaStewName"));
ItemEdit(global.jjsRokakakaStew, ItemData.Description, tr("rokakakaStewDescription"));
StructureAddItem(Structure.Cookpot, global.jjsRokakakaStew);

global.jjsRequiemArrow = ItemCreate(
    undefined,
    "jjsRequiemArrow",
    "",
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
ItemEdit(global.jjsRequiemArrow, ItemData.Name, tr("requiemArrowName"));
ItemEdit(global.jjsRequiemArrow, ItemData.Description, tr("requiemArrowDescription"));
StructureAddItem(Structure.Forge, global.jjsRequiemArrow);

global.jjsEternalArrow = ItemCreate(
    undefined,
    "jjsEternalArrow",
    "",
    global.sprEternalArrow,
    ItemType.Consumable,
    ItemSubType.Potion,
    756,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        Item.LegendaryGem, 1,
        Item.OnyxRelic, 1
    ],
    ScriptWrap(EternalArrowUse),
    60 * 10,
    true
);
ItemEdit(global.jjsEternalArrow, ItemData.Name, tr("eternalArrowName"));
ItemEdit(global.jjsEternalArrow, ItemData.Description, tr("eternalArrowDescription"));
StructureAddItem(Structure.Forge, global.jjsEternalArrow);

global.jjsDiscBlueprint = ItemCreate(
    undefined,
    "jjsDiscBlueprint",
    "",
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
ItemEdit(global.jjsDiscBlueprint, ItemData.Name, tr("discBlueprintName"));
ItemEdit(global.jjsDiscBlueprint, ItemData.Description, tr("discBlueprintDescription"));

// stand discs were moved to their stand files
global.jjsBlankDisc = ItemCreate(
    undefined,
    "jjsBlankDisc",
    "",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1,
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
ItemEdit(global.jjsBlankDisc, ItemData.Name, tr("blank_disc_name"));
ItemEdit(global.jjsBlankDisc, ItemData.Description, tr("blank_disc_desc"));
StructureAddItem(Structure.Factory, global.jjsBlankDisc);

global.jjsSteelBall = ItemCreate(
    undefined,
    "jjsSteelBall",
    "",
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
ItemEdit(global.jjsSteelBall, ItemData.Name, tr("steelBallName"));
ItemEdit(global.jjsSteelBall, ItemData.Description, tr("steelBallDescription"));
//StructureAddItem(Structure.Forge, global.jjsSteelBall);

global.jjsAnubis = ItemCreate(
    undefined,
    "jjsAnubis",
    "",
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
ItemEdit(global.jjsAnubis, ItemData.Name, tr("anubisName"));
ItemEdit(global.jjsAnubis, ItemData.Description, tr("anubisDescription"));

global.jjsDiosDiary = ItemCreate(
    undefined,
    "jjsDiosDiary",
    "",
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
ItemEdit(global.jjsDiosDiary, ItemData.Name, tr("diosDiaryName"));
ItemEdit(global.jjsDiosDiary, ItemData.Description, tr("diosDiaryDescription"));

global.jjsDiosBone = ItemCreate(
    undefined,
    "jjsDiosBone",
    "",
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
ItemEdit(global.jjsDiosBone, ItemData.Name, tr("diosBoneName"));
ItemEdit(global.jjsDiosBone, ItemData.Description, tr("diosBoneDescription"));

global.jjsEgyptianCrown = ItemCreate(
    undefined,
    "jjsEgyptianCrown",
    "",
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
ItemEdit(global.jjsEgyptianCrown, ItemData.Name, tr("egyptianCrownName"));
ItemEdit(global.jjsEgyptianCrown, ItemData.Description, tr("egyptianCrownDescription"));

global.jjsSuspiciousBolt = ItemCreate(
    undefined,
    "jjsSuspiciousBolt",
    "",
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
ItemEdit(global.jjsSuspiciousBolt, ItemData.Name, tr("suspiciousBoltName"));
ItemEdit(global.jjsSuspiciousBolt, ItemData.Description, tr("suspiciousBoltDescription"));
StructureAddItem(Structure.Forge, global.jjsSuspiciousBolt);

global.jjsPrisonerSoul = ItemCreate(
    undefined,
    "jjsPrisonerSoul",
    "",
    global.sprPrisonerSoul,
    ItemType.Material,
    ItemSubType.None,
    0,
    0,
    0
);
ItemEdit(global.jjsPrisonerSoul, ItemData.Name, tr("prisoner_soul_name"));
ItemEdit(global.jjsPrisonerSoul, ItemData.Description, tr("prisoner_soul_desc"));

global.jjsGreenBaby = ItemCreate(
    undefined,
    "jjsGreenBaby",
    "",
    global.sprGreenBaby,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    [
        global.jjsDiosBone, 1,
        global.jjsPrisonerSoul, 36
    ],
    ScriptWrap(GreenBabyOnUse)
);
ItemEdit(global.jjsGreenBaby, ItemData.Name, tr("green_baby_name"));
ItemEdit(global.jjsGreenBaby, ItemData.Description, tr("green_baby_desc"));
StructureAddItem(Structure.SpiritCrystal, global.jjsGreenBaby);

global.jjsCamera = ItemCreate(
    undefined,
    "jjsCamera",
    "",
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
ItemEdit(global.jjsCamera, ItemData.Name, tr("camera_name"));
ItemEdit(global.jjsCamera, ItemData.Description, tr("camera_desc"));
StructureAddItem(Structure.Factory, global.jjsCamera);

global.jjsJotarosHat = ItemCreate(
    undefined,
    "jjsJotarosHat",
    "",
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
ItemEdit(global.jjsJotarosHat, ItemData.Name, tr("jotaros_hat_name"));
ItemEdit(global.jjsJotarosHat, ItemData.Description, tr("jotaros_hat_desc"));
StructureAddItem(Structure.SewingStation, global.jjsJotarosHat);

global.jjsStandOrb = ItemCreate(
    undefined,
    "jjsStandOrb",
    "",
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
ItemEdit(global.jjsStandOrb, ItemData.Name, tr("stand_orb_name"));
ItemEdit(global.jjsStandOrb, ItemData.Description, tr("stand_orb_desc"));
StructureAddItem(Structure.SpiritCrystal, global.jjsStandOrb);

#region holy parts

global.jjsHolyHeart = ItemCreate(
    undefined,
    "jjsHolyHeart",
    "",
    global.sprHolyHeart,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyHeartUse),
    5 * 20,
    true
);
ItemEdit(global.jjsHolyHeart, ItemData.Name, tr("holy_heart_name"));
ItemEdit(global.jjsHolyHeart, ItemData.Description, tr("holy_heart_desc"));

global.jjsHolyLeftArm = ItemCreate(
    undefined,
    "jjsHolyLeftArm",
    "",
    global.sprHolyLeftArm,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyLeftArmUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyLeftArm, ItemData.Name, tr("holy_left_arm_name"));
ItemEdit(global.jjsHolyLeftArm, ItemData.Description, tr("holy_left_arm_desc"));

global.jjsHolyRightArm = ItemCreate(
    undefined,
    "jjsHolyRightArm",
    "",
    global.sprHolyRightArm,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyRightArmUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyRightArm, ItemData.Name, tr("holy_right_arm_name"));
ItemEdit(global.jjsHolyRightArm, ItemData.Description, tr("holy_right_arm_desc"));

global.jjsHolyLeftEye = ItemCreate(
    undefined,
    "jjsHolyLeftEye",
    "",
    global.sprHolyEye,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyLeftEyeUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyLeftEye, ItemData.Name, tr("holy_left_eye_name"));
ItemEdit(global.jjsHolyLeftEye, ItemData.Description, tr("holy_left_eye_desc"));

global.jjsHolyRightEye = ItemCreate(
    undefined,
    "jjsHolyRightEye",
    "",
    global.sprHolyEye,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyRightEyeUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyRightEye, ItemData.Name, tr("holy_right_eye_name"));
ItemEdit(global.jjsHolyRightEye, ItemData.Description, tr("holy_right_eye_desc"));

global.jjsHolySpine = ItemCreate(
    undefined,
    "jjsHolySpine",
    "",
    global.sprHolySpine,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolySpineUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolySpine, ItemData.Name, tr("holy_spine_name"));
ItemEdit(global.jjsHolySpine, ItemData.Description, tr("holy_spine_desc"));

global.jjsHolyRibCage = ItemCreate(
    undefined,
    "jjsHolyRibCage",
    "",
    global.sprHolyRibCage,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyRibCageUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyRibCage, ItemData.Name, tr("holy_rib_cage_name"));
ItemEdit(global.jjsHolyRibCage, ItemData.Description, tr("holy_rib_cage_desc"));

global.jjsHolyLeftEar = ItemCreate(
    undefined,
    "jjsHolyLeftEar",
    "",
    global.sprHolyLeftEar,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyLeftEarUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyLeftEar, ItemData.Name, tr("holy_left_ear_name"));
ItemEdit(global.jjsHolyLeftEar, ItemData.Description, tr("holy_left_ear_desc"));

global.jjsHolyRightEar = ItemCreate(
    undefined,
    "jjsHolyRightEar",
    "",
    global.sprHolyRightEar,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyRightEarUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyRightEar, ItemData.Name, tr("holy_right_ear_name"));
ItemEdit(global.jjsHolyRightEar, ItemData.Description, tr("holy_right_ear_desc"));

global.jjsHolyLeftLeg = ItemCreate(
    undefined,
    "jjsHolyLeftLeg",
    "",
    global.sprHolyLeftLeg,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyLeftLegUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyLeftLeg, ItemData.Name, tr("holy_left_leg_name"));
ItemEdit(global.jjsHolyLeftLeg, ItemData.Description, tr("holy_left_leg_desc"));

global.jjsHolyRightLeg = ItemCreate(
    undefined,
    "jjsHolyRightLeg",
    "",
    global.sprHolyRightLeg,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolyRightLegUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolyRightLeg, ItemData.Name, tr("holy_right_leg_name"));
ItemEdit(global.jjsHolyRightLeg, ItemData.Description, tr("holy_right_leg_desc"));

global.jjsHolySkull = ItemCreate(
    undefined,
    "jjsHolySkull",
    "",
    global.sprHolySkull,
    ItemType.Consumable,
    ItemSubType.Potion,
    50,
    0,
    0,
    undefined,
    ScriptWrap(HolySkullUse),
    5 * 20,
    true
)
ItemEdit(global.jjsHolySkull, ItemData.Name, tr("holy_skull_name"));
ItemEdit(global.jjsHolySkull, ItemData.Description, tr("holy_skull_desc"));

#endregion

global.jjsPrayerBeads = ItemCreate(
    undefined,
    "jjsPrayerBeads",
    "",
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
ItemEdit(global.jjsPrayerBeads, ItemData.Name, tr("prayerBeadsName"));
ItemEdit(global.jjsPrayerBeads, ItemData.Description, tr("prayerBeadsDescription"));
StructureAddItem(Structure.Forge, global.jjsPrayerBeads);

global.jjsWeatherReportDisc = ItemCreate(
    undefined,
    "jjsWeatherReportDisc",
    "",
    global.sprWeatherReportDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    333,
    0,
    0,
    undefined,
    ScriptWrap(WeatherReportDiscUse),
    1,
    true
)
ItemEdit(global.jjsWeatherReportDisc, ItemData.Name, tr("weather_report_disc_name"));
ItemEdit(global.jjsWeatherReportDisc, ItemData.Description, tr("weather_report_disc_desc"));

global.jjsWeatherReportMemoryDisc = ItemCreate(
    undefined,
    "jjsWeatherReportMemoryDisc",
    "",
    global.sprWeatherReportDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    333,
    0,
    0,
    undefined,
    ScriptWrap(WeatherReportMemoryDiscUse),
    1,
    true
)
ItemEdit(global.jjsWeatherReportMemoryDisc, ItemData.Name, tr("weather_report_memory_disc_name"));
ItemEdit(global.jjsWeatherReportMemoryDisc, ItemData.Description, tr("weather_report_memory_disc_desc"));


global.arrow_ability_pool =
[
    // common
    [GiveStarPlatinum, global.common_rarity_weight],
    [GiveShadowTheWorld, global.common_rarity_weight],
    [GiveKillerQueen, global.common_rarity_weight],
    [GiveStickyFingers, global.common_rarity_weight],
    [GiveGoldExperience, global.common_rarity_weight],
    [GiveKingCrimson, global.common_rarity_weight],
    [GiveSilverChariot, global.common_rarity_weight],
    [GiveWhiteSnake, global.common_rarity_weight],
    [GiveHierophantGreen, global.common_rarity_weight],
    // uncommon
    [GiveSpg, global.uncommon_rarity_weight],
    [GiveSfg, global.uncommon_rarity_weight],
    [GiveSfr, global.uncommon_rarity_weight],
    [GiveKcg, global.uncommon_rarity_weight],
    [GiveHr, global.uncommon_rarity_weight],
    [GiveGreenSnake, global.uncommon_rarity_weight],
    // rare
    [GiveScova, global.rare_rarity_weight],
    [GiveKca, global.rare_rarity_weight],
    [GiveHb, global.rare_rarity_weight],
    [GiveBlueSnake, global.rare_rarity_weight],
    // epic
    [GiveBs, global.epic_rarity_weight],
    [GiveSpp, global.epic_rarity_weight],
    [GivePurpleSnake, global.epic_rarity_weight],
    // legendary
    [GiveImposter, global.legendary_rarity_weight],
    [GiveKcmo, global.legendary_rarity_weight],
    [GiveDw, global.legendary_rarity_weight],
    [GiveSpova, global.legendary_rarity_weight],
    [GiveYellowSnake, global.legendary_rarity_weight],
    // mythical
    [GiveSpr, global.mythical_rarity_weight],
    [GiveShadow, global.mythical_rarity_weight],
    [GiveKcm, global.mythical_rarity_weight],
    [GiveRedSnake, global.mythical_rarity_weight],
    [GiveP03, global.mythical_rarity_weight],
    // celestial
    [GiveSPOH, global.celestial_rarity_weight],
    [GiveKce, global.celestial_rarity_weight],
    [GiveOrangeSnake, global.celestial_rarity_weight],
    // ultimate
    [GiveSPROH, global.ultimate_rarity_weight],
    [GivePinkSnake, global.ultimate_rarity_weight],
    [GiveWsu, global.ultimate_rarity_weight]
    // bizarre
];

#define WeatherReportDiscUse

if (room != rmGame or instance_exists(STAND))
{
    GainItem(global.jjsWeatherReportDisc);
    exit;
}

GiveWeatherReport(player);

#define WeatherReportMemoryDiscUse

if (room != rmGame or !instance_exists(STAND) or STAND.saveKey != "jjbamWr")
{
    GainItem(global.jjsWeatherReportMemoryDisc);
    exit;
}

STAND.extra_serial_data[? "has_heavy_weather"] = true;

#define StandOrbOnUse

if (instance_exists(STAND))
{
    STAND.stat_points += 100;
}
else GainItem(global.jjsStandOrb, 1);

#define JotarosHatOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamSp")
    {
        RemoveStand(player);
        GiveSPTW(player);
    }
    else GainItem(global.jjsJotarosHat, 1);
}
else GainItem(global.jjsJotarosHat, 1);

#define CameraOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamStw")
    {
        jj_play_audio(global.sndStwEvolve, 5, false);
        var _o = ModObjectSpawn(x, y, 0);
        with (_o)
        {
            timer = 1;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StwTheWorldStep), false);
        }
    }
    else GainItem(global.jjsCamera, 1);
}
else GainItem(global.jjsCamera, 1);

#define GreenBabyOnUse

if (instance_exists(STAND))
{
    if (STAND.saveKey == "jjbamWs")
    {
        // RemoveStand(player);
        // GiveCMoon(player);
        Trace("not yet");
        GainItem(global.jjsGreenBaby, 1);
    }
    else GainItem(global.jjsGreenBaby, 1);
}
else GainItem(global.jjsGreenBaby, 1);

#define SuspiciousBoltUse

trait_give_random(STAND);
DmgPlayer(1, false);

#define EgyptianCrownUse

if (TimeControl.lightState == 0 or TimeControl.lightState == 3)
{
    if (modSubtypeExists("DIO"))
    {
        GainItem(global.jjsEgyptianCrown, 1);
    }
    else
    {
        EnemyDioSpawn();
    }
}
else
{
    GainItem(global.jjsEgyptianCrown, 1);
}

#define DiosBoneUse

GainItem(global.jjsDiosBone, 1);

#define RokakakaStewUse

if (room != rmGame)
{
    GainItem(global.jjsRokakakaStew);
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
            GainItem(global.jjsRokakakaStew);
        }
    }
}
else
{
    GainItem(global.jjsRokakakaStew);
}

#define DiosDiaryUse

if (room != rmGame)
{
    GainItem(global.jjsDiosDiary);
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
        default: GainItem(global.jjsDiosDiary); break;
    }
}
else
{
    GainItem(global.jjsDiosDiary);
}

#define RokakakaUse

if (room != rmGame)
{
    GainItem(global.jjsRokakakaFruit);
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
    GainItem(global.jjsRokakakaFruit);
}

#define PrayerBeadsUse

if (room != rmGame)
{
    GainItem(global.jjsPrayerBeads);
    exit;
}

if (global.pucciSpawned == false)
{
    SpawnPucci("", "");
}
else
{
    GainItem(global.jjsPrayerBeads);
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
GainItem(global.jjsAnubis);

#define SusArrowUse

if (room != rmGame)
{
    GainItem(global.jjsSuspiciousArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveRandomStand();
}
else
{
    GainItem(global.jjsSuspiciousArrow);
}

#define EternalArrowUse

if (room != rmGame)
{
    GainItem(global.jjsEternalArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveRandomStand();
    var _c = random(1);
    if (_c > 0.02)
    {
        GainItem(global.jjsEternalArrow);
    }
}
else
{
    GainItem(global.jjsEternalArrow);
}

#define VerySusArrowUse

if (room != rmGame)
{
    GainItem(global.jjsRequiemArrow);
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
                [GiveKillerQueenBtD, global.common_rarity_weight],
                [GiveSQBTD, global.epic_rarity_weight]
            ]
            script_execute(random_weight(_stands), player);
            Trace(tr("requiemArrowMerge"));
        break;
        case "Gold Experience":
            RemoveStand(player);
            GiveGer(player);
            Trace(tr("requiemArrowMerge"));
        break;
        default:
            Trace(tr("requiemArrowRefuse"));
            GainItem(global.jjsRequiemArrow);
        break;
    }
}
else
{
    GainItem(global.jjsRequiemArrow);
}

#define GiveRandomStand

script_execute(random_weight(global.arrow_ability_pool), player);

#define DiscUse

if (room != rmGame)
{
    GainItem(global.jjsBlankDisc);
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
    GainItem(global.jjsBlankDisc);
}

#define DiscBlueprintUse

ItemEdit(global.jjsBlankDisc, ItemData.Unlocked, true);
global.questPucciBlueprintCompleted = true;

#define HolyHeartUse
if (room != rmGame)
{
    GainItem(global.jjsHolyHeart);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.saveKey)
    {
        case "jjbamTsk":
            STAND.hasAct2 = true;
        break;
        // case "D4C":
        //     STAND.hasHeart = true;
        //     D4CEvolveIfCan();
        // break;
        default:
            Trace(tr("holyPartRefuse"));
            GainItem(global.jjsHolyHeart);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveD4C, global.common_rarity_weight],
        [GivePd4c, global.epic_rarity_weight]
    ]
    script_execute(random_weight(_standPool), player);
}

#define HolyLeftArmUse

if (room != rmGame)
{
    GainItem(global.jjsHolyLeftArm);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.saveKey)
    {
        case "jjbamSpin":
            GiveTusk(player);
        break;
        case "jjbamD4c":
            STAND.hasArm = true;
            D4CEvolveIfCan();
        break;
        case "jjbamPd4c":
            STAND.hasArm = true;
            PD4CEvolveIfCan();
        break;
        default:
            Trace(tr("holyPartRefuse"));
            GainItem(global.jjsHolyLeftArm);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveSoftAndWet, global.common_rarity_weight],
        [GiveSnwg, global.legendary_rarity_weight]
    ]
    script_execute(random_weight(_standPool), player);
}

#define HolyRightArmUse

GainItem(global.jjsHolyRightArm);
Trace(tr("holyPartRefuse"));
exit;

#define HolyLeftEyeUse

if (room != rmGame)
{
    GainItem(global.jjsHolyLeftEye);
    exit;
}

if (instance_exists(STAND))
{
    switch (STAND.saveKey)
    {
        case "jjbamTsk":
            if (STAND.hasAct2)
            {
                STAND.hasAct3 = true;
                STAND.hasAct4 = true;
                STAND.nailsMax = 20;
                STAND.nails += 5;
            }
        exit;
        case "jjbamD4c":
            STAND.hasEye = true;
            D4CEvolveIfCan();
        break;
        case "jjbamPd4c":
            STAND.hasEye = true;
            PD4CEvolveIfCan();
        break;
        default:
            Trace(tr("holyPartRefuse"));
            GainItem(global.jjsHolyLeftEye);
        break;
    }
}
else
{
    var _standPool =
    [
        [GiveTheWorldAU, global.common_rarity_weight],
        [GiveNeo, global.epic_rarity_weight],
        [GiveTwau3000, global.legendary_rarity_weight]
    ]
    script_execute(random_weight(_standPool), player);
}

#define HolyRightEyeUse

GainItem(global.jjsHolyRightEye);
Trace(tr("holyPartRefuse"));
exit;

#define HolySpineUse

GainItem(global.jjsHolySpine);
Trace(tr("holyPartRefuse"));
exit;

#define HolyRibCageUse

GainItem(global.jjsHolyRibCage);
Trace(tr("holyPartRefuse"));
exit;

#define HolyLeftEarUse

GainItem(global.jjsHolyLeftEar);
Trace(tr("holyPartRefuse"));
exit;

#define HolyRightEarUse

GainItem(global.jjsHolyRightEar);
Trace(tr("holyPartRefuse"));
exit;

#define HolyLeftLegUse

GainItem(global.jjsHolyLeftLeg);
Trace(tr("holyPartRefuse"));
exit;

#define HolyRightLegUse

GainItem(global.jjsHolyRightLeg);
Trace(tr("holyPartRefuse"));
exit;

#define HolySkullUse

GainItem(global.jjsHolySkull);
Trace(tr("holyPartRefuse"));
exit;

#define SteelBallUse

if (!modSubtypeExists("steelBall"))
{
    var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
    SteelBallCreate(x, y, _dir, 2 + player.dmg);
}
