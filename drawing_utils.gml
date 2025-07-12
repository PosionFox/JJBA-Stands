
#define draw_button_square(_x, _y, _w, _h, _txt)

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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
        draw_text(_cx, _cy - 160, GetRarityName(_rune.rarity) + " " + string(_rune.name));
        draw_text(_cx, _cy - 160 + 16 + (string_height(_rune.description)), _rune.description);
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

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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
    var _snd = global.sndMenuClick;
    if (!global.jjsSettCustomModMenuSounds) _snd = sndUiSelect;
    _var = clamp((_mx - _x) / _w, 0, 1);
    var _s = audio_play_sound(_snd, 0, false);
    audio_sound_gain(_s, _var, 0);
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

return _var;

#define draw_checkbox(_x, _y, _size, _txt, _var)

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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

var _color1 = c_black;
var _color2 = c_gray;
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
