
#define OnDrawGUI

if (global.jjShowMenu and !instance_exists(objPlayerMenu))
{
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    
    var _rx1 = _cx - 512;
    var _ry1 = _cy - 256;
    var _rx2 = _cx + 512;
    var _ry2 = _cy + 256;
    
    draw_rectangle_color(_rx1, _ry1, _rx2, _ry2, c_black, c_black, c_gray, c_gray, false);
    
    if (instance_exists(STAND))
    {
        var _sx = _rx1 + 208;
        var _sy = _ry1 + 96;
        draw_text(_sx, _sy - 48, string_lower(STAND.name));
        
        var _stats = [
            ["destructive power", STAND.destructive_power, "destructive_power"],
            ["speed", STAND.spd, "spd"],
            ["range", STAND.range, "range"],
            ["stamina", STAND.stamina, "stamina"],
            ["precision", STAND.precision, "precision"]
        ]
        
        for (var i = 0; i < array_length(_stats); i++)
        {
            draw_text(_sx, _sy + (48 * i) + 24, string(_stats[i][0]) + ": " + string(_stats[i][1] * 100) + "%");
            if (draw_button_circle(_sx - 42, _sy + (48 * i) + 32, 8, "--"))
            {
                repeat (5)
                {
                    if (variable_instance_get(STAND, _stats[i][2]) > 0.5)
                    {
                        variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) - 0.01);
                        STAND.stat_points++;
                    }
                }
            }
            if (draw_button_circle(_sx - 16, _sy + (48 * i) + 32, 8, "-"))
            {
                if (variable_instance_get(STAND, _stats[i][2]) > 0.5)
                {
                    variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) - 0.01);
                    STAND.stat_points++;
                }
            }
            if (draw_button_circle(_sx + 16, _sy + (48 * i) + 32, 8, "+"))
            {
                if (STAND.stat_points > 0)
                {
                    variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) + 0.01);
                    STAND.stat_points--;
                }
            }
            if (draw_button_circle(_sx + 42, _sy + (48 * i) + 32, 8, "++"))
            {
                repeat (5)
                {
                    if (STAND.stat_points > 0)
                    {
                        variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) + 0.01);
                        STAND.stat_points--;
                    }
                }
            }
        }
        var _total_power = (GetStandTotalPower(STAND) * 100);
        draw_text(_sx, _sy + (48 * 6), "total power: " + string(_total_power) + "%");
        draw_text(_sx, _sy + (48 * 7), "development potential: " + string(STAND.development_potential * 100) + "%");
        draw_text(_sx, _sy + (48 * 8), "stat points: " + string(STAND.stat_points));
    }
    
    draw_text(_cx, _ry1 + 32, "stand volume:");
    draw_line(_rx1, _ry1 + 64, _rx2, _ry1 + 64);
    draw_text(_cx, _ry1 + 64, string(global.jjAudioVolume * 100) + "%");
    
    var _b1 = draw_button_circle(_cx - 96, _ry1 + 48, 10, "--");
    var _b2 = draw_button_circle(_cx - 64, _ry1 + 48, 10, "-");
    var _b3 = draw_button_circle(_cx + 64, _ry1 + 48, 10, "+");
    var _b4 = draw_button_circle(_cx + 96, _ry1 + 48, 10, "++");
    
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
    
    var _stx = _cx + 256;
    draw_text(_stx, _ry1 + 96, "stand storage:");
    
    var _bLeft = draw_button_circle(_stx - 96, _cy, 16, "-");
    var _bRight = draw_button_circle(_stx + 96, _cy, 16, "+");
    var _bLeftPlus = draw_button_circle(_stx - 128, _cy, 16, "--");
    var _bRightPlus = draw_button_circle(_stx + 128, _cy, 16, "++");
    
    var _arr_len = array_length(global.jjStandSlots);
    
    draw_text(_stx, _ry1 + 112, string(global.jjMenuMaxIndex) + "/" + string(_arr_len));
    
    if (_bLeft)
    {
        global.jjMenuMinIndex -= 8;
        global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
        global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
        global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
    }
    if (_bRight)
    {
        global.jjMenuMinIndex += 8;
        global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
        global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
        global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
    }
    if (_bLeftPlus)
    {
        global.jjMenuMinIndex -= 16;
        global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
        global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
        global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
    }
    if (_bRightPlus)
    {
        global.jjMenuMinIndex += 16;
        global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
        global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
        global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
    }
    
    for (var i = global.jjMenuMinIndex; i < global.jjMenuMaxIndex; i++)
    {
        var _text = "null";
        if (global.jjStandSlots[i] == undefined)
        {
            _text = "empty";
        }
        else
        {
            _text = string_split(global.jjStandSlots[i], ":")[1];
        }
        
        var _b = draw_button(_stx - 64, _ry1 + 128 + (40 * (i - global.jjMenuMinIndex)), 128, 32, string_lower(_text));
        if (_b)
        {
            if (global.jjStandSlots[i] == undefined and instance_exists(player.myStand))
            {
                global.jjStandSlots[i] = ConstructStandData(STAND);
                RemoveStand(player);
            }
            else if (global.jjStandSlots[i] != undefined and !instance_exists(player.myStand))
            {
                var _standData = global.jjStandSlots[i];
                global.jjStandSlots[i] = undefined;
                DeconstructStandData(_standData);
            }
        }
    }
}

#define draw_button(_x, _y, _w, _h, _txt)

draw_rectangle_color(_x, _y, _x + _w, _y + _h, c_black, c_black, c_black, c_black, false);
draw_text(_x + (_w / 2), _y + (_h / 2), _txt);
if (mouse_check_button_pressed(mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x + _w, _y + _h))
{
    return true;
}
else
{
    return false;
}

#define draw_button_circle(_x, _y, _radius, _txt)

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
