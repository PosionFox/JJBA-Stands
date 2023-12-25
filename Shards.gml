
#region shards

global.jjCommonShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("commonName") + ")",
    Localize("shardDescription"),
    global.sprCommonShard,
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

global.jjUncommonShard = ItemCreate(
    undefined,
    Localize("shardName") + " (" + Localize("uncommonName") + ")",
    Localize("shardDescription"),
    global.sprUncommonShard,
    ItemType.Material,
    ItemSubType.None,
    128 * 2,
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
    128 * 3,
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
    128 * 4,
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
    128 * 5,
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
    128 * 6,
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
    128 * 7,
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
    128 * 8,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 1,
    true
);

#endregion

#region concentrated arrows

// common

global.jjConcentratedArrowSP = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Star Platinum",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSTW = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Shadow The World",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKQ = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Killer Queen",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSF = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Sticky Fingers",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowGE = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Gold Experience",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKC = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "King Crimson",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSC = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Silver Chariot",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowWS = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "WhiteSnake",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSP = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Star Platinum",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowHG = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Hierophant Green",
    Localize("concentratedArrowDescription"),
    global.sprCommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjCommonShard, 64
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// uncommon

global.jjConcentratedArrowSPG = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Star Platinum Gray",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSFG = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Sticky Fingers Gray",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSFR = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Sticky Fingers Red",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKCG = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "King Crimson Gray",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowHR = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Hierophant Red",
    Localize("concentratedArrowDescription"),
    global.sprUncommonConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjUncommonShard, 32
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// rare

global.jjConcentratedArrowSCOVA = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Silver Chariot OVA",
    Localize("concentratedArrowDescription"),
    global.sprRareConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjRareShard, 16
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKCA = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "King Crimson Aqua",
    Localize("concentratedArrowDescription"),
    global.sprRareConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjRareShard, 16
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowHB = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Hierophant Black",
    Localize("concentratedArrowDescription"),
    global.sprRareConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjRareShard, 16
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// epic

global.jjConcentratedArrowBS = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "BlackSnake",
    Localize("concentratedArrowDescription"),
    global.sprEpicConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjEpicShard, 8
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// legendary

global.jjConcentratedArrowSUS = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Imposter",
    Localize("concentratedArrowDescription"),
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjLegendaryShard, 4
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKCMo = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "King Crimson Monochrome",
    Localize("concentratedArrowDescription"),
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjLegendaryShard, 4
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowDW = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Dark World",
    Localize("concentratedArrowDescription"),
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjLegendaryShard, 4
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowSPP = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Star Platinum Prime",
    Localize("concentratedArrowDescription"),
    global.sprLegendaryConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjLegendaryShard, 4
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// mythical

global.jjConcentratedArrowSPR = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Star Platinum Retro",
    Localize("concentratedArrowDescription"),
    global.sprMythicalConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjMythicalShard, 3
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowS = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Shadow",
    Localize("concentratedArrowDescription"),
    global.sprMythicalConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjMythicalShard, 3
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

global.jjConcentratedArrowKCM = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "King Crimson Manga",
    Localize("concentratedArrowDescription"),
    global.sprMythicalConcentratedArrow,
    ItemType.Consumable,
    ItemSubType.None,
    128 * 8,
    0,
    0,
    [
        global.jjbamArrow, 1,
        global.jjMythicalShard, 3
    ],
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

// ascended



// ultimate

global.jjConcentratedArrowEP = ItemCreate(
    undefined,
    Localize("concentratedArrowName") + ":" + "Estrella Platinada",
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
    ScriptWrap(GrantSP),
    60 * 1,
    true
);

#endregion

#define GrantSP

if (room != rmGame)
{
    GainItem(global.jjConcentratedArrowSP);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveStarPlatinum(player);
}
else
{
    GainItem(global.jjConcentratedArrowSP);
}
