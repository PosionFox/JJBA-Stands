
global.jjRuneRemover = ItemCreate(
    undefined,
    "rune remover",
    "removes your runes.",
    global.sprRuneRemover,
    ItemType.Consumable,
    ItemSubType.Potion,
    370,
    0,
    0,
    [
        Item.Steel, 4,
        Item.Ruby, 1,
        Item.Emerald, 1,
        Item.Topaz, 1,
        Item.Amethyst, 1
    ],
    ScriptWrap(RuneRemoverUse),
    60 * 10,
    true
)
StructureAddItem(Structure.Forge, global.jjRuneRemover);

global.jjRuneStandMight = ItemCreate(
    undefined,
    "rune of stand might",
    "increases damage by 33%.",
    global.sprRuneStandMight,
    ItemType.Consumable,
    ItemSubType.Potion,
    512,
    0,
    0,
    undefined,
    ScriptWrap(RuneStandMightUse),
    5 * 60,
    true
)

global.jjRuneBriefRaspite = ItemCreate(
    undefined,
    "rune of brief raspite",
    "heals slowly.",
    global.sprRuneBriefRaspite,
    ItemType.Consumable,
    ItemSubType.Potion,
    512,
    0,
    0,
    undefined,
    ScriptWrap(RuneBriefRaspiteUse),
    5 * 60,
    true
)

#define RuneRemoverUse

RunesRemove(player);
GainItem(global.jjRuneRemover, 1);

#define RuneStandMightUse

RuneEquip(player, ConstructRuneStandMight());

#define ConstructRuneStandMight

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneStandMight;
_rune.item_id = global.jjRuneStandMight;
_rune.save_key = "skRuneStandMight";
_rune.damage = 0.33;
return _rune

#define RuneBriefRaspiteUse

RuneEquip(player, ConstructRuneBriefRaspite());

#define ConstructRuneBriefRaspite

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneBriefRaspite;
_rune.item_id = global.jjRuneBriefRaspite;
_rune.save_key = "skRuneBriefRaspite";
_rune.update = ScriptWrap(RuneBriefRaspiteUpdate);
return _rune

#define RuneBriefRaspiteUpdate

if (instance_exists(player))
{
    player.hp += 0.001;
}

#define ConstructRuneBase

var _base_rune = {
    sprite : global.sprMissingRune,
    item_id : Item.Wood,
    save_key : "skMissing",
    damage : 0, // multiplier
    healing : 0,
    update : ScriptWrap(RuneBaseUpdate),
    update_tick : ScriptWrap(RuneBaseUpdateTick)
}
return _base_rune;

#define RuneBaseUpdate

#define RuneBaseUpdateTick

#define RunRunesUpdate

var _len = array_length(STAND.runes);
for (var i = 0; i < _len; i++)
{
    if (STAND.runes[i] != noone)
    {
        ScriptCall(STAND.runes[i].update);
    }
}

#define RunRunesUpdateTick

var _len = array_length(STAND.runes);
for (var i = 0; i < _len; i++)
{
    if (STAND.runes[i] != noone)
    {
        ScriptCall(STAND.runes[i].update_tick);
    }
}

#define RuneEquip(_user, _rune)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    var _len = array_length(_stand.runes);
    for (var i = 0; i < _len; i++)
    {
        if (_stand.runes[i] == noone)
        {
            _stand.runes[i] = _rune;
            exit;
        }
    }
    GainItem(_rune.item_id, 1);
}
else
{
    GainItem(_rune.item_id, 1);
}

#define RunesRemove(_user)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    for (var i = 0; i < array_length(_stand.runes); i++)
    {
        if (_stand.runes[i] != noone)
        {
            DropItem(_stand.x, _stand.y, _stand.runes[i].item_id, 1);
            _stand.runes[i] = noone;
        }
    }
}

#define GetRuneDamage

var _total_damage = 0;
for (var i = 0; i < array_length(STAND.runes); i++)
{
    if (STAND.runes[i] != noone)
    {
        _total_damage += STAND.runes[i].damage;
    }
}
return  (1 + _total_damage);
