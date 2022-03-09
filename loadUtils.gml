
#define modTypeExists(_type)

with (objModEmpty)
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
    with (objModEmpty)
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
return false;

#define modTypeFindNearest(_x, _y, _type)

var _list = [];
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == "clone")
        {
            array_push(_list, self);
        }
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

#define modTypeCount(_type)

var _count = 0;
with (objModEmpty)
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

#define modSubtypeExists(_type)

with (objModEmpty)
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

with (objModEmpty)
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

