
#define draw_circle_thick(_x, _y, _radius, _thickness)

var inner_radius = _radius;
var thickness = _thickness;
var segments = 20;
var jadd = 360 / segments;
draw_primitive_begin(pr_trianglestrip);
for (var j = 0; j <= 360; j += jadd)
{
    draw_vertex(_x + lengthdir_x(inner_radius, j), _y + lengthdir_y(inner_radius, j));
    draw_vertex(_x + lengthdir_x(inner_radius + thickness , j), _y + lengthdir_y(inner_radius + thickness, j));
}
draw_primitive_end();

#define draw_button_square(_x, _y, _w, _h, _txt)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}

var _hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _w, _y + _h);
var _btn_color = _color1;
var _btn2_color = _color2;

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

//draw_rectangle_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
//draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, _btn_color, _btn_color, false);

draw_roundrect_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn2_color, _btn2_color, false);
draw_roundrect_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, false);

draw_text(_x + (_w / 2) + 8, _y + (_h / 2) + 8, _txt);

if (mouse_check_button_pressed(mb_left) and _hover)
{
    if (global.jjsSettCustomModMenuSounds)
    {
        jj_play_audio(global.sndMenuClick, 0, false);
    }
    else
    {
        jj_play_audio(sndUiSelect, 0, false);
    }
    return true;
}
else
{
    return false;
}

#define draw_storage_button(_x, _y, _w, _h, _txt, _txtcolor1, _txtcolor2)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}

var _hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _w, _y + _h);
var _btn_color = _color1;
var _btn2_color = _color2;

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

draw_rectangle_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, _btn_color, _btn_color, false);

draw_text_color(_x + (_w / 2), _y + (_h / 2), _txt, _txtcolor1, _txtcolor2, _txtcolor1, _txtcolor2, 1);

if (mouse_check_button_pressed(mb_left) and _hover)
{
    if (global.jjsSettCustomModMenuSounds)
    {
        jj_play_audio(global.sndMenuClick, 0, false);
    }
    else
    {
        jj_play_audio(sndUiSelect, 0, false);
    }
    return true;
}
else
{
    return false;
}

#define draw_button_rune(_x, _y, _w, _h, _rune)

var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}

var _hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _w, _y + _h);
var _btn_color = _color1;
var _btn2_color = _color2;

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjsMenuRuneDeleteMode)
    {
        _btn_color = c_red;
        _btn2_color = c_black;
    }
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
    if (_rune != undefined)
    {
        draw_set_color(c_ltgray);
        draw_text(_cx, _cy - 192, GetRarityName(_rune.rarity) + " " + string(_rune.name));
        draw_text(_cx, _cy - 192 + 8 + (string_height(_rune.description)), _rune.description);
        draw_set_color(c_white);
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

if (global.jjsMenuRuneDeleteMode)
{
    var _padding = 8 + sin(current_time / 100) * 4;
    draw_rectangle_color(_x - _padding, _y - _padding, _x + _w + _padding, _y + _h + _padding, c_red, c_red, c_red, c_red, false);
}
draw_rectangle_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, _btn_color, _btn_color, false);

if (_rune != undefined)
{
    var _rc = GetRarityColor(_rune.rarity);
    draw_sprite_ext(_rune.base_sprite, 0, _x + 32, _y + 32, 4, 4, 0, c_white, 1);
    draw_sprite_ext(_rune.sprite, 0, _x + 32, _y + 32, 4, 4, 0, _rc, 1);
}

if (mouse_check_button_pressed(mb_left) and _hover)
{
    if (global.jjsMenuRuneDeleteMode)
    {
        jj_play_audio(sndHitRock1, 0, false);
        RuneStorageErase(_rune);
    }
    else
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuClick, 0, false);
        }
        else
        {
            jj_play_audio(sndUiSelect, 0, false);
        }
        return true;
    }
}
else
{
    return false;
}

#define draw_button_square_alpha(_x, _y, _w, _h, _txt, _alpha)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (bool("myStand" in player) and instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}

var _hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _w, _y + _h);
var _btn_color = _color1;
var _btn2_color = _color2;

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (!global.jjNewGame) 
        {
            if (global.jjsSettCustomModMenuSounds)
            {
                jj_play_audio(global.sndMenuHover, 0, false);
            }
            else
            {
                jj_play_audio(sndBuildHoverBig, 0, false);
            }
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

draw_set_alpha(_alpha);
draw_rectangle_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, _btn_color, _btn_color, false);

draw_text(_x + (_w / 2) + 8, _y + (_h / 2) + 8, _txt);
draw_set_alpha(1);

if (mouse_check_button_pressed(mb_left) and _hover)
{
    if (global.jjsSettCustomModMenuSounds)
    {
        jj_play_audio(global.sndMenuClick, 0, false);
    }
    else
    {
        jj_play_audio(sndUiSelect, 0, false);
    }
    return true;
}
else
{
    return false;
}

#define draw_button_circle(_x, _y, _radius, _txt, _continuous)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _hover = point_in_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _radius);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

draw_circle_color(_x, _y, _radius + 4, _btn2_color, _btn2_color, false);
draw_circle_color(_x, _y, _radius, _btn_color, _btn_color, false);
draw_text(_x + _radius, _y + _radius, string(_txt));

if (_continuous)
{
    if (mouse_check_button(mb_left) and _hover)
    {
        return true;
    }
    else
    {
        return false;
    }
}
else
{
    if (mouse_check_button_pressed(mb_left) and _hover)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuClick, 0, false);
        }
        else
        {
            jj_play_audio(sndUiSelect, 0, false);
        }
        return true;
    }
    else
    {
        return false;
    }
}

#define draw_slider(_x, _y, _w, _h, _txt, _var)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _hover = point_in_rectangle(_mx, _my, _x, _y, _x + _w, _y + _h);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}

var _handle_x = _var * _w;
if (mouse_check_button(mb_left) and global.jjMenuHover == _x - _y * _x + _y)
{
    _handle_x = clamp((_mx - _x) / _w, 0, 1) * _w;
    _txt = string(round(clamp((_mx - _x) / _w, 0, 1) * 100)) + "%";
}
if (mouse_check_button_released(mb_left) and global.jjMenuHover == _x - _y * _x + _y)
{
    _var = clamp((_mx - _x) / _w, 0, 1);
    return _var;
}

if (!_hover and !mouse_check_button(mb_left))
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

var _sw = _w / 8;

draw_text(_x + 8 + (_w / 2), _y + 8 - 32, _txt);
draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn_color, _btn_color, _btn_color, _btn_color, false);
draw_rectangle_color(_x + _handle_x - (_sw / 2), _y, _x + _handle_x + (_sw / 2), _y + _h, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);

return undefined;

#define draw_checkbox(_x, _y, _size, _txt, _var)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _hover = point_in_rectangle(_mx, _my, _x, _y, _x + _size, _y + _size);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

if (mouse_check_button_pressed(mb_left) and _hover)
{
    var _snd = global.sndMenuClick;
    if (!global.jjsSettCustomModMenuSounds) _snd = sndUiSelect;
    jj_play_audio(_snd, 0, false);
    return !_var;
}

var _ctxt = "x";
if (_var == false)
{
    _ctxt = "";
}

draw_text(_x - (string_width(_txt) / 2) - 16, _y + string_height(_txt), _txt);
draw_rectangle_color(_x - 4, _y - 4, _x + _size + 4, _y + _size + 4, _btn_color, _btn_color, _btn_color, _btn_color, false);
draw_rectangle_color(_x, _y, _x + _size, _y + _size, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
draw_text_color(_x + _size - 16, _y + _size - 16, _ctxt, c_lime, c_lime, c_lime, c_lime, 1);

return _var;

#define draw_keybind(_x, _y, _w, _h, _txt, _var)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _hover = point_in_rectangle(_mx, _my, _x, _y, _x + _w, _y + _h);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

draw_text(_x - (string_width(_txt) / 2) - 16, _y + string_height(_txt), _txt);
draw_rectangle_color(_x - 4, _y - 4, _x + _w + 4, _y + _h + 4, _btn_color, _btn_color, _btn_color, _btn_color, false);
draw_rectangle_color(_x, _y, _x + _w, _y + _h, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);
draw_text(_x + _w - 8, _y + _h - 8, string_lower(_var));

if (mouse_check_button_pressed(mb_left) and _hover and global.jjsMenuWaitingInput == undefined)
{
    global.jjsMenuWaitingInput = _var;
}

if (global.jjsMenuWaitingInput == _var and keyboard_check_pressed(vk_anykey))
{
    global.jjsMenuWaitingInput = undefined;
    if (string_lettersdigits(keyboard_lastchar) != "")
    {
        return string_upper(keyboard_lastchar);
    }
}

return false;

#define draw_hscroll(_x, _y, _w, _max_val, _val) // unfinished

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _hover = point_in_circle(_mx, _my, _x, _y, 8);
var _rval = undefined;

if (global.jjMenuHover != _x - _y * _x + _y)
{
    if (global.jjsSettCustomModMenuSounds)
    {
        jj_play_audio(global.sndMenuHover, 0, false);
    }
    else
    {
        jj_play_audio(sndBuildHoverBig, 0, false);
    }
    global.jjMenuHover = _x - _y * _x + _y;
}


var _valsc = (_val / _max_val) * _w;
if (mouse_check_button(mb_left) and _hover)
{
    _valsc = clamp((_mx - _x) / _w, 0, 1) * _w;
}

draw_line_width_color(_x, _y, _x + _w, _y, 4,  c_dkgray, c_black);
draw_circle(_x + _valsc, _y, 8, false);

if (mouse_check_button_released(mb_left) and global.jjMenuHover == _x - _y * _x + _y)
{
    var _snd = global.sndMenuClick;
    if (!global.jjsSettCustomModMenuSounds) _snd = sndUiSelect;
    _rval = _valsc;
    jj_play_audio(_snd, 0, false);
}
return _rval;

#define draw_vscroll(_x, _y, _h, _thick, _max_var, _var)

var _color1 = Color.DarkBlue;
var _color2 = Color.Magenta;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _center = (_h / 8) / 2;
var _hover = point_in_rectangle(_mx, _my, _x, _y - _center, _x + _thick, _y + _center + _h);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
    }
}

if (mouse_check_button(mb_left) and global.jjMenuHover == _x - _y * _x + _y)
{
    _var = clamp((_my - _y) / _h, 0, 1) * _max_var;
    //_handle_pos = clamp((_my - _y) / _h, 0, 1) * _h;
}
if (mouse_check_button_released(mb_left) and global.jjMenuHover == _x - _y * _x + _y)
{
    var _snd = global.sndMenuClick;
    if (!global.jjsSettCustomModMenuSounds) _snd = sndUiSelect;
    jj_play_audio(_snd, 0, false);
    _var = clamp((_my - _y) / _h, 0, 1) * _max_var;
}

if (!_hover and !mouse_check_button(mb_left))
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

if (mouse_wheel_up())
{
    _var -= 8;
}
if (mouse_wheel_down())
{
    _var += 8;
}
_var = clamp(_var, 0, _max_var);

var _handle_pos = (_var / _max_var) * _h;

draw_rectangle_color(_x, _y - _center, _x + _thick, _y + _h + _center, _btn_color, _btn_color, _btn_color, _btn_color, false);
draw_rectangle_color(_x, _y + _handle_pos - _center, _x + _thick, _y + _handle_pos + _center, _btn2_color, _btn2_color, _btn2_color, _btn2_color, false);

return _var;

#define draw_pentagon(_x, _y)

var _cx = _x;
var _cy = _y;
var _radius = 100;
var _rotation = -90;

draw_set_color(c_orange);
draw_primitive_begin(pr_trianglestrip);

for (var i = 0; i <= 5; i++)
{
    var _angle = _rotation + (i * (360 / 5));
    
    var _vx = _cx + lengthdir_x(_radius, _angle);
    var _vy = _cy + lengthdir_y(_radius, _angle);
    
    draw_vertex(_cx, _cy);
    draw_vertex(_vx, _vy);
}

draw_primitive_end();

#define draw_hexagon_stats(_x, _y, _stats)

var _cx = _x;
var _cy = _y;
var _radius = 64;
var _rotation = 90;

for (var i = 0; i < 6; i++)
{
    var _angle = _rotation + (i * (360 / 6));
    var _vx = lengthdir_x(224, _angle);
    var _vy = lengthdir_y(224, _angle);
    draw_line_width(_cx, _cy, _cx + _vx, _cy + _vy, 2);
}

draw_primitive_begin(pr_trianglestrip);

for (var i = 0; i <= 6; i++)
{
    var _angle = _rotation + (i * (360 / 6));
    var _stp = min(_stats[i][0], 3.5);
    
    var _vx = _cx + lengthdir_x(_stp * _radius, _angle);
    var _vy = _cy + lengthdir_y(_stp * _radius, _angle);
    
    // draw_vertex(_cx, _cy);
    // draw_vertex(_vx, _vy);
    
    draw_vertex_color(_cx, _cy, c_white, 1);
    draw_vertex_color(_vx, _vy, _stats[i][1], 1);
    
}

draw_primitive_end();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i <= 5; i++)
{
    var _quality = "?";
    var _stp = _stats[i][0];
    if (_stp < 3) _quality = "sss";
    if (_stp < 2.75) _quality = "ss";
    if (_stp < 2.5) _quality = "s+";
    if (_stp < 2.25) _quality = "s";
    if (_stp < 2) _quality = "a+";
    if (_stp < 1.75) _quality = "a";
    if (_stp < 1.5) _quality = "b";
    if (_stp < 1.25) _quality = "c";
    if (_stp < 1) _quality = "d";
    if (_stp < 0.75) _quality = "e";
    if (_stp < 0.55) _quality = "f";
    _stp = min(_stp, 2.5);
    
    var _angle = _rotation + (i * (360 / 6));
    var _vx = _cx + lengthdir_x(_stp * _radius + 24, _angle);
    var _vy = _cy + lengthdir_y(_stp * _radius + 24, _angle);
    draw_set_color(_stats[i][1]);
    //draw_text(_vx, _vy, _quality);
    var _sc = _stp * .5 + .5
    draw_text_transformed(_vx, _vy, _quality, _sc, _sc, 0);
}
draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
