
#define modTypeExists(_type)

with (MOBJ)
{
    if ("type" in self)
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
        if ("type" in self)
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
    if ("type" in self and type == _type)
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
    if ("type" in self)
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
if ("type" in _o and _o.type == _type)
{
    _colliding = true;
}
return _colliding;

#define modTypePlace(_x, _y, _type)

var _o = instance_place(_x, _y, MOBJ);
if ("type" in _o and _o.type == _type)
{
    return _o;
}
return false;

#define modSubtypeExists(_type)

with (MOBJ)
{
    if ("subtype" in self)
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
    if ("subtype" in self)
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
    if ("subtype" in self and subtype == _type)
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
