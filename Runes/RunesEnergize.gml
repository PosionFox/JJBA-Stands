
global.jjRuneEnergize1 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("commonName"),
    Localize("runeEnergizeDesc") + " 100.",
    global.sprRuneEnergize1,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 1,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize1Use),
    5 * 60,
    true
)

global.jjRuneEnergize2 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("uncommonName"),
    Localize("runeEnergizeDesc") + " 200.",
    global.sprRuneEnergize2,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 2,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize2Use),
    5 * 60,
    true
)

global.jjRuneEnergize3 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("rareName"),
    Localize("runeEnergizeDesc") + " 400.",
    global.sprRuneEnergize3,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 3,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize3Use),
    5 * 60,
    true
)

global.jjRuneEnergize4 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("epicName"),
    Localize("runeEnergizeDesc") + " 800.",
    global.sprRuneEnergize4,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 4,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize4Use),
    5 * 60,
    true
)

global.jjRuneEnergize5 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("legendaryName"),
    Localize("runeEnergizeDesc") + " 1600.",
    global.sprRuneEnergize5,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 5,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize5Use),
    5 * 60,
    true
)

global.jjRuneEnergize6 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("mythicalName"),
    Localize("runeEnergizeDesc") + " 3200.",
    global.sprRuneEnergize6,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 6,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize6Use),
    5 * 60,
    true
)

global.jjRuneEnergize7 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("ascendedName"),
    Localize("runeEnergizeDesc") + " 6400.",
    global.sprRuneEnergize7,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 7,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize7Use),
    5 * 60,
    true
)

global.jjRuneEnergize8 = ItemCreate(
    undefined,
    Localize("runeOf") + " " + Localize("runeEnergizeName") + " " + Localize("ultimateName"),
    Localize("runeEnergizeDesc") + " 12800.",
    global.sprRuneEnergize8,
    ItemType.Consumable,
    ItemSubType.Potion,
    128 * 8,
    0,
    0,
    undefined,
    ScriptWrap(RuneEnergize8Use),
    5 * 60,
    true
)

#define RuneEnergize1Use

RuneEquip(player, ConstructRuneEnergize1());

#define RuneEnergize2Use

RuneEquip(player, ConstructRuneEnergize2());

#define RuneEnergize3Use

RuneEquip(player, ConstructRuneEnergize3());

#define RuneEnergize4Use

RuneEquip(player, ConstructRuneEnergize4());

#define RuneEnergize5Use

RuneEquip(player, ConstructRuneEnergize5());

#define RuneEnergize6Use

RuneEquip(player, ConstructRuneEnergize6());

#define RuneEnergize7Use

RuneEquip(player, ConstructRuneEnergize7());

#define RuneEnergize8Use

RuneEquip(player, ConstructRuneEnergize8());


#define ConstructRuneEnergize1

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize1;
_rune.item_id = global.jjRuneEnergize1;
_rune.save_key = "skRuneEnergize1";
_rune.max_energy = 100;
return _rune

#define ConstructRuneEnergize2

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize2;
_rune.item_id = global.jjRuneEnergize2;
_rune.save_key = "skRuneEnergize2";
_rune.max_energy = 200;
return _rune

#define ConstructRuneEnergize3

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize3;
_rune.item_id = global.jjRuneEnergize3;
_rune.save_key = "skRuneEnergize3";
_rune.max_energy = 400;
return _rune

#define ConstructRuneEnergize4

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize4;
_rune.item_id = global.jjRuneEnergize4;
_rune.save_key = "skRuneEnergize4";
_rune.max_energy = 800;
return _rune

#define ConstructRuneEnergize5

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize5;
_rune.item_id = global.jjRuneEnergize5;
_rune.save_key = "skRuneEnergize5";
_rune.max_energy = 1600;
return _rune

#define ConstructRuneEnergize6

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize6;
_rune.item_id = global.jjRuneEnergize6;
_rune.save_key = "skRuneEnergize6";
_rune.max_energy = 3200;
return _rune

#define ConstructRuneEnergize7

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize7;
_rune.item_id = global.jjRuneEnergize7;
_rune.save_key = "skRuneEnergize7";
_rune.max_energy = 6400;
return _rune

#define ConstructRuneEnergize8

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneEnergize8;
_rune.item_id = global.jjRuneEnergize8;
_rune.save_key = "skRuneEnergize8";
_rune.max_energy = 12800;
return _rune
