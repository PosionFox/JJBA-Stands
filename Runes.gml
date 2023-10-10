
// load runes
RunesStandMight();
RunesBriefRaspite();
RunesMending();
RunesReach();

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

#define RuneRemoverUse

RunesRemove(player);
GainItem(global.jjRuneRemover, 1);

#define ConstructRuneBase

var _base_rune = {
    sprite : global.sprMissingRune,
    item_id : Item.Wood,
    save_key : "skMissing",
    damage : 0, // multiplier
    healing : 0,
    stand_reach : 0,  // multiplier
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

#define RunRunesHealing

var _len = array_length(STAND.runes);
for (var i = 0; i < _len; i++)
{
    if (STAND.runes[i] != noone)
    {
        player.hp += STAND.runes[i].healing;
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
            var _rune = _stand.runes[i];
            DropItem(_stand.x, _stand.y, _rune.item_id, 1);
            _stand.runes[i] = noone;
        }
    }
}

#define RunesErase(_user)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    for (var i = 0; i < array_length(_stand.runes); i++)
    {
        if (_stand.runes[i] != noone)
        {
            _stand.runes[i] = noone;
        }
    }
}

#define GetRunesDamage

var _total_damage = 0;
for (var i = 0; i < array_length(STAND.runes); i++)
{
    var _rune = STAND.runes[i];
    if (_rune != noone)
    {
        _total_damage += _rune.damage;
    }
}
return  (1 + _total_damage);

#define GetRunesStandReach

var _total_range = 0;
for (var i = 0; i < array_length(STAND.runes); i++)
{
    var _rune = STAND.runes[i];
    if (_rune != noone)
    {
        _total_range += _rune.stand_reach;
    }
}
return  (1 + _total_range);
