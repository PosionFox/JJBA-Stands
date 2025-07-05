
// load runes
RunesStandMight();
RunesBriefRaspite();
RunesMending();
RunesReach();
RunesEnergize();

global.jjRuneRemover = ItemCreate(
    undefined,
    Localize("runeRemoverName"),
    Localize("runeRemoverDescription"),
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
//StructureAddItem(Structure.Forge, global.jjRuneRemover);

#define RuneRemoverUse

//RunesRemove(player);
GainItem(global.jjRuneRemover, 1);

#define ConstructRuneBase

var _base_rune = {
    stand_user : noone,
    sprite : global.sprMissingRune,
    item_id : Item.Wood,
    save_key : "skMissing",
    damage : 0, // multiplier
    healing : 0,
    stand_reach : 0,  // multiplier
    max_energy : 0,
    damage_reduction : 1,
    update : ScriptWrap(RuneBaseUpdate),
    update_tick : ScriptWrap(RuneBaseUpdateTick),
    on_equip : ScriptWrap(RuneBaseOnEquip),
    on_remove : ScriptWrap(RuneBaseOnRemove)
}
return _base_rune;

#define RuneBaseUpdate

#define RuneBaseUpdateTick

#define RuneBaseOnEquip

#define RuneBaseOnRemove

#define RunRunesUpdate(_stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != noone)
    {
        ScriptCall(_stand.runes[i].update);
    }
}

#define RunRunesUpdateTick(_stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != noone)
    {
        ScriptCall(_stand.runes[i].update_tick);
    }
}

#define RunRunesHealing(_user, _stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != noone)
    {
        _user.hp += _stand.runes[i].healing;
    }
}

#define RuneEquip(_user, _new_rune)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    var _len = array_length(_stand.runes);
    for (var i = 0; i < _len; i++)
    {
        if (_stand.runes[i] == noone)
        {
            var _rune = _stand.runes[i];
            _stand.runes[i] = _new_rune;
            _stand.runes[i].stand_user = _user;
            ScriptCall(_new_rune.on_equip);
            exit;
        }
    }
    GainItem(_new_rune.item_id, 1);
}
else
{
    GainItem(_new_rune.item_id, 1);
}

#define RuneRemove(_user, _index)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    if (_stand.runes[_index] != noone)
    {
        var _rune = _stand.runes[_index];
        DropItem(_stand.x, _stand.y, _rune.item_id, 1);
        ScriptCall(_rune.on_remove);
        _stand.runes[_index] = noone;
    }
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
            ScriptCall(_rune.on_remove);
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

#define GetRunesDamage(_stand)

var _total_damage = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != noone)
    {
        _total_damage += _rune.damage;
    }
}
return  (1 + _total_damage);

#define GetRunesStandReach(_stand)

var _total_range = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != noone)
    {
        _total_range += _rune.stand_reach;
    }
}
return  (1 + _total_range);

#define GetRunesMaxEnergy(_stand)

var _total_energy = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != noone)
    {
        _total_energy += _rune.max_energy;
    }
}
return _total_energy;

#define CreateEnergyOrb(_x, _y, _depth)

var _o = ModObjectSpawn(_x, _y, _depth);
with (_o)
{
    sprite_index = global.sprEnergyOrb;
    energy_reward = 25;
    life = 60;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnergyOrbStep));
}
return _o;

#define EnergyOrbStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

image_xscale = min(1, 0.5 + abs(sin(current_time / 500) * 2));
image_yscale = min(1, 0.5 + abs(sin(current_time / 500) * 2));

if (instance_exists(STAND))
{
    if (STAND.energy < STAND.max_energy and distance_to_object(player) < 32)
    {
        mp_linear_step(player.x, player.y, 4, false);
    }
    
    if (STAND.energy < STAND.max_energy and place_meeting(x, y, player))
    {
        STAND.energy += energy_reward + (STAND.max_energy * 0.05);
        jj_play_audio(global.sndEnergyOrb, 5, false);
        instance_destroy(self);
    }
}
