
#define StandSkillDrawGUI

if (!runDrawGUI) { exit; }

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;


//draw_text(128, 160, string(TimeControl.timer)); // debug
//draw_text(128, 192, string(TimeControl.lightState)); // debug
// 3 is night and 0 is dawn

var xx = 168;
var yy = _height - 200;

draw_set_alpha(global.jjsSettGuiVisibility);

// xp bar
if (!instance_exists(objPlayerMenu) and !instance_exists(uiCrafting))
{
    var _txt1 = "stand level " + string(level);
    var _txt2 = "(" + string(round(experience)) + "/" + string(round(experienceNext)) + ")";
    var _bx = 244;
    var _by = 80;
    var _length = 790;
    var _thickness = experience_display_thick;
    var _xp_bar = clamp(experience / experienceNext, 0, 1);
    
    draw_set_color(c_black);
    draw_line_width(_bx, _by, _bx + _length, _by, 2 * _thickness);
    draw_set_color(c_yellow);
    experience_display = lerp(experience_display, _xp_bar, 0.2);
    draw_line_width(_bx, _by, _bx + experience_display * _length, _by, 4 * _thickness);
    draw_set_color(c_white);
    draw_text(_bx + 8 + string_width(_txt1) / 2, _by, _txt1);
    draw_text(_bx + 8 + _length - string_width(_txt2) / 2, _by, _txt2);
}

// tier
var _tx = xx;
var _ty = yy - 64;
var _ss = random_range(0.85, 1.15);
var _spr = global.sprStarTier;
var _c = GetRarityColor(rarity.tier);

draw_sprite_ext(_spr, 0, _tx - 4, _ty, _ss, _ss, 0, _c, 0.8 * global.jjsSettGuiVisibility);
if (rarity.tier == Rarity.WIP)
{
    draw_text_color(_tx - 4, _ty + 32, "-wip-", Color.Lavender, Color.Lavender, Color.Lavender, Color.Lavender, global.jjsSettGuiVisibility);
}

var gx = device_mouse_x_to_gui(0);
var gy = device_mouse_y_to_gui(0);
if (point_in_rectangle(gx, gy, _tx - 16, _ty - 16, _tx + 16, _ty + 16))
{
    draw_text(gx + 8, gy, string(rarity.name) + " (" + string(rarity.probability) + "%)");
}

// combo counter
var _cx = xx;
var _cy = yy - 128;
var _ccolor = c_white;
if (combo > 25) _ccolor = c_lime;
if (combo > 50) _ccolor = c_blue;
if (combo > 75) _ccolor = c_yellow;
if (combo > 100) _ccolor = c_red;
if (combo > 0)
{
    draw_text_ext_transformed_color(_cx, _cy, string(combo), 1, 128, 1 + (combo / 100) + comboCounterLerp, 1 + (combo / 100) + comboCounterLerp, 0, _ccolor, _ccolor, _ccolor, _ccolor, 0.8 * global.jjsSettGuiVisibility);
}

//draw_text(mouse_x, mouse_y, string(energy_regen_mult));

// draw runes
var rx = xx - 128;
var ry = yy - 40;

var _rlen = array_length(runes);
for (var i = 0; i < _rlen; i++)
{
    var _rune = runes[i];
    
    if (_rune == undefined)
    {
        if (global.jjsSettDisplayEmptyRunes)
        {
            draw_sprite_ext(global.sprBlankRune, 0, rx, ry - (34 * i), 2, 2, 0, c_black, global.jjsSettGuiVisibility);
            
            if (point_in_rectangle(gx, gy, rx - 16, ry - 16 - (34 * i), rx + 16, ry + 16 - (34 * i)))
            {
                var txt = "no rune";
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
                draw_text(rx + 32, (ry - string_height(txt)) + 16 - (34 * i), txt);
                draw_set_halign(fa_center);
                draw_set_valign(fa_middle);
            }
        }
    }
    else
    {
        var _rc = GetRarityColor(_rune.rarity);
        draw_sprite_ext(_rune.base_sprite, 0, rx, ry - (34 * i), 2, 2, 0, c_white, global.jjsSettGuiVisibility);
        draw_sprite_ext(_rune.sprite, 0, rx, ry - (34 * i), 2, 2, 0, _rc, global.jjsSettGuiVisibility);
        
        if (point_in_rectangle(gx, gy, rx - 16, ry - 16 - (34 * i), rx + 16, ry + 16 - (34 * i)))
        {
            var txt = "click to remove";
            // draw_set_color(c_dkgray);
            // draw_rectangle(rx + 32, ry - string_height(txt) - (34 * i), rx + string_width(txt), ry + string_height(txt) - (34 * i), false);
            // draw_set_color(c_white);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(rx + 32, (ry - string_height(txt)) + 16 - (34 * i), txt);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            if (mouse_check_button_pressed(mb_left))
            {
                RuneRemove(player, i);
            }
        }
    }
}


// trait
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
var _tc = GetRarityColor(trait.rarity);
draw_text_color(32, _height - 186, string_lower(string(trait.name)), _tc, _tc, _tc, _tc, global.jjsSettGuiVisibility);
draw_text_color(32, _height - 138, string_lower(string(name)), color, colorAlt, color, colorAlt, global.jjsSettGuiVisibility);
draw_line_color(32, _height - 144, 32 + 255, _height - 144, color, c_black);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// skills
draw_text(24, _height - 84, string_lower(player.summonKeybind));

var _start = StandState.SkillAOff;
var _end = StandState.SkillDOff;
if (active)
{
    _start = StandState.SkillA;
    _end = StandState.SkillD;
}

for (var i = _start; i <= _end; i++)
{
    var xx = 64 + (64 * ((i - 1) mod 4));
    var yy = (_height - 96);
    
    // tap
    if (skills[i, StandSkill.Skill] != AttackHandler)
    {
        var _s = global.sprSkillTemplate;
        //if (color_get_value(color) < 80) { _s = global.sprSkillTemplateWhite; }
        if (state == i and !altAttack) { _s = global.sprSkillTemplateWhite; }
        //draw_sprite_ext(_s, 0, xx, yy, 2, 2, 0, c_white, 1);
        draw_sprite_general(_s, 0, 0, 0, 32, 32, xx - 32, yy - 32, 2, 2, 0, colorAlt, colorAlt, color, color, global.jjsSettGuiVisibility);
        //draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, yy, 2, 2, 0, color, 1);
        draw_sprite_general(skills[i, StandSkill.Icon], 0, 0, 0, 32, 32, xx - 32, yy - 32, 2, 2, 0, color, color, colorAlt, colorAlt, global.jjsSettGuiVisibility);
        if (skills[i, StandSkill.Cooldown] > 0)
        {
            var _ctxt = string(skills[i, StandSkill.Cooldown]);
            if (skills[i, StandSkill.Cooldown] > 1) _ctxt = string(round(skills[i, StandSkill.Cooldown]));
            var cyy = ((skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown]) * 2) * GetStandStamina(self);
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy, 2, cyy, 0, c_white, 0.8 * global.jjsSettGuiVisibility);
            draw_text(xx + 8, yy + 10, _ctxt);
        }
        
        draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
    }
    // hold
    if (skills[i, StandSkill.SkillAlt] != AttackHandler)
    {
        var _s = global.sprSkillHoldTemplate;
        //if (color_get_value(color) < 80) { _s = global.sprSkillHoldTemplateWhite; }
        if (state == i and altAttack) { _s = global.sprSkillHoldTemplateWhite; }
        //draw_sprite_ext(_s, 0, xx, yy + 64, 2, 2, 0, c_white, 1);
        draw_sprite_general(_s, 0, 0, 0, 32, 32, xx - 32, yy - 32 + 64, 2, 2, 0, color, color, colorAlt, colorAlt, global.jjsSettGuiVisibility);
        //draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, yy + 64, 2, 2, 0, color, 1);
        draw_sprite_general(skills[i, StandSkill.IconAlt], 0, 0, 0, 32, 32, xx - 32, yy - 32 + 64, 2, 2, 0, colorAlt, colorAlt, color, color, global.jjsSettGuiVisibility);
        var _hold = (skills[i, StandSkill.Hold] / skills[i, StandSkill.MaxHold]) * 2;
        draw_sprite_ext(global.sprSkillHold, 0, xx, yy + 64, 2, _hold, 0, color, 0.8 * global.jjsSettGuiVisibility);
        if (skills[i, StandSkill.CooldownAlt] > 0)
        {
            var _ctxt = string(skills[i, StandSkill.CooldownAlt]);
            if (skills[i, StandSkill.CooldownAlt] > 1) _ctxt = string(round(skills[i, StandSkill.CooldownAlt]));
            var cyy = ((skills[i, StandSkill.CooldownAlt] / skills[i, StandSkill.MaxCooldownAlt]) * 2) * GetStandStamina(self);
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy + 64, 2, cyy, 0, c_white, 0.8 * global.jjsSettGuiVisibility);
            draw_text(xx + 8, yy + 74, _ctxt);
        }
    }
    //show tooltip
    var gx = device_mouse_x_to_gui(0);
    var gy = device_mouse_y_to_gui(0);
    if (point_in_rectangle(gx, gy, xx - 32, yy - 32, xx + 32, yy + 32) and skills[i, StandSkill.Desc] != "")
    {
        //var dmg = skills[i, StandSkill.Damage] + (player.level * skills[i, StandSkill.DamageScale]);
        var desc = skills[i, StandSkill.Desc];
        var txt = desc;
        if (skills[i, StandSkill.Damage] != 0)
        {
            txt += "\n\n" + tr("dmgDisplay") + ": " + string(GetDmg(i)) + " + " + string(player.dmg);
        }
        // if (skills[i, StandSkill.DamageAlt] != 0)
        // {
        //     txt += "\n" + tr("dmgDisplay") + " alt: " + string(GetDmg(i)) + " + " + string(player.dmg);
        // }
        // draw_set_color(0x1a1117);
        
        // draw_rectangle(gx, (yy - 64) - string_height(txt), gx + string_width(txt), (yy - 64), false);
        // draw_set_color(0x2b2938);
        
        // draw_rectangle(gx, (yy - 64) - string_height(txt) - 4, gx + string_width(txt), (yy - 64) + 4, false);
        var _bc1 = Color.DarkBlue;
        var _bc2 = Color.Magenta;
        if (instance_exists(STAND) and global.jjsSettBackgroundStandColors)
        {
            _bc1 = STAND.color;
            _bc2 = STAND.colorAlt;
        }
        var _bgx1 = gx;
        var _bgx2 = (yy - 64) - string_height(txt);
        var _bgy1 = gx + string_width(txt);
        var _bgy2 = (yy - 64);
        draw_rectangle_color(_bgx1 - 8, _bgx2 - 8, _bgy1 + 8, _bgy2 + 8, _bc2, _bc2, _bc1, _bc1, false);
        draw_rectangle_color(_bgx1 - 4, _bgx2 - 4, _bgy1 + 4, _bgy2 + 4, _bc1, _bc1, _bc2, _bc2, false);
        
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(gx + 9, ((yy - 64) - string_height(txt)) + 8, txt);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    }
}

xx = 168;
yy = _height - 200;
// draw energy bar
if (max_energy > 0)
{
    var _color = make_color_rgb(0, abs(sin(current_time / 1000)) * 254, abs(sin(current_time / 1000)) * 254);
    draw_line_width_color(xx - 134, yy + 134, (xx - 134) + ((energy / max_energy) * 250), yy + 134, abs(sin(current_time / 1000)) * 5, _color, _color);
}

// controller
xx = 400;
if (stand_mode)
{
    draw_text(xx, _height - 144 - 24, "stand mode");
}
if (lockon_mode)
{
    draw_text(xx, _height - 144 - 48, "lock-on mode");
}
if (alt_mode)
{
    draw_text(xx, _height - 144 - 72, "hold mode");
}

draw_set_alpha(1);

#define StandSkillRunCD(s)

for (var i = StandState.LEN - 1; i > 0; i--)
{
    if (s[@ i, StandSkill.Cooldown] > 0)
    {
        s[@ i, StandSkill.Cooldown] -= DT * CDMultiplier;
    }
    if (s[@ i, StandSkill.CooldownAlt] > 0)
    {
        s[@ i, StandSkill.CooldownAlt] -= DT * CDMultiplier;
    }
}

#define StandSkillDefaultCDs

StandSkillRunCD(skills);

#define StandSkillManage

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    if (state == StandState.Idle and active == skills[i, StandSkill.ActiveOnly])
    {
        if (owner.hp != 0 and !instance_exists(objPlayerMenu) and !global.jjShowMenu)
        {
            if (keyboard_check(ord(skills[i, StandSkill.Key])) or (stand_mode and gamepad_button_check_pressed(0, skills[i, StandSkill.GpBtn])))
            {
                if (max_energy > 0)
                {
                    if (energy >= skills[i, StandSkill.EnergyCost] and skills[i, StandSkill.SkillAlt] != AttackHandler)
                    {
                        skills[i, StandSkill.Hold] += DT;
                        skills[i, StandSkill.Hold] = clamp(skills[i, StandSkill.Hold], 0, skills[i, StandSkill.MaxHold]);
                        if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold] and !altAttack)
                        {
                            altAttack = true;
                            var _s = jj_play_audio(sndCoin1, 1, false);
                            audio_sound_pitch(_s, 1.5);
                        }
                        if (alt_mode)
                        {
                            altAttack = true;
                        }
                    }
                }
                else
                {
                    if (skills[i, StandSkill.CooldownAlt] <= 0 and skills[i, StandSkill.SkillAlt] != AttackHandler)
                    {
                        skills[i, StandSkill.Hold] += DT;
                        skills[i, StandSkill.Hold] = clamp(skills[i, StandSkill.Hold], 0, skills[i, StandSkill.MaxHold]);
                        if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold] and !altAttack)
                        {
                            altAttack = true;
                            var _s = jj_play_audio(sndCoin1, 1, false);
                            audio_sound_pitch(_s, 1.5);
                        }
                        if (alt_mode)
                        {
                            altAttack = true;
                        }
                    }
                }
            }
            if (keyboard_check_released(ord(skills[i, StandSkill.Key])) or (stand_mode and gamepad_button_check_pressed(0, skills[i, StandSkill.GpBtn])))
            {
                if (max_energy > 0)
                {
                    if (energy >= skills[i, StandSkill.EnergyCost])
                    {
                        if (!altAttack and skills[i, StandSkill.Cooldown] <= 0)
                        {
                            state = i;
                        }
                        else if (altAttack)
                        {
                            state = i;
                        }
                        skills[i, StandSkill.Hold] = 0;
                        energy -= skills[i, StandSkill.EnergyCost];
                        energy_regen_mult = 1;
                    }
                }
                else
                {
                    if (!altAttack and skills[i, StandSkill.Cooldown] <= 0)
                    {
                        state = i;
                    }
                    else if (altAttack)
                    {
                        state = i;
                    }
                    height_target = 0;
                    skills[i, StandSkill.Hold] = 0;
                }
            }
        }
    }
}

if (state != StandState.Idle)
{
    //height = lerp(height, 0, 0.2);
    for (var i = 1; i < StandState.LEN; i++)
    {
        if (state == i)
        {
            if (altAttack)
            {
                script_execute(skills[i, StandSkill.SkillAlt], state, undefined);
            }
            else
            {
                script_execute(skills[i, StandSkill.Skill], state, undefined);
            }
            if (skills[i, StandSkill.ExecutionTime] >= skills[i, StandSkill.MaxExecutionTime]) {
                FireCD(i);
                state = StandState.Idle;
            }
        }
    }
}

script_execute(runCDsMethod);

#define get_aim_position(_stand)

if (_stand.stand_mode)
{
    return { x : aim_x, y : aim_y }
}
else
{
    return { x : mouse_x, y : mouse_y }
}

#define get_aim_distance(_stand, _from)

if (_stand.stand_mode)
{
    return point_distance(_from.x, _from.y, aim_x, aim_y);
}
else
{
    return point_distance(_from.x, _from.y, mouse_x, mouse_y);
}

#define StandDefaultSummon

if (state == StandState.Idle)
{
    if ((keyboard_check_pressed(ord(player.summonKeybind)) or (stand_mode and gamepad_button_check_pressed(0, player.summonKeymap))) and owner.freeze < 1)
    {
        active = !active;
        if (active)
        {
            if (summonSound != noone and playSummonSound)
            {
                if (is_array(summonSound))
                {
                    var _s = irandom(array_length(summonSound) - 1);
                    var _is_playing = false;
                    for (var i = 0; i < array_length(summonSound); i++)
                    {
                        if audio_is_playing(summonSound[i]) _is_playing = true;
                        break;
                    }
                    if (!_is_playing) jj_play_audio(summonSound[_s], 5, false);
                }
                else
                {
                    if (!audio_is_playing(summonSound)) jj_play_audio(summonSound, 0, false);
                }
            }
        }
    }
}

#define StandDefaultPos

var xPos = mouseXSide;
if (instance_exists(owner))
{
    xTo = owner.x - (xPos * 16);
    yTo = owner.y - 8;
}

#define StandDefaultStep

depth = -y;

if (!instance_exists(objPlayerMenu))
{
    script_execute(summonMethod);
}

if (instance_exists(owner))
{
    mouseXSide = sign(owner.facing);
    if (active and bool("hp" in owner) and owner.hp <= 0)
    {
        state = StandState.Idle;
        if (barrageData.sound != noone and audio_is_playing(barrageData.sound))
        {
            audio_stop_sound(barrageData.sound);
        }
        active = false;
    }
    
    // controller
    if (bool("standModeKeymap" in owner) and gamepad_button_check_pressed(0, owner.standModeKeymap))
    {
        stand_mode = !stand_mode;
        if (stand_mode)
        {
            InputReassign(Input.A, 0, -2, "gamepad");
            InputReassign(Input.B, 0, -3, "gamepad");
            InputReassign(Input.X, 0, -4, "gamepad");
            InputReassign(Input.Y, 0, -5, "gamepad");
            InputReassign(Input.Interact, 0, -6, "gamepad");
            InputReassign(Input.Menu, 0, -7, "gamepad");
            InputReassign(Input.Space, 0, -8, "gamepad");
            //InputReassign(Input.RightStick, 0, -9, "gamepad");
        }
        else
        {
            InputReassign(Input.A, 0, gp_face1, "gamepad");
            InputReassign(Input.B, 0, gp_face2, "gamepad");
            InputReassign(Input.X, 0, gp_face3, "gamepad");
            InputReassign(Input.Y, 0, gp_face4, "gamepad");
            InputReassign(Input.Interact, 0, gp_face1, "gamepad");
            InputReassign(Input.Menu, 0, gp_face2, "gamepad");
            //InputReassign(Input.RightStick, 0, gp_stickr, "gamepad");
        }
    }
    
    if (bool("lockonKeymap" in owner) and gamepad_button_check_pressed(0, owner.lockonKeymap))
    {
        lockon_mode = !lockon_mode;
        if (lockon_mode and enemy_instance_exists())
        {
            lockon_target = get_nearest_enemy(aim_x, aim_y);
        }
        else
        {
            lockon_target = noone;
            aim_x = owner.x;
            aim_y = owner.y;
        }
    }
    if (bool("altModeKeymap" in owner) and gamepad_button_check_pressed(0, owner.altModeKeymap))
    {
        alt_mode = !alt_mode;
    }
}

x = lerp(x, xTo, velocity);
y = lerp(y, yTo, velocity);
image_alpha = lerp(image_alpha, alphaTarget, 0.1);
image_angle = lerp(image_angle, angleTarget * image_xscale, angleTargetSpd);
image_xscale = lerp(image_xscale, scaleX, scaleXSpd);
image_yscale = lerp(image_yscale, scaleY, scaleYSpd);
experience_display_thick = lerp(experience_display_thick, 1, 0.3);

if (instance_exists(owner))
{
    if (active)
    {
        if (owner.freeze < 1)
        {
            if (state == StandState.Idle)
            {
                scaleX = mouseXSide;
                image_xscale = mouseXSide;
                alphaTarget = 1;
                if (runIdlePos)
                {
                    script_execute(idlePos);
                }
                height = 2 + (cos(current_time / 1000) * 2);
            }
            if (global.jjsSettShowStandAura)
            {
                var _e = EffectStandAuraCreate(x, y - height, auraParticleSprite, color);
                _e.depth = depth + 2;
                _e.owner = self;
                _e.rotation = auraParticleRotation;
            }
        }
    }
    else
    {
        if (state == StandState.Idle)
        {
            scaleX = 0;
            alphaTarget = 0;
            xTo = owner.x;
            yTo = owner.y;
        }
    }
}
height = lerp(height, height_target, height_speed);

if (soundIdleTimer <= 0)
{
    var _sound = soundIdle;
    if (_sound != undefined)
    {
        if (is_array(_sound))
        {
            var i = irandom(array_length(_sound) - 1);
            jj_play_audio(_sound[i], 0, false);
        }
        else
        {
            jj_play_audio(_sound, 0, false);
        }
        soundIdleTimer = irandom_range(60, 120);
    }
}
soundIdleTimer -= DT;

if (instance_exists(owner))
{
    // controller
    if (stand_mode)
    {
        if (!lockon_mode)
        {
            //if (abs(owner.h) >= 0.5 or abs(owner.v) >= 0.5)
            var _axh = gamepad_axis_value(0, gp_axislh);
            var _axv = gamepad_axis_value(0, gp_axislv);
            if (abs(_axh) > 0.25 or abs(_axv) > 0.25)
            
            {
                aim_x = lerp(aim_x, owner.x + (_axh * 64), 0.25);
                aim_y = lerp(aim_y, owner.y + (_axv * 64), 0.25);
            }
        }
        
        owner.attack_direction = point_direction(x, y, aim_x, aim_y);
        
        if (lockon_mode)
        {
            if (instance_exists(lockon_target))
            {
                var _n = lockon_target;
                aim_x = _n.x;
                aim_y = _n.y;
                owner.attack_direction = point_direction(x, y, aim_x, aim_y);
            }
            else if (enemy_instance_exists())
            {
                lockon_target = get_nearest_enemy(aim_x, aim_y);
            }
            else
            {
                lockon_mode = false;
                lockon_target = noone;
            }
        }
    }
    if (owner.freeze < 1)
    {
        StandSkillManage();
    }
}

max_energy = GetRunesMaxEnergy(self);
if (max_energy > 0)
{
    energy += (max_energy * 0.0005) * energy_regen_mult;
    energy_regen_mult += DT * 0.5;
    energy = clamp(energy, 0, max_energy);
    energy_regen_mult = clamp(energy_regen_mult, 1, 8);
}

comboCounterLerp = lerp(comboCounterLerp, 0, 0.1);
if !(modTypeExists("timestop"))
{
    if (comboResetTimer > 0)
    {
        comboResetTimer -= DT;
    }
    else
    {
        combo = 0;
    }
}

if (experience >= experienceNext)
{
    if (level < 100)
    {
        level++;
        experience = max(experience - experienceNext, 0);
        experience_display = 0;
        experienceNext = (12 * level) / (1 + (level / 20));
        var _statsgain = irandom_range(1, round(1 + powerMultiplier));
        if (rarity.tier == Rarity.Ordinary)
        {
            _statsgain *= 10;
        }
        if (rarity.tier == Rarity.Tragic)
        {
            _statsgain *= 5;
        }
        stat_points += _statsgain;
        experience_display_thick += 8;
        
        var _e = ShrinkingCircleEffect(x, y);
        _e.color = c_yellow;
        _e.radius = 16;
        
        if (global.jjsSettLevelUpSound and !audio_is_playing(global.sndStandLevelUp))
        {
            var _s = audio_play_sound(global.sndStandLevelUp, 10, false);
            audio_sound_gain(_s, global.jjSettAudioVolume * 0.5, 0);
        }
    }
}

#define StandDefaultDraw

if (pre_draw != undefined)
{
    ScriptCall(pre_draw);
}

if (active or image_alpha > 0)
{
    var _sf = clamp(1 / (1 + (height * 0.04)), 0.2, 1);
    draw_sprite_ext(sprShadow, 0, x, y + 2, image_xscale * _sf, image_yscale * _sf, 0, c_white, image_alpha * 0.5);
}
draw_sprite_ext(sprite_index, image_index, x, y - height, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (post_draw != undefined)
{
    ScriptCall(post_draw);
}

if (stand_mode)
{
    var _tt = (sin(current_time / 100) * 1);
    draw_set_color(color);
    draw_circle_thick(aim_x, aim_y, 5 + _tt, 2 + _tt);
    draw_set_color(colorAlt);
    draw_circle_thick(aim_x, aim_y, 6 + _tt, 2 + _tt);
    if (lockon_mode)
    {
        draw_line_width_color(owner.x, owner.y, aim_x, aim_y, 2, color, colorAlt);
    }
    draw_set_color(c_white);
}

#define StandSkillInit()

var _arr;
var _s;

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    _s = i;
    _arr[_s, StandSkill.ActiveOnly] = i > StandState.SkillDOff;
    // tap
    _arr[_s, StandSkill.Skill] = AttackHandler;
    _arr[_s, StandSkill.Icon] = global.sprSkillSkip;
    _arr[_s, StandSkill.Damage] = 0;
    _arr[_s, StandSkill.DamageScale] = 0;
    _arr[_s, StandSkill.DamagePlayerStat] = true;
    _arr[_s, StandSkill.MaxCooldown] = 1;
    _arr[_s, StandSkill.Cooldown] = 0;
    _arr[_s, StandSkill.Vars] = {};
    _arr[_s, StandSkill.Custom] = false;
    // hold
    _arr[_s, StandSkill.SkillAlt] = AttackHandler;
    _arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
    _arr[_s, StandSkill.DamageAlt] = 0;
    _arr[_s, StandSkill.DamageScaleAlt] = 0;
    _arr[_s, StandSkill.DamagePlayerStatAlt] = true;
    _arr[_s, StandSkill.MaxCooldownAlt] = 1;
    _arr[_s, StandSkill.CooldownAlt] = 0;
    _arr[_s, StandSkill.VarsAlt] = {};
    _arr[_s, StandSkill.CustomAlt] = false;
    // both
    _arr[_s, StandSkill.Key] = "";
    _arr[_s, StandSkill.GpBtn] = Input.DPad;
    _arr[_s, StandSkill.MaxHold] = 0.5;
    _arr[_s, StandSkill.Hold] = 0;
    _arr[_s, StandSkill.MaxExecutionTime] = 5;
    _arr[_s, StandSkill.ExecutionTime] = 0;
    _arr[_s, StandSkill.Desc] = "";
}

// keyboard inputs
_arr[StandState.SkillAOff, StandSkill.Key] = player.abilityKeybind1;
_arr[StandState.SkillBOff, StandSkill.Key] = player.abilityKeybind2;
_arr[StandState.SkillCOff, StandSkill.Key] = player.abilityKeybind3;
_arr[StandState.SkillDOff, StandSkill.Key] = player.abilityKeybind4;
_arr[StandState.SkillA, StandSkill.Key] = _arr[StandState.SkillAOff, StandSkill.Key];
_arr[StandState.SkillB, StandSkill.Key] = _arr[StandState.SkillBOff, StandSkill.Key];
_arr[StandState.SkillC, StandSkill.Key] = _arr[StandState.SkillCOff, StandSkill.Key];
_arr[StandState.SkillD, StandSkill.Key] = _arr[StandState.SkillDOff, StandSkill.Key];

// controller inputs
_arr[StandState.SkillAOff, StandSkill.GpBtn] = player.abilityKeymap1;
_arr[StandState.SkillBOff, StandSkill.GpBtn] = player.abilityKeymap2;
_arr[StandState.SkillCOff, StandSkill.GpBtn] = player.abilityKeymap3;
_arr[StandState.SkillDOff, StandSkill.GpBtn] = player.abilityKeymap4;
_arr[StandState.SkillA, StandSkill.GpBtn] = _arr[StandState.SkillAOff, StandSkill.GpBtn];
_arr[StandState.SkillB, StandSkill.GpBtn] = _arr[StandState.SkillBOff, StandSkill.GpBtn];
_arr[StandState.SkillC, StandSkill.GpBtn] = _arr[StandState.SkillCOff, StandSkill.GpBtn];
_arr[StandState.SkillD, StandSkill.GpBtn] = _arr[StandState.SkillDOff, StandSkill.GpBtn];

_arr[StandState.SkillAOff, StandSkill.EnergyCost] = 25;
_arr[StandState.SkillBOff, StandSkill.EnergyCost] = 50;
_arr[StandState.SkillCOff, StandSkill.EnergyCost] = 75;
_arr[StandState.SkillDOff, StandSkill.EnergyCost] = 100;
_arr[StandState.SkillA, StandSkill.EnergyCost] = 25;
_arr[StandState.SkillB, StandSkill.EnergyCost] = 50;
_arr[StandState.SkillC, StandSkill.EnergyCost] = 75;
_arr[StandState.SkillD, StandSkill.EnergyCost] = 100;

return _arr;

#define StandUpdateKeybinds()

if (instance_exists(player) and instance_exists(STAND))
{
    var _sk = STAND.skills;
    _sk[@ StandState.SkillAOff][@ StandSkill.Key] = player.abilityKeybind1;
    _sk[@ StandState.SkillBOff][@ StandSkill.Key] = player.abilityKeybind2;
    _sk[@ StandState.SkillCOff][@ StandSkill.Key] = player.abilityKeybind3;
    _sk[@ StandState.SkillDOff][@ StandSkill.Key] = player.abilityKeybind4;
    _sk[@ StandState.SkillA][@ StandSkill.Key] = _sk[StandState.SkillAOff][StandSkill.Key];
    _sk[@ StandState.SkillB][@ StandSkill.Key] = _sk[StandState.SkillBOff][StandSkill.Key];
    _sk[@ StandState.SkillC][@ StandSkill.Key] = _sk[StandState.SkillCOff][StandSkill.Key];
    _sk[@ StandState.SkillD][@ StandSkill.Key] = _sk[StandState.SkillDOff][StandSkill.Key];
}

#define StandBuilder(_owner, _skills)

if (!instance_exists(_owner))
{
    if (instance_exists(player))
    {
        _owner = player;
    }
    if (instance_exists(STAND))
    {
        exit;
    }
}
if !bool("myStand" in _owner)
{
    _owner.myStand = noone;
}

RemoveStand(_owner);

// init
var _stand = ModObjectSpawn(_owner.x, _owner.y, 0);
with (_stand)
{
    // properties
    type = "stand";
    name = "unknown";
    owner = _owner;
    targets = [ENEMY, MOBJ, NATURAL, CRITTER];
    sprite_index = global.sprStarPlatinum;
    xTo = _owner.x;
    yTo = _owner.y;
    height = 0;
    height_target = 0;
    height_speed = 0.2;
    rarity = {
        tier : Rarity.Common,
        name : tr("commonName"),
        color : c_white,
        probability : 1
    };
    UpdateRarity(rarity.tier);
    saveKey = "jjbamStandless";
    discType = noone;
    color = c_white;
    colorAlt = c_white;
    summonSound = global.sndStandSummon;
    playSummonSound = true;
    auraParticleSprite = global.sprStandParticle;
    auraParticleRotation = 0;
    comboCounterLerp = 0;
    comboResetTimer = 0;
    barrageData = {
        sound : noone,
        hitSound : noone,
        hitEvent : noone,
        hitEventArgs : noone
    };
    // state
    CDMultiplier = 1;
    attackState = 0;
    attackStateTimer = 0;
    active = false;
    state = StandState.Idle;
    mouseXSide = sign(owner.image_xscale);
    alphaTarget = 0;
    angleTarget = 0;
    angleTargetSpd = 0.1;
    scale = 1;
    scaleX = 1;
    scaleXSpd = 0.1;
    scaleY = 1;
    scaleYSpd = 0.1;
    look_x = x;
    look_y = y;
    target = noone;
    altAttack = false;
    soundIdle = undefined;
    soundIdleTimer = irandom_range(60, 120);
    soundWhenHurt = undefined;
    soundWhenDead = undefined;
    runIdlePos = true;
    idlePos = StandDefaultPos;
    summonMethod = StandDefaultSummon;
    runCDsMethod = StandSkillDefaultCDs;
    runDrawGUI = true;
    // stats
    level = 1;
    experience = 0;
    experienceNext = 12;
    experience_display = 0;
    experience_display_thick = 1;
    trait = {};
    stat_points = 0;
    destructive_power = (irandom_range(50, 200) / 100);
    spd = (irandom_range(50, 200) / 100);
    range = (irandom_range(50, 200) / 100);
    stamina = (irandom_range(50, 200) / 100);
    precision = (irandom_range(50, 200) / 100);
    development_potential = (irandom_range(50, 300) / 100);
    mod_destructive_power = 0;
    mod_spd = 0;
    mod_range = 0;
    mod_stamina = 0;
    mod_precision = 0;
    combo = 0;
    powerMultiplier = GetPowerMultiplier(rarity.tier);
    velocity = 0.5;
    stand_reach = 8;
    attack_reach = 1;
    crit_chance = 0;
    runes = [undefined, undefined, undefined];
    max_energy = 0;
    energy = max_energy;
    energy_regen_mult = 1;
    // skills
    skills = array_clone(_skills);
    movesets = [skills];
    // variants and evolutions
    variants = [];
    evolutions = [];
    // serializable data
    extra_serial_data = ds_map_create();
    // controller
    stand_mode = false;
    lockon_mode = false;
    lockon_target = noone;
    alt_mode = false;
    aim_x = x;
    aim_y = y;
    
    trait_give_random(self);
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandDefaultStep), false);
    pre_draw = undefined;
    InstanceAssignMethod(self, "draw", ScriptWrap(StandDefaultDraw), false);
    post_draw = undefined;
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);
    _owner.myStand = self;
}
return _stand;

#define StandGainExp(_stand, _xp)

if (instance_exists(_stand) and bool("experience" in _stand) and _stand.level < 100)
{
    var _da_xp = _xp * _stand.development_potential;
    _stand.experience += _da_xp;
    _stand.experience_display_thick += 2;
    if (global.jjsSettLevelUpParticle) EffectStandXPCreate(_stand, _da_xp);
}

#define GetPowerMultiplier(_rarity)

var _value = 1;
switch(_rarity)
{
    case Rarity.WIP: _value = 1; break;
    case Rarity.Ordinary: _value = 0.1; break;
    case Rarity.Tragic: _value = 0.5; break;
    case Rarity.Common: _value = 1; break;
    case Rarity.Uncommon: _value = 2; break;
    case Rarity.Rare: _value = 3; break;
    case Rarity.Epic: _value = 4; break;
    case Rarity.Legendary: _value = 5; break;
    case Rarity.Mythical: _value = 6; break;
    case Rarity.Celestial: _value = 7; break;
    case Rarity.Ultimate: _value = 8; break;
    case Rarity.Bizarre: _value = 9; break;
    case Rarity.Event: _value = 10; break;
}
return _value;

#define GetRarityName(_rarity)

switch(_rarity)
{
    case Rarity.WIP: return "wip"; break;
    case Rarity.Ordinary: return tr("ordinaryName"); break;
    case Rarity.Tragic: return tr("tragicName"); break;
    case Rarity.Common: return tr("commonName"); break;
    case Rarity.Uncommon: return tr("uncommonName"); break;
    case Rarity.Rare: return tr("rareName"); break;
    case Rarity.Epic: return tr("epicName"); break;
    case Rarity.Legendary: return tr("legendaryName"); break;
    case Rarity.Mythical: return tr("mythicalName"); break;
    case Rarity.Celestial: return tr("celestialName"); break;
    case Rarity.Ultimate: return tr("ultimateName"); break;
    case Rarity.Bizarre: return tr("bizarreName"); break;
    case Rarity.Event: return tr("eventName"); break;
}

#define GetRarityColor(_rarity)

var _cc = make_color_hsv(abs(sin(current_time / 500)) * 32, 255, 255);
var _cu = make_color_hsv(64 + abs(sin(current_time / 500)) * 64, abs(sin(current_time / 250)) * 255, 255);
var _cb = make_color_hsv((current_time / 10) mod 255, 255 - abs(sin(current_time / 250)) * 64, 255);
var _ce = make_color_hsv(128 + abs(sin(current_time / 500)) * 32, abs(sin(current_time / 600)) * 255, abs(sin(current_time / 700)) * 255);

switch(_rarity)
{
    case Rarity.WIP: return Color.Lavender; break;
    case Rarity.Ordinary: return Color.DarkBlue; break;
    case Rarity.Tragic: return Color.GrayBlue; break;
    case Rarity.Common: return Color.White; break;
    case Rarity.Uncommon: return Color.LightGreen; break;
    case Rarity.Rare: return Color.Blue; break;
    case Rarity.Epic: return Color.Purple; break;
    case Rarity.Legendary: return Color.Gold; break;
    case Rarity.Mythical: return Color.Red; break;
    case Rarity.Celestial: return _cc; break;
    case Rarity.Ultimate: return _cu; break;
    case Rarity.Bizarre: return _cb; break;
    case Rarity.Event: return _ce; break;
}

#define GetRarityWeight(_rarity)

switch(_rarity)
{
    case Rarity.WIP: return 0; break;
    case Rarity.Ordinary: return global.ordinary_rarity_weight; break;
    case Rarity.Tragic: return global.tragic_rarity_weight; break;
    case Rarity.Common: return global.common_rarity_weight; break;
    case Rarity.Uncommon: return global.uncommon_rarity_weight; break;
    case Rarity.Rare: return global.rare_rarity_weight; break;
    case Rarity.Epic: return global.epic_rarity_weight; break;
    case Rarity.Legendary: return global.legendary_rarity_weight; break;
    case Rarity.Mythical: return global.mythical_rarity_weight; break;
    case Rarity.Celestial: return global.celestial_rarity_weight; break;
    case Rarity.Ultimate: return global.ultimate_rarity_weight; break;
    case Rarity.Bizarre: return global.bizarre_rarity_weight; break;
    case Rarity.Event: return 0; break;
}

#define UpdateRarity(_rarity)

rarity.tier = _rarity;
powerMultiplier = GetPowerMultiplier(_rarity);
rarity.name = GetRarityName(_rarity);
rarity.color = GetRarityColor(_rarity);
rarity.probability = (GetRarityWeight(_rarity) / get_total_weight(global.arrow_ability_pool)) * 100;

#define RemoveStand(_owner)

with (MOBJ)
{
    if bool("type" in self)
    {
        if (type == "timestop")
        {
            instance_destroy(self);
        }
    }
}
if (instance_exists(_owner) and instance_exists(_owner.myStand))
{
    RunesRemove(_owner);
    with (_owner.myStand)
    {
        if (barrageData.sound != noone and audio_is_playing(barrageData.sound))
        {
            audio_stop_sound(barrageData.sound);
        }
        state = StandState.Idle;
        for (var i = StandState.SkillAOff; i < StandState.SkillD; i++)
        {
            ResetCD(i);
        }
        ds_map_destroy(extra_serial_data);
        instance_destroy(self);
    }
    _owner.myStand = noone;
}

#define GetStandDestructivePower(_stand)

return (_stand.destructive_power + _stand.mod_destructive_power);

#define GetStandSpeed(_stand)

return (_stand.spd + _stand.mod_spd);

#define GetStandRange(_stand)

return (_stand.range + _stand.mod_range) * GetRunesStandReach(_stand);

#define GetStandStamina(_stand)

return (_stand.stamina + _stand.mod_stamina);

#define GetStandPrecision(_stand)

return (_stand.precision + _stand.mod_precision);

#define GetStandTotalPower(_stand)

return (_stand.destructive_power + _stand.spd + _stand.range + _stand.stamina + _stand.precision) / 5;

#define GetStandExtension(_stand)

return (_stand.stand_reach * GetRunesExtension(_stand));

#define AddCombo

combo++;
comboCounterLerp = 1;
comboResetTimer = 3;
