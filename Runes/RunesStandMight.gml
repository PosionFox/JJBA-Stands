
global.jjRuneStandMight1 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " i",
    Localize("runeStandMightDesc") + " 1%.",
    global.sprRuneStandMight1,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 1,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight1Use),
    5 * 60,
    true
)

global.jjRuneStandMight2 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " ii",
    Localize("runeStandMightDesc") + " 2%.",
    global.sprRuneStandMight2,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 2,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight2Use),
    5 * 60,
    true
)

global.jjRuneStandMight3 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " iii",
    Localize("runeStandMightDesc") + " 4%.",
    global.sprRuneStandMight3,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 3,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight3Use),
    5 * 60,
    true
)

global.jjRuneStandMight4 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " iv",
    Localize("runeStandMightDesc") + " 8%.",
    global.sprRuneStandMight4,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 4,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight4Use),
    5 * 60,
    true
)

global.jjRuneStandMight5 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " v",
    Localize("runeStandMightDesc") + " 16%.",
    global.sprRuneStandMight5,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 5,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight5Use),
    5 * 60,
    true
)

global.jjRuneStandMight6 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " vi",
    Localize("runeStandMightDesc") + " 32%.",
    global.sprRuneStandMight6,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 6,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight6Use),
    5 * 60,
    true
)

global.jjRuneStandMight7 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " vii",
    Localize("runeStandMightDesc") + " 64%.",
    global.sprRuneStandMight7,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 7,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight7Use),
    5 * 60,
    true
)

global.jjRuneStandMight8 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeStandMightName") + " viii",
    Localize("runeStandMightDesc") + " 128%.",
    global.sprRuneStandMight8,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 8,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMight8Use),
    5 * 60,
    true
)

#define RuneStandMight1Use

RuneEquip(player, ConstructRuneStandMight1());

#define RuneStandMight2Use

RuneEquip(player, ConstructRuneStandMight2());

#define RuneStandMight3Use

RuneEquip(player, ConstructRuneStandMight3());

#define RuneStandMight4Use

RuneEquip(player, ConstructRuneStandMight4());

#define RuneStandMight5Use

RuneEquip(player, ConstructRuneStandMight5());

#define RuneStandMight6Use

RuneEquip(player, ConstructRuneStandMight6());

#define RuneStandMight7Use

RuneEquip(player, ConstructRuneStandMight7());

#define RuneStandMight8Use

RuneEquip(player, ConstructRuneStandMight8());


#define ConstructRuneStandMight1

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight1;
_rune.item_id = global.jjRuneStandMight1;
_rune.save_key = "skRuneStandMight1";
_rune.damage = 0.01;
return _rune

#define ConstructRuneStandMight2

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight2;
_rune.item_id = global.jjRuneStandMight2;
_rune.save_key = "skRuneStandMight2";
_rune.damage = 0.02;
return _rune

#define ConstructRuneStandMight3

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight3;
_rune.item_id = global.jjRuneStandMight3;
_rune.save_key = "skRuneStandMight3";
_rune.damage = 0.04;
return _rune

#define ConstructRuneStandMight4

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight4;
_rune.item_id = global.jjRuneStandMight4;
_rune.save_key = "skRuneStandMight4";
_rune.damage = 0.08;
return _rune

#define ConstructRuneStandMight5

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight5;
_rune.item_id = global.jjRuneStandMight5;
_rune.save_key = "skRuneStandMight5";
_rune.damage = 0.16;
return _rune

#define ConstructRuneStandMight6

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight6;
_rune.item_id = global.jjRuneStandMight6;
_rune.save_key = "skRuneStandMight6";
_rune.damage = 0.32;
return _rune

#define ConstructRuneStandMight7

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight7;
_rune.item_id = global.jjRuneStandMight7;
_rune.save_key = "skRuneStandMight7";
_rune.damage = 0.64;
return _rune

#define ConstructRuneStandMight8

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight8;
_rune.item_id = global.jjRuneStandMight8;
_rune.save_key = "skRuneStandMight8";
_rune.damage = 1.28;
return _rune
