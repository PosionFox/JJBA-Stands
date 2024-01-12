
#region shards

global.jjCommonShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("commonName") + ")",
    Localize("shardDescription"),
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

global.jjUncommonShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("uncommonName") + ")",
    Localize("shardDescription"),
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

global.jjRareShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("rareName") + ")",
    Localize("shardDescription"),
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

global.jjEpicShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("epicName") + ")",
    Localize("shardDescription"),
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

global.jjLegendaryShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("legendaryName") + ")",
    Localize("shardDescription"),
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

global.jjMythicalShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("mythicalName") + ")",
    Localize("shardDescription"),
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

global.jjAscendedShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("ascendedName") + ")",
    Localize("shardDescription"),
    global.sprAscendedShard,
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

global.jjUltimateShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("ultimateName") + ")",
    Localize("shardDescription"),
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

#endregion

#region concentrated arrows

global.jjCommonConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("commonName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 1,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantCommonAbility),
    60 * 1,
    true
);

global.jjUncommonConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("uncommonName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 2,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantUncommonAbility),
    60 * 1,
    true
);

global.jjRareConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("rareName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprRareConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 3,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjRareShard, 16
    ],
    ScriptWrap(GrantRareAbility),
    60 * 1,
    true
);

global.jjEpicConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("epicName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprEpicConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 4,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjEpicShard, 8
    ],
    ScriptWrap(GrantEpicAbility),
    60 * 1,
    true
);

global.jjLegendaryConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("legendaryName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 5,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjLegendaryShard, 4
    ],
    ScriptWrap(GrantLegendaryAbility),
    60 * 1,
    true
);

global.jjMythicalConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("mythicalName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprMythicalConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 6,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjMythicalShard, 3
    ],
    ScriptWrap(GrantMythicalAbility),
    60 * 1,
    true
);

global.jjAscendedConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("ascendedName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprAscendedConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 7,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjAscendedShard, 2
    ],
    ScriptWrap(GrantAscendedAbility),
    60 * 1,
    true
);

global.jjUltimateConcentratedArrow = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + " (" + Localize("ultimateName") + ")",
    Localize("concentratedArrowDescription"),
    global.sprUltimateConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUltimateShard, 1
    ],
    ScriptWrap(GrantUltimateAbility),
    60 * 1,
    true
);

#endregion

#define GrantCommonAbility

if (room != rmGame)
{
    GainItem(global.jjCommonConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.common_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjCommonConcentratedArrow);
}

#define GrantUncommonAbility

if (room != rmGame)
{
    GainItem(global.jjUncommonConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.uncommon_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjUncommonConcentratedArrow);
}

#define GrantRareAbility

if (room != rmGame)
{
    GainItem(global.jjRareConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.rare_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjRareConcentratedArrow);
}

#define GrantEpicAbility

if (room != rmGame)
{
    GainItem(global.jjEpicConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.epic_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjEpicConcentratedArrow);
}

#define GrantLegendaryAbility

if (room != rmGame)
{
    GainItem(global.jjLegendaryConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.legendary_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjLegendaryConcentratedArrow);
}

#define GrantMythicalAbility

if (room != rmGame)
{
    GainItem(global.jjMythicalConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.mythical_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjMythicalConcentratedArrow);
}

#define GrantAscendedAbility

if (room != rmGame)
{
    GainItem(global.jjAscendedConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.ascended_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjAscendedConcentratedArrow);
}

#define GrantUltimateAbility

if (room != rmGame)
{
    GainItem(global.jjUltimateConcentratedArrow);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    var _abilities = get_all_from_weight(global.arrow_ability_pool, global.ultimate_arrow_weight);
    var _c = irandom(array_length(_abilities) - 1);
    script_execute(_abilities[_c], player);
}
else
{
    GainItem(global.jjUltimateConcentratedArrow);
}
