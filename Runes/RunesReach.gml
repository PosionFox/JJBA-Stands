
global.jjRuneReach1 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("commonName"),
    Localize("runeReachDesc") + " 1%.",
    global.sprRuneReach1,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 1,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach1Use),
    5 * 60,
    true
)

global.jjRuneReach2 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("uncommonName"),
    Localize("runeReachDesc") + " 2%.",
    global.sprRuneReach2,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 2,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach2Use),
    5 * 60,
    true
)

global.jjRuneReach3 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("rareName"),
    Localize("runeReachDesc") + " 4%.",
    global.sprRuneReach3,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 3,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach3Use),
    5 * 60,
    true
)

global.jjRuneReach4 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("epicName"),
    Localize("runeReachDesc") + " 8%.",
    global.sprRuneReach4,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 4,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach4Use),
    5 * 60,
    true
)

global.jjRuneReach5 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("legendaryName"),
    Localize("runeReachDesc") + " 16%.",
    global.sprRuneReach5,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 5,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach5Use),
    5 * 60,
    true
)

global.jjRuneReach6 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("mythicalName"),
    Localize("runeReachDesc") + " 32%.",
    global.sprRuneReach6,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 6,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach6Use),
    5 * 60,
    true
)

global.jjRuneReach7 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("ascendedName"),
    Localize("runeReachDesc") + " 64%.",
    global.sprRuneReach7,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 7,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach7Use),
    5 * 60,
    true
)

global.jjRuneReach8 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeReachName") + " " + Localize("ultimateName"),
    Localize("runeReachDesc") + " 128%.",
    global.sprRuneReach8,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 8,
    0,
    0,
    undefined,
    ScriptWrap(RuneReach8Use),
    5 * 60,
    true
)

#define RuneReach1Use

RuneEquip(player, ConstructRuneReach1());

#define RuneReach2Use

RuneEquip(player, ConstructRuneReach2());

#define RuneReach3Use

RuneEquip(player, ConstructRuneReach3());

#define RuneReach4Use

RuneEquip(player, ConstructRuneReach4());

#define RuneReach5Use

RuneEquip(player, ConstructRuneReach5());

#define RuneReach6Use

RuneEquip(player, ConstructRuneReach6());

#define RuneReach7Use

RuneEquip(player, ConstructRuneReach7());

#define RuneReach8Use

RuneEquip(player, ConstructRuneReach8());


#define ConstructRuneReach1

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach1;
_rune.item_id = global.jjRuneReach1;
_rune.save_key = "skRuneReach1";
_rune.stand_reach = 0.01;
return _rune;

#define ConstructRuneReach2

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach2;
_rune.item_id = global.jjRuneReach2;
_rune.save_key = "skRuneReach2";
_rune.stand_reach = 0.02;
return _rune;

#define ConstructRuneReach3

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach3;
_rune.item_id = global.jjRuneReach3;
_rune.save_key = "skRuneReach3";
_rune.stand_reach = 0.04;
return _rune;

#define ConstructRuneReach4

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach4;
_rune.item_id = global.jjRuneReach4;
_rune.save_key = "skRuneReach4";
_rune.stand_reach = 0.08;
return _rune;

#define ConstructRuneReach5

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach5;
_rune.item_id = global.jjRuneReach5;
_rune.save_key = "skRuneReach5";
_rune.stand_reach = 0.16;
return _rune;

#define ConstructRuneReach6

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach6;
_rune.item_id = global.jjRuneReach6;
_rune.save_key = "skRuneReach6";
_rune.stand_reach = 0.32;
return _rune;

#define ConstructRuneReach7

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach7;
_rune.item_id = global.jjRuneReach7;
_rune.save_key = "skRuneReach7";
_rune.stand_reach = 0.64;
return _rune;

#define ConstructRuneReach8

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneReach8;
_rune.item_id = global.jjRuneReach8;
_rune.save_key = "skRuneReach8";
_rune.stand_reach = 1.28;
return _rune;
