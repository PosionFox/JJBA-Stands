
#region shards

global.jjsCommonShard = ItemCreate(
    undefined,
    "jjsCommonShard",
    "",
    global.sprCommonShard,
    ItemType.Material,
    ItemSubType.None,
    4,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsCommonShard, ItemData.Name, tr("shardName") + " (" + tr("commonName") + ")");
ItemEdit(global.jjsCommonShard, ItemData.Description, tr("shardDescription"));

global.jjsUncommonShard = ItemCreate(
    undefined,
    "jjsUncommonShard",
    "",
    global.sprUncommonShard,
    ItemType.Material,
    ItemSubType.None,
    8,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsUncommonShard, ItemData.Name, tr("shardName") + " (" + tr("uncommonName") + ")");
ItemEdit(global.jjsUncommonShard, ItemData.Description, tr("shardDescription"));

global.jjsRareShard = ItemCreate(
    undefined,
    "jjsRareShard",
    "",
    global.sprRareShard,
    ItemType.Material,
    ItemSubType.None,
    16,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsRareShard, ItemData.Name, tr("shardName") + " (" + tr("rareName") + ")");
ItemEdit(global.jjsRareShard, ItemData.Description, tr("shardDescription"));

global.jjsEpicShard = ItemCreate(
    undefined,
    "jjsEpicShard",
    "",
    global.sprEpicShard,
    ItemType.Material,
    ItemSubType.None,
    32,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsEpicShard, ItemData.Name, tr("shardName") + " (" + tr("epicName") + ")");
ItemEdit(global.jjsEpicShard, ItemData.Description, tr("shardDescription"));

global.jjsLegendaryShard = ItemCreate(
    undefined,
    "jjsLegendaryShard",
    "",
    global.sprLegendaryShard,
    ItemType.Material,
    ItemSubType.None,
    64,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsLegendaryShard, ItemData.Name, tr("shardName") + " (" + tr("legendaryName") + ")");
ItemEdit(global.jjsLegendaryShard, ItemData.Description, tr("shardDescription"));

global.jjsMythicalShard = ItemCreate(
    undefined,
    "jjsMythicalShard",
    "",
    global.sprMythicalShard,
    ItemType.Material,
    ItemSubType.None,
    128,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsMythicalShard, ItemData.Name, tr("shardName") + " (" + tr("mythicalName") + ")");
ItemEdit(global.jjsMythicalShard, ItemData.Description, tr("shardDescription"));

global.jjsCelestialShard = ItemCreate(
    undefined,
    "jjsCelestialShard",
    "",
    global.sprCelestialShard,
    ItemType.Material,
    ItemSubType.None,
    256,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsCelestialShard, ItemData.Name, tr("shardName") + " (" + tr("celestialName") + ")");
ItemEdit(global.jjsCelestialShard, ItemData.Description, tr("shardDescription"));

global.jjsUltimateShard = ItemCreate(
    undefined,
    "jjsUltimateShard",
    "",
    global.sprUltimateShard,
    ItemType.Material,
    ItemSubType.None,
    512,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsUltimateShard, ItemData.Name, tr("shardName") + " (" + tr("ultimateName") + ")");
ItemEdit(global.jjsUltimateShard, ItemData.Description, tr("shardDescription"));

#endregion

#region concentrated arrows

global.jjsCommonConcentratedArrow = ItemCreate(
    undefined,
    "jjsCommonConcentratedArrow",
    "",
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 1,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsCommonShard, 64
    ],
    ScriptWrap(GrantCommonAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsCommonConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("commonName") + ")");
ItemEdit(global.jjsCommonConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsUncommonConcentratedArrow = ItemCreate(
    undefined,
    "jjsUncommonConcentratedArrow",
    "",
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 2,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsUncommonShard, 32
    ],
    ScriptWrap(GrantUncommonAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsUncommonConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("uncommonName") + ")");
ItemEdit(global.jjsUncommonConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsRareConcentratedArrow = ItemCreate(
    undefined,
    "jjsRareConcentratedArrow",
    "",
    global.sprRareConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 3,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsRareShard, 16
    ],
    ScriptWrap(GrantRareAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsRareConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("rareName") + ")");
ItemEdit(global.jjsRareConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsEpicConcentratedArrow = ItemCreate(
    undefined,
    "jjsEpicConcentratedArrow",
    "",
    global.sprEpicConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 4,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsEpicShard, 8
    ],
    ScriptWrap(GrantEpicAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsEpicConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("epicName") + ")");
ItemEdit(global.jjsEpicConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsLegendaryConcentratedArrow = ItemCreate(
    undefined,
    "jjsLegendaryConcentratedArrow",
    "",
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 5,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsLegendaryShard, 4
    ],
    ScriptWrap(GrantLegendaryAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsLegendaryConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("legendaryName") + ")");
ItemEdit(global.jjsLegendaryConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsMythicalConcentratedArrow = ItemCreate(
    undefined,
    "jjsMythicalConcentratedArrow",
    "",
    global.sprMythicalConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 6,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsMythicalShard, 3
    ],
    ScriptWrap(GrantMythicalAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsMythicalConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("mythicalName") + ")");
ItemEdit(global.jjsMythicalConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsCelestialConcentratedArrow = ItemCreate(
    undefined,
    "jjsCelestialConcentratedArrow",
    "",
    global.sprCelestialConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 7,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsCelestialShard, 2
    ],
    ScriptWrap(GrantCelestialAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsCelestialConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("celestialName") + ")");
ItemEdit(global.jjsCelestialConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

global.jjsUltimateConcentratedArrow = ItemCreate(
    undefined,
    "jjsUltimateConcentratedArrow",
    "",
    global.sprUltimateConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjsSuspiciousArrow, 1,
        global.jjsUltimateShard, 1
    ],
    ScriptWrap(GrantUltimateAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsUltimateConcentratedArrow, ItemData.Name, tr("concentratedArrowName") + " (" + tr("ultimateName") + ")");
ItemEdit(global.jjsUltimateConcentratedArrow, ItemData.Description, tr("concentratedArrowDescription"));

#endregion

#define GrantCommonAbility

if (room != rmGame)
{
    GainItem(global.jjsCommonConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.common_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsCommonConcentratedArrow);
}

#define GrantUncommonAbility

if (room != rmGame)
{
    GainItem(global.jjsUncommonConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.uncommon_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsUncommonConcentratedArrow);
}

#define GrantRareAbility

if (room != rmGame)
{
    GainItem(global.jjsRareConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.rare_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsRareConcentratedArrow);
}

#define GrantEpicAbility

if (room != rmGame)
{
    GainItem(global.jjsEpicConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.epic_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsEpicConcentratedArrow);
}

#define GrantLegendaryAbility

if (room != rmGame)
{
    GainItem(global.jjsLegendaryConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.legendary_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsLegendaryConcentratedArrow);
}

#define GrantMythicalAbility

if (room != rmGame)
{
    GainItem(global.jjsMythicalConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.mythical_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsMythicalConcentratedArrow);
}

#define GrantCelestialAbility

if (room != rmGame)
{
    GainItem(global.jjsCelestialConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.celestial_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsCelestialConcentratedArrow);
}

#define GrantUltimateAbility

if (room != rmGame)
{
    GainItem(global.jjsUltimateConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.ultimate_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsUltimateConcentratedArrow);
}
