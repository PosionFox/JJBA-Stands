
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
    [Item.Poop, 128],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsCommonShard, ItemData.Name, tr("common_shard_name"));
ItemEdit(global.jjsCommonShard, ItemData.Description, tr("common_shard_desc"));

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
    [global.jjsCommonShard, 64],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsUncommonShard, ItemData.Name, tr("uncommon_shard_name"));
ItemEdit(global.jjsUncommonShard, ItemData.Description, tr("uncommon_shard_desc"));

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
    [global.jjsUncommonShard, 32],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsRareShard, ItemData.Name, tr("rare_shard_name"));
ItemEdit(global.jjsRareShard, ItemData.Description, tr("rare_shard_desc"));

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
    [global.jjsRareShard, 16],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsEpicShard, ItemData.Name, tr("epic_shard_name"));
ItemEdit(global.jjsEpicShard, ItemData.Description, tr("epic_shard_desc"));

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
    [global.jjsEpicShard, 8],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsLegendaryShard, ItemData.Name, tr("legendary_shard_name"));
ItemEdit(global.jjsLegendaryShard, ItemData.Description, tr("legendary_shard_desc"));

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
    [global.jjsLegendaryShard, 4],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsMythicalShard, ItemData.Name, tr("mythical_shard_name"));
ItemEdit(global.jjsMythicalShard, ItemData.Description, tr("mythical_shard_desc"));

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
    [global.jjsMythicalShard, 3],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsCelestialShard, ItemData.Name, tr("celestial_shard_name"));
ItemEdit(global.jjsCelestialShard, ItemData.Description, tr("celestial_shard_desc"));

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
    [global.jjsCelestialShard, 2],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsUltimateShard, ItemData.Name, tr("ultimate_shard_name"));
ItemEdit(global.jjsUltimateShard, ItemData.Description, tr("ultimate_shard_desc"));

global.jjsBizarreMass = ItemCreate(
    undefined,
    "jjsBizarreMass",
    "",
    global.sprBizarreMass,
    ItemType.Material,
    ItemSubType.None,
    1024,
    0,
    0,
    [
        global.jjsLegendaryShard, 8,
        global.jjsMythicalShard, 4,
        global.jjsCelestialShard, 2,
        global.jjsUltimateShard, 1
    ],
    ScriptWrap(EventHandler),
    60 * 1,
    true
);
ItemEdit(global.jjsBizarreMass, ItemData.Name, tr("bizarre_mass_name"));
ItemEdit(global.jjsBizarreMass, ItemData.Description, tr("bizarre_mass_desc"));

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
ItemEdit(global.jjsCommonConcentratedArrow, ItemData.Name, tr("common_arrow_name"));
ItemEdit(global.jjsCommonConcentratedArrow, ItemData.Description, tr("common_arrow_desc"));

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
ItemEdit(global.jjsUncommonConcentratedArrow, ItemData.Name, tr("uncommon_arrow_name"));
ItemEdit(global.jjsUncommonConcentratedArrow, ItemData.Description, tr("uncommon_arrow_desc"));

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
ItemEdit(global.jjsRareConcentratedArrow, ItemData.Name, tr("rare_arrow_name"));
ItemEdit(global.jjsRareConcentratedArrow, ItemData.Description, tr("rare_arrow_desc"));

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
ItemEdit(global.jjsEpicConcentratedArrow, ItemData.Name, tr("epic_arrow_name"));
ItemEdit(global.jjsEpicConcentratedArrow, ItemData.Description, tr("epic_arrow_desc"));

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
ItemEdit(global.jjsLegendaryConcentratedArrow, ItemData.Name, tr("legendary_arrow_name"));
ItemEdit(global.jjsLegendaryConcentratedArrow, ItemData.Description, tr("legendary_arrow_desc"));

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
ItemEdit(global.jjsMythicalConcentratedArrow, ItemData.Name, tr("mythical_arrow_name"));
ItemEdit(global.jjsMythicalConcentratedArrow, ItemData.Description, tr("mythical_arrow_desc"));

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
ItemEdit(global.jjsCelestialConcentratedArrow, ItemData.Name, tr("celestial_arrow_name"));
ItemEdit(global.jjsCelestialConcentratedArrow, ItemData.Description, tr("celestial_arrow_desc"));

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
ItemEdit(global.jjsUltimateConcentratedArrow, ItemData.Name, tr("ultimate_arrow_name"));
ItemEdit(global.jjsUltimateConcentratedArrow, ItemData.Description, tr("ultimate_arrow_desc"));

global.jjsBizarreArrow = ItemCreate(
    undefined,
    "jjsBizarreArrow",
    "",
    global.sprBizarreArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 9,
    0,
    0,
    [
        global.jjsEternalArrow, 1,
        global.jjsBizarreMass, 1
    ],
    ScriptWrap(GrantUltimateAbility),
    60 * 1,
    true
);
ItemEdit(global.jjsBizarreArrow, ItemData.Name, tr("bizarre_arrow_name"));
ItemEdit(global.jjsBizarreArrow, ItemData.Description, tr("bizarre_arrow_desc"));

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

#define GrantBizarreAbility

GainItem(global.jjsBizarreArrow);
exit;

if (room != rmGame)
{
    GainItem(global.jjsBizarreArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.bizarre_rarity_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjsBizarreArrow);
}
