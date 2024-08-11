
#define modTypeExists(_type)

with (MOBJ)
{
    if bool("type" in self)
    {
        if (type == _type)
        {
            return true;
        }
    }
}
return false;

#define modTypeFind(_type)

if (modTypeExists(_type))
{
    with (MOBJ)
    {
        if bool("type" in self)
        {
            if (type == _type)
            {
                return self;
            }
        }
    }
}
return noone;

#define modTypeFindNearest(_x, _y, _type)

var _list = [];
with (MOBJ)
{
    if bool("type" in self and type == _type)
    {
        array_push(_list, self);
    }
}
if (array_length(_list) == 0)
{
    return false;
}
var _nearest = _list[0];
for (var i = 0; i < array_length(_list); i++)
{
    var _nearestDis;
    with (_nearest)
    {
        _nearestDis = distance_to_point(_x, _y);
    }
    
    with (_list[i])
    {
        if (distance_to_point(_x, _y) < _nearestDis)
        {
            _nearest = self;
        }
    }
}
return _nearest;

#define modTypeCount(_type)

var _count = 0;
with (MOBJ)
{
    if bool("type" in self)
    {
        if (type == _type)
        {
            _count++;
        }
    }
}
return _count;

#define modTypeMeeting(_x, _y, _type)

var _colliding = false;
var _o = instance_place(_x, _y, MOBJ);
if bool("type" in _o and _o.type == _type)
{
    _colliding = true;
}
return _colliding;

#define modTypePlace(_x, _y, _type)

var _o = instance_place(_x, _y, MOBJ);
if bool("type" in _o and _o.type == _type)
{
    return _o;
}
return false;

#define modSubtypeExists(_type)

with (MOBJ)
{
    if bool("subtype" in self)
    {
        if (subtype == _type)
        {
            return true;
        }
    }
}
return false;

#define modSubtypeFind(_type)

with (MOBJ)
{
    if bool("subtype" in self)
    {
        if (subtype == _type)
        {
            return self;
        }
    }
}
return noone;

#define modSubtypeFindNearest(_x, _y, _type)

var _list = [];
with (MOBJ)
{
    if bool("subtype" in self and subtype == _type)
    {
        array_push(_list, self);
    }
}
var _nearest = _list[0];
for (var i = 0; i < array_length(_list); i++)
{
    var _nearestDis;
    with (_nearest)
    {
        _nearestDis = distance_to_point(_x, _y);
    }
    
    with (_list[i])
    {
        if (distance_to_point(_x, _y) < _nearestDis)
        {
            _nearest = self;
        }
    }
}
return _nearest;


#define NPC2QuestControllerCreate(_instance, _lastQuestState, _callback)

var o = ModObjectSpawn(x, y, 0);
with (o)
{
    type = "questController";
    owner = _instance;
    lastQuestState = _lastQuestState;
    questEndCallback = _callback;
    questStateFinished = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(__NPC2QuestControllerStep));
}

#define __NPC2QuestControllerStep

if (instance_exists(owner))
{
    if (owner.state == lastQuestState and !questStateFinished)
    {
        questStateFinished = true;
    }
    if (questStateFinished and !owner.talking and owner.state == "<noone>")
    {
        with (owner)
        {
            ScriptCall(other.questEndCallback);
        }
        instance_destroy(self);
    }
}

#define NPC2Exists(_npc)

var _exists = false;

with (MNPC)
{
    if (npc == _npc)
    {
        _exists = true;
    }
}

return _exists;

#define draw_circle_thick(_x, _y, _radius, _thickness)

var inner_radius = _radius;
var thickness = _thickness;
var segments = 20;
var jadd = 360 / segments;
draw_primitive_begin(pr_trianglestrip);
for (var j = 0; j <= 360; j += jadd)
{
    draw_vertex(x + lengthdir_x(inner_radius, j), y + lengthdir_y(inner_radius, j));
    draw_vertex(x + lengthdir_x(inner_radius + thickness , j), y + lengthdir_y(inner_radius + thickness, j));
}
draw_primitive_end();

#define random_weight(_array)
// [item, weight]

var sumWeight = 0;
for(var i = 0; i < array_length(_array); i++)
{
    sumWeight += _array[i, 1];
}
var rnd = random(sumWeight);
for(var i = 0; i < array_length(_array); i++)
{
    if (rnd < _array[i, 1])
    {
        return _array[i, 0];
        exit;
    }
    rnd -= _array[i, 1];
}

#define get_total_weight(_array)

var sumWeight = 0;
for(var i = 0; i < array_length(_array); i++)
{
    sumWeight += _array[i, 1];
}
return sumWeight;

#define get_all_from_weight(_array, _weight)

var _pool = []
for(var i = 0; i < array_length(_array); i++)
{
    if (_weight == _array[i, 1])
    {
        array_push(_pool, _array[i, 0]);
    }
}
return _pool;

#define enemy_instance_exists()

if instance_exists(ENEMY)
{
    with (ENEMY)
    {
        return true;
    }
}
else if instance_exists(MOBJ)
{
    with (MOBJ)
    {
        if bool("type" in self and type == "Enemy")
        {
            return true;
        }
    }
}
return false;

#define get_nearest_enemy(_x, _y)

var _list = [];
if instance_exists(MOBJ)
{
    with (MOBJ)
    {
        if bool("type" in self and type == "Enemy")
        {
            array_push(_list, self);
        }
    }
}
if instance_exists(ENEMY)
{
    with (ENEMY)
    {
        array_push(_list, self);
    }
}

if (array_length(_list) == 0)
{
    return self;
}

var _nearest = _list[0];
for (var i = 0; i < array_length(_list); i++)
{
    var _nearestDis;
    with (_nearest)
    {
        _nearestDis = distance_to_point(_x, _y);
    }
    
    with (_list[i])
    {
        if (distance_to_point(_x, _y) < _nearestDis)
        {
            _nearest = self;
        }
    }
}
return _nearest;

#define get_nearest_target(_x, _y)



#define StructureHasItem(_structure, _item)

var _items = StructureGet(_structure, StructureData.Items);
var _len = array_length(_items);
for (var i = 0; i < _len; i++)
{
    if (_items[i] == _item)
    {
        return true;
    }
}
return false;

#define grant_ability_from_item(item, ability_script)

if (room != rmGame)
{
    GainItem(item);
    exit;
}

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    script_execute(ability_script, player);
}
else
{
    GainItem(item);
}

#define jj_play_audio(sound, priority, loop)

var _s = audio_play_sound(sound, priority, loop);
audio_sound_gain(_s, global.jjAudioVolume, 0);
return _s;

#define string_split(string_to_split, string_splitter)

var slot = 0;
var splits; //array to hold all splits
var str2 = ""; //var to hold the current split we're working on building

var i;
for (i = 1; i < (string_length(string_to_split)+1); i++) {
    var currStr = string_copy(string_to_split, i, 1);
    if (currStr == string_splitter) {
        splits[slot] = str2; //add this split to the array of all splits
        slot++;
        str2 = "";
    } else {
        str2 = str2 + currStr;
        splits[slot] = str2;
    }
}

return splits;

#define ConstructStandData(_stand)

return (
    string(STAND.saveKey) +
    ":" +
    string(STAND.name) +
    ":" +
    string(STAND.level) +
    ":" +
    string(STAND.experience) +
    ":" +
    string(STAND.experienceNext) +
    ":" +
    string(STAND.trait.key) +
    ":" +
    string(STAND.destructive_power) +
    ":" +
    string(STAND.spd) +
    ":" +
    string(STAND.range) +
    ":" +
    string(STAND.stamina) +
    ":" +
    string(STAND.precision) +
    ":" +
    string(STAND.development_potential) +
    ":" +
    string(STAND.stat_points)
);

#define DeconstructStandData(_standData)

var _data = string_split(_standData, ":");
var _key = _data[0];
var _name = _data[1];
var _level = _data[2];
var _experience = _data[3];
var _experienceNext = _data[4];
var _traitKey = _data[5];
var _destructive_power = _data[6];
var _spd = _data[7];
var _range = _data[8];
var _stamina = _data[9];
var _precision = _data[10];
var _development_potential = _data[11];
var _stat_points = _data[12];

if _key != undefined GiveStandByKey(_key) else GiveStarPlatinum(player);
//if _name != undefined  name
if _level != undefined STAND.level = real(_level) else STAND.level = 1;
if _experience != undefined STAND.experience = real(_experience) else STAND.experience = 0;
if _experienceNext != undefined STAND.experienceNext = real(_experienceNext) else STAND.experienceNext = 5;
if _traitKey != undefined trait_set_by_key(STAND, _traitKey) else trait_set_by_key(STAND, "jjFit");
if _destructive_power != undefined STAND.destructive_power = real(_destructive_power) else STAND.destructive_power = 1;
if _spd != undefined STAND.spd = real(_spd) else STAND.spd = 1;
if _range != undefined STAND.range = real(_range) else STAND.range = 1;
if _stamina != undefined STAND.stamina = real(_stamina) else STAND.stamina = 1;
if _precision != undefined STAND.precision = real(_precision) else STAND.precision = 1;
if _development_potential != undefined STAND.development_potential = real(_development_potential) else STAND.development_potential = 1;
if _stat_points != undefined STAND.stat_points = real(_stat_points) else STAND.stat_points = 0;
