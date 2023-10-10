

global.jjRuneMending1 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("commonName"),
    Localize("runeMending1Desc"),
    global.sprRuneMending1,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 1,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending1Use),
    5 * 60,
    true
)

global.jjRuneMending2 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("uncommonName"),
    Localize("runeMending2Desc"),
    global.sprRuneMending2,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 2,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending2Use),
    5 * 60,
    true
)

global.jjRuneMending3 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("rareName"),
    Localize("runeMending3Desc"),
    global.sprRuneMending3,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 3,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending3Use),
    5 * 60,
    true
)

global.jjRuneMending4 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("epicName"),
    Localize("runeMending4Desc"),
    global.sprRuneMending4,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 4,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending4Use),
    5 * 60,
    true
)

global.jjRuneMending5 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("legendaryName"),
    Localize("runeMending5Desc"),
    global.sprRuneMending5,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 5,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending5Use),
    5 * 60,
    true
)

global.jjRuneMending6 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("mythicalName"),
    Localize("runeMending6Desc"),
    global.sprRuneMending6,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 6,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending6Use),
    5 * 60,
    true
)

global.jjRuneMending7 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("ascendedName"),
    Localize("runeMending7Desc"),
    global.sprRuneMending7,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 7,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending7Use),
    5 * 60,
    true
)

global.jjRuneMending8 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeMendingName") + " " + Localize("ultimateName"),
    Localize("runeMending8Desc"),
    global.sprRuneMending8,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 8,
    0,
    0,
    undefined,
    ScriptWrap(RuneMending8Use),
    5 * 60,
    true
)

#define RuneMending1Use

RuneEquip(player, ConstructRuneMending1());

#define RuneMending2Use

RuneEquip(player, ConstructRuneMending2());

#define RuneMending3Use

RuneEquip(player, ConstructRuneMending3());

#define RuneMending4Use

RuneEquip(player, ConstructRuneMending4());

#define RuneMending5Use

RuneEquip(player, ConstructRuneMending5());

#define RuneMending6Use

RuneEquip(player, ConstructRuneMending6());

#define RuneMending7Use

RuneEquip(player, ConstructRuneMending7());

#define RuneMending8Use

RuneEquip(player, ConstructRuneMending8());


#define ConstructRuneMending1

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending1;
_rune.item_id = global.jjRuneMending1;
_rune.save_key = "skRuneMending1";
_rune.healing = 0.0001;
return _rune

#define ConstructRuneMending2

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending2;
_rune.item_id = global.jjRuneMending2;
_rune.save_key = "skRuneMending2";
_rune.healing = 0.0002;
return _rune

#define ConstructRuneMending3

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending3;
_rune.item_id = global.jjRuneMending3;
_rune.save_key = "skRuneMending3";
_rune.healing = 0.0004;
return _rune

#define ConstructRuneMending4

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending4;
_rune.item_id = global.jjRuneMending4;
_rune.save_key = "skRuneMending4";
_rune.healing = 0.0008;
return _rune

#define ConstructRuneMending5

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending5;
_rune.item_id = global.jjRuneMending5;
_rune.save_key = "skRuneMending5";
_rune.healing = 0.0016;
return _rune

#define ConstructRuneMending6

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending6;
_rune.item_id = global.jjRuneMending6;
_rune.save_key = "skRuneMending6";
_rune.healing = 0.0032;
return _rune

#define ConstructRuneMending7

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending7;
_rune.item_id = global.jjRuneMending7;
_rune.save_key = "skRuneMending7";
_rune.healing = 0.0064;
return _rune

#define ConstructRuneMending8

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneMending8;
_rune.item_id = global.jjRuneMending8;
_rune.save_key = "skRuneMending8";
_rune.healing = 0.0128;
return _rune

