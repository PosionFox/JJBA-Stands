
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

