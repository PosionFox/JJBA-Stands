
#define ik_create(_amount, _length)

var _ik_struct = {
    amount : _amount,
    length : _length,
    segments : []
};
for (var i = 0; i <= _amount; i++)
{
    _ik_struct.segments[i] = {
        x : x,
        y : y,
        angle : 0
    }
}
return _ik_struct;

#define draw_ik(_ik, _sprite, _color)

var _sw = sprite_get_width(_sprite);
for (var i = 0; i < _ik.amount; i++)
{
    var _xx = _ik.segments[i].x;
    var _yy = _ik.segments[i].y;
    var _ang = _ik.segments[i].angle;
    draw_sprite_ext(_sprite, 0, _ik.segments[i].x, _ik.segments[i].y, _ik.length / _sw, 1, _ang, _color, 1);
}

#define inverse_kinematics(_ik, rx, ry, tx, ty)
// this function assumes the following variables: segments_amount, segments_length, segments

_ik.segments[_ik.amount].x = tx;
_ik.segments[_ik.amount].y = ty;

// backward
for (var i = _ik.amount - 1; i >= 0; i--) {
    var dx = _ik.segments[i + 1].x - _ik.segments[i].x;
    var dy = _ik.segments[i + 1].y - _ik.segments[i].y;
    var dist = point_distance(_ik.segments[i + 1].x, _ik.segments[i + 1].y, _ik.segments[i].x, _ik.segments[i].y);
    var ratio = _ik.length / dist;
    
    _ik.segments[i].x = _ik.segments[i + 1].x - dx * ratio;
    _ik.segments[i].y = _ik.segments[i + 1].y - dy * ratio;
}

// root
_ik.segments[0].x = rx;
_ik.segments[0].y = ry;

for (var i = 1; i <= _ik.amount; i++)
{
    var dx = _ik.segments[i].x - _ik.segments[i - 1].x;
    var dy = _ik.segments[i].y - _ik.segments[i - 1].y;
    var dist = point_distance(_ik.segments[i].x, _ik.segments[i].y, _ik.segments[i - 1].x, _ik.segments[i - 1].y);
    var ratio = _ik.length / dist;
    
    _ik.segments[i].x = _ik.segments[i - 1].x + dx * ratio;
    _ik.segments[i].y = _ik.segments[i - 1].y + dy * ratio;
}

// angle
for (var i = 0; i < _ik.amount; i++)
{
    _ik.segments[i].angle = point_direction(_ik.segments[i].x, _ik.segments[i].y, _ik.segments[i + 1].x, _ik.segments[i + 1].y);
}
