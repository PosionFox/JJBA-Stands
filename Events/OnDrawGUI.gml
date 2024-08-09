
#define OnDrawGUI

if (global.jjShowMenu)
{
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    
    var _rx1 = _cx - 128;
    var _ry1 = _cy - 256;
    var _rx2 = _cx + 128;
    var _ry2 = _cy + 256;
    
    draw_rectangle_color(_rx1, _ry1, _rx2, _ry2, c_black, c_black, c_gray, c_gray, false);
    
    draw_text(_cx, _ry1 + 32, "stand volume:");
    draw_line(_rx1, _ry1 + 64, _rx2, _ry1 + 64);
    draw_text(_cx, _ry1 + 64, string(global.jjAudioVolume * 100) + "%");
    
    var _b1 = draw_button(_cx - 96, _ry1 + 48, 10, "--");
    var _b2 = draw_button(_cx - 64, _ry1 + 48, 10, "-");
    var _b3 = draw_button(_cx + 64, _ry1 + 48, 10, "+");
    var _b4 = draw_button(_cx + 96, _ry1 + 48, 10, "++");
    
    if (_b1)
    {
        global.jjAudioVolume -= 0.1;
        global.jjAudioVolume = clamp(global.jjAudioVolume, 0, 1);
    }
    if (_b2)
    {
        global.jjAudioVolume -= 0.05;
        global.jjAudioVolume = clamp(global.jjAudioVolume, 0, 1);
    }
    if (_b3)
    {
        global.jjAudioVolume += 0.05;
        global.jjAudioVolume = clamp(global.jjAudioVolume, 0, 1);
    }
    if (_b4)
    {
        global.jjAudioVolume += 0.1;
        global.jjAudioVolume = clamp(global.jjAudioVolume, 0, 1);
    }
}

#define draw_button(_x, _y, _radius, _txt)

draw_circle(_x, _y, _radius, false);
draw_text(_x + _radius, _y + _radius, string(_txt));
if (mouse_check_button_pressed(mb_left) and point_in_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _radius))
{
    return true;
}
else
{
    return false;
}
