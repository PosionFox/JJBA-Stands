
global.jjsRuneSlots = array_create(256, undefined);

global.jjsRuneBundle = ItemCreate(
    undefined,
    "jjsRuneBundle",
    "",
    global.sprRuneBundle,
    ItemType.Consumable,
    ItemSubType.Potion,
    100,
    0,
    0,
    undefined,
    ScriptWrap(RuneBundleUse),
    5 * 20,
    true
)
ItemEdit(global.jjsRuneBundle, ItemData.Name, tr("rune_bundle_name"));
ItemEdit(global.jjsRuneBundle, ItemData.Description, tr("rune_bundle_desc"));

global.jjsRuneRemover = ItemCreate(
    undefined,
    "jjsRuneRemover",
    "",
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
ItemEdit(global.jjsRuneRemover, ItemData.Name, tr("runeRemoverName"));
ItemEdit(global.jjsRuneRemover, ItemData.Description, tr("runeRemoverDescription"));
//StructureAddItem(Structure.Forge, global.jjRuneRemover);

#define RuneBundleUse

jj_play_audio(sndCraftSewingStation, 5, false);

var _pool = [
    ConstructRuneMight,
    ConstructRuneAcute,
    ConstructRuneMending,
    ConstructRuneReach,
    ConstructRuneEnergize
];
var _plen = array_length(_pool) - 1;

var _rarities = [
    [Rarity.Ordinary, global.ordinary_rarity_weight],
    [Rarity.Tragic, global.tragic_rarity_weight],
    [Rarity.Common, global.common_rarity_weight],
    [Rarity.Uncommon, global.uncommon_rarity_weight],
    [Rarity.Rare, global.rare_rarity_weight],
    [Rarity.Epic, global.epic_rarity_weight],
    [Rarity.Legendary, global.legendary_rarity_weight],
    [Rarity.Mythical, global.mythical_rarity_weight],
    [Rarity.Celestial, global.celestial_rarity_weight],
    [Rarity.Ultimate, global.ultimate_rarity_weight],
    [Rarity.Bizarre, global.bizarre_rarity_weight]
]

var _t = irandom_range(1, 5);
repeat (_t)
{
    var _i = irandom(_plen);
    var _new_rune = script_execute(_pool[_i]);
    _new_rune.rarity = random_weight(_rarities);
    UpdateRuneValues(_new_rune);
    RuneAdd(_new_rune);
}

#define RuneRemoverUse

//RunesRemove(player);
GainItem(global.jjsRuneRemover, 1);

#define RuneAdd(_rune)

var _rlen = array_length(global.jjsRuneSlots);
for (var i = 0; i < _rlen; i++)
{
    if (global.jjsRuneSlots[i] == undefined)
    {
        global.jjsRuneSlots[i] = _rune;
        break;
    }
}

#define ConstructRuneBase

var _base_rune = {
    save_key : "rsk_unknown",
    name : "rune",
    description : "description",
    rarity : Rarity.Common,
    stand_user : noone,
    base_sprite : global.sprBlankRune,
    sprite : global.sprUnknownRune,
    damage : 0, // mult
    crit_chance : 0, // mult
    healing : 0,
    stand_reach : 0, // mult
    max_energy : 0,
    damage_reduction : 0, // mult
    update : ScriptWrap(RuneBaseUpdate),
    update_tick : ScriptWrap(RuneBaseUpdateTick),
    on_equip : ScriptWrap(RuneBaseOnEquip),
    on_remove : ScriptWrap(RuneBaseOnRemove)
}
return _base_rune;

#define RuneConstructByKey(_key)

var _r;

switch (_key)
{
    case "rsk_might": _r = ConstructRuneMight(); break;
    case "rsk_brief_raspite": _r = ConstructRuneBriefRaspite(); break;
    case "rsk_mending": _r = ConstructRuneMending(); break;
    case "rsk_reach": _r = ConstructRuneReach(); break;
    case "rsk_energize": _r = ConstructRuneEnergize(); break;
    case "rsk_acute": _r = ConstructRuneAcute(); break;
    default: _r = ConstructRuneMight(); break;
}

return _r;

#define DeconstructRune(_rune)

var _str = string(_rune.save_key) + "|" + string(_rune.rarity);
return _str;

#define UpdateRuneValues(_rune)

var _pm = GetPowerMultiplier(_rune.rarity);

_rune.damage *= _pm;
_rune.crit_chance *= _pm;
_rune.healing *= _pm;
_rune.stand_reach *= _pm;
if (_rune.max_energy > 0) _rune.max_energy += 50 * _pm;
_rune.damage_reduction *= _pm;

#define RuneBaseUpdate

#define RuneBaseUpdateTick

#define RuneBaseOnEquip

#define RuneBaseOnRemove

#define RunRunesUpdate(_stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != undefined)
    {
        ScriptCall(_stand.runes[i].update);
    }
}

#define RunRunesUpdateTick(_stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != undefined)
    {
        ScriptCall(_stand.runes[i].update_tick);
    }
}

#define RunRunesHealing(_user, _stand)

var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    if (_stand.runes[i] != undefined)
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
        if (_stand.runes[i] == undefined)
        {
            jj_play_audio(sndFreeze, 5, false);
            var _rune = _stand.runes[i];
            _stand.runes[i] = _new_rune;
            _stand.runes[i].stand_user = _user;
            ScriptCall(_new_rune.on_equip);
            return true;
        }
    }
    return false;
}
else
{
    return false;
}

#define RuneRemove(_user, _index)

jj_play_audio(sndGemDrop, 5, false);

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    if (_stand.runes[_index] != undefined)
    {
        var _rune = _stand.runes[_index];
        //DropItem(_stand.x, _stand.y, _rune.item_id, 1);
        RuneAdd(_rune);
        ScriptCall(_rune.on_remove);
        _stand.runes[_index] = undefined;
    }
}

#define RunesRemove(_user)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    for (var i = 0; i < array_length(_stand.runes); i++)
    {
        if (_stand.runes[i] != undefined)
        {
            var _rune = _stand.runes[i];
            //DropItem(_stand.x, _stand.y, _rune.item_id, 1);
            RuneAdd(_rune);
            ScriptCall(_rune.on_remove);
            _stand.runes[i] = undefined;
        }
    }
}

#define RuneStorageErase(_rune)

var _i = array_find_index(global.jjsRuneSlots, _rune);
global.jjsRuneSlots[_i] = undefined;

#define RuneEraseAll(_user)

var _stand = _user.myStand;
if (instance_exists(_user) and instance_exists(_stand))
{
    for (var i = 0; i < array_length(_stand.runes); i++)
    {
        if (_stand.runes[i] != undefined)
        {
            _stand.runes[i] = undefined;
        }
    }
}

#define GetRunesDamage(_stand)

var _total_damage = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != undefined)
    {
        _total_damage += _rune.damage;
    }
}
return  (1 + _total_damage);

#define GetRunesCritChance(_stand)

var _total_cc = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != undefined)
    {
        _total_cc += _rune.crit_chance;
    }
}
return  (_total_cc);

#define GetRunesStandReach(_stand)

var _total_range = 0;
var _len = array_length(_stand.runes);
for (var i = 0; i < _len; i++)
{
    var _rune = _stand.runes[i];
    if (_rune != undefined)
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
    if (_rune != undefined)
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

#define SaveRunes(_map)

var _stand;
if ("myStand" in player) { _stand = player.myStand; }

// runes equipped
if (instance_exists(player) and instance_exists(_stand))
{
    var _rs = array_length(_stand.runes);
    for (var i = 0; i < _rs; i++)
    {
        var _key = "jjsRune" + string(i);
        if (_stand.runes[i] != undefined)
        {
            _map[? _key] = DeconstructRune(_stand.runes[i]);
        }
        else
        {
            _map[? _key] = _stand.runes[i];
        }
    }
}
// rune storage
var _rs = array_length(global.jjsRuneSlots);
for (var i = 0; i < _rs; i++)
{
    var _key = "jjsRuneSlot" + string(i);
    if (global.jjsRuneSlots[i] != undefined)
    {
        _map[? _key] = DeconstructRune(global.jjsRuneSlots[i]);
    }
    else
    {
        _map[? _key] = global.jjsRuneSlots[i];
    }
}

#define LoadRunes(_map)

// equipped
if (instance_exists(player) and instance_exists(STAND))
{
    var _re = array_length(STAND.runes);
    for (var i = 0; i < _re; i++)
    {
        var _key = "jjsRune" + string(i);
        var _crune = _map[? _key];
        if (_crune != undefined)
        {
            var _data = "rsk_might|0";
            try
            {
                _data = string_split(_crune, "|");
            }
            catch (e)
            {
                Trace("could not load rune");
            }
            var _new_rune = RuneConstructByKey(_data[0]);
            _new_rune.rarity = real(_data[1]);
            UpdateRuneValues(_new_rune);
            STAND.runes[i] = _new_rune;
        }
        else
        {
            STAND.runes[i] = undefined;
        }
    }
}

// storage
var _rs = array_length(global.jjsRuneSlots);
for (var i = 0; i < _rs; i++)
{
    var _key = "jjsRuneSlot" + string(i);
    var _crune = _map[? _key];
    if (_crune != undefined)
    {
        var _data = "rsk_might|0";
        try
        {
            _data = string_split(_crune, "|");
        }
        catch (e)
        {
            Trace("could not load rune");
        }
        var _new_rune = RuneConstructByKey(_data[0]);
        _new_rune.rarity = real(_data[1]);
        UpdateRuneValues(_new_rune);
        global.jjsRuneSlots[i] = _new_rune;
    }
    else
    {
        global.jjsRuneSlots[i] = undefined;
    }
}