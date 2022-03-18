enum StandState {
    Idle,
    SkillAOff,
    SkillBOff,
    SkillCOff,
    SkillDOff,
    SkillA,
    SkillB,
    SkillC,
    SkillD,
    LEN
}
enum StandStat {
    Range,
    AttackDamage,
    AttackRange,
    BaseSpd,
    LEN
}
enum StandSkill {
    ActiveOnly,
    Skill,
    SkillAlt,
    Key,
    Desc,
    Icon,
    IconAlt,
    MaxHold,
    Hold,
    Damage,
    MaxCooldown,
    Cooldown,
    MaxCooldownAlt,
    CooldownAlt,
    MaxExecutionTime,
    ExecutionTime,
    LEN
}

#macro DMG string(_skills[sk, StandSkill.Damage])

#define StandSkillDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;


//draw_text(128, 128, string(objPlayer.dmg)); // debug

draw_text(168, _height - 160, string_lower(name));
draw_text(24, _height - 84, "q");

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
        draw_sprite_ext(global.sprSkillTemplate, 0, xx, yy, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, yy, 2, 2, 0, color, 1);
        if (skills[i, StandSkill.Cooldown] > 0)
        {
            var cyy = (skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown]) * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, yy + 10, string(skills[i, StandSkill.Cooldown]));
        }
        
        draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
    }
    // hold
    if (skills[i, StandSkill.SkillAlt] != AttackHandler)
    {
        draw_sprite_ext(global.sprSkillHoldTemplate, 0, xx, yy + 64, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, yy + 64, 2, 2, 0, color, 1);
        var _hold = (skills[i, StandSkill.Hold] / skills[i, StandSkill.MaxHold]) * 2;
        draw_sprite_ext(global.sprSkillHold, 0, xx, yy + 64, 2, _hold, 0, color, 0.8);
        if (skills[i, StandSkill.CooldownAlt] > 0)
        {
            var cyy = (skills[i, StandSkill.CooldownAlt] / skills[i, StandSkill.MaxCooldownAlt]) * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy + 64, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, yy + 74, string(skills[i, StandSkill.CooldownAlt]));
        }
    }
    //show tooltip
    var gx = device_mouse_x_to_gui(0);
    var gy = device_mouse_y_to_gui(0);
    if (point_in_rectangle(gx, gy, xx - 32, yy - 32, xx + 32, yy + 32))
    {
        var txt = skills[i, StandSkill.Desc];
        draw_set_color(c_dkgray);
        draw_rectangle(gx, (yy - 64) - string_height(txt), gx + string_width(txt), (yy - 64), false);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(gx + 9, ((yy - 64) - string_height(txt)) + 8, txt);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    }
}

#define StandSkillRunCD(s)

for (var i = StandState.LEN - 1; i > 0; i--)
{
    if (s[@ i, StandSkill.Cooldown] > 0)
    {
        s[@ i, StandSkill.Cooldown] -= 1 / room_speed;
    }
    if (s[@ i, StandSkill.CooldownAlt] > 0)
    {
        s[@ i, StandSkill.CooldownAlt] -= 1 / room_speed;
    }
}

#define StandSkillDefaultCDs

StandSkillRunCD(skills);

#define StandSkillManage

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    if (state == StandState.Idle and active = skills[i, StandSkill.ActiveOnly])
    {
        if (keyboard_check(ord(skills[i, StandSkill.Key])))
        {
            if (skills[i, StandSkill.CooldownAlt] <= 0 and skills[i, StandSkill.SkillAlt] != AttackHandler)
            {
                skills[i, StandSkill.Hold] += 1 / room_speed;
                skills[i, StandSkill.Hold] = clamp(skills[i, StandSkill.Hold], 0, skills[i, StandSkill.MaxHold]);
                if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold] and !altAttack)
                {
                    altAttack = true;
                    var _s = audio_play_sound(sndCoin1, 1, false);
                    audio_sound_pitch(_s, 1.5);
                }
            }
        }
        if (keyboard_check_released(ord(skills[i, StandSkill.Key])))
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
        }
    }
}

if (state != StandState.Idle)
{
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

#define StandDefaultSummon

if (keyboard_check_pressed(ord("Q")) and state == StandState.Idle) {
    active = !active;
    if (active)
    {
        if (!audio_is_playing(summonSound) and summonSound != noone)
        {
            audio_play_sound(summonSound, 0, false);
        }
    }
}

#define StandDefaultPos

var xPos = mouse_x > owner.x ? 1 : -1;
xTo = owner.x - (xPos * 16);
yTo = owner.y - 8;

#define StandDefaultStep

depth = -y;

script_execute(summonMethod);

x = lerp(x, xTo, spd);
y = lerp(y, yTo, spd);
image_alpha = lerp(image_alpha, alphaTarget, 0.1);

if (active)
{
    if (state == StandState.Idle)
    {
        image_xscale = mouse_x > owner.x ? 1 : -1;
        alphaTarget = 1;
        script_execute(idlePos);
        y += sin(current_time / 1000);
    }
}
else
{
    alphaTarget = 0;
    xTo = owner.x;
    yTo = owner.y;
}

StandSkillManage();

#define StandDefaultDraw

draw_self();

#define StandSkillInit(_stats)

var _arr;
var _s;

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    _s = i;
    _arr[_s, StandSkill.ActiveOnly] = i > StandState.SkillDOff;
    _arr[_s, StandSkill.Skill] = AttackHandler;
    _arr[_s, StandSkill.SkillAlt] = AttackHandler;
    _arr[_s, StandSkill.Key] = "";
    _arr[_s, StandSkill.Desc] = "";
    _arr[_s, StandSkill.Icon] = global.sprSkillSkip;
    _arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
    _arr[_s, StandSkill.MaxHold] = 0.5;
    _arr[_s, StandSkill.Hold] = 0;
    _arr[_s, StandSkill.Damage] = 0;
    _arr[_s, StandSkill.MaxCooldown] = 1;
    _arr[_s, StandSkill.Cooldown] = 0;
    _arr[_s, StandSkill.MaxCooldownAlt] = 1;
    _arr[_s, StandSkill.CooldownAlt] = 0;
    _arr[_s, StandSkill.MaxExecutionTime] = 5;
    _arr[_s, StandSkill.ExecutionTime] = 0;
}
_arr[StandState.SkillAOff, StandSkill.Key] = "R";
_arr[StandState.SkillBOff, StandSkill.Key] = "F";
_arr[StandState.SkillCOff, StandSkill.Key] = "C";
_arr[StandState.SkillDOff, StandSkill.Key] = "G";
_arr[StandState.SkillA, StandSkill.Key] = _arr[StandState.SkillAOff, StandSkill.Key];
_arr[StandState.SkillB, StandSkill.Key] = _arr[StandState.SkillBOff, StandSkill.Key];
_arr[StandState.SkillC, StandSkill.Key] = _arr[StandState.SkillCOff, StandSkill.Key];
_arr[StandState.SkillD, StandSkill.Key] = _arr[StandState.SkillDOff, StandSkill.Key];

return _arr;

#define StandBuilder(_name, _sprite, _stats, _skills, _color)

RemoveStand();
// init
var _stand = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
with (_stand)
{
    owner = objPlayer;
    isShiny = irandom(1);
    type = "stand";
    saveKey = "jjbamStandless";
    discType = noone;
    name = _name;
    sprite_index = _sprite;
    color = _color;
    attackState = 0;
    attackStateTimer = 0;
    summonSound = global.sndStandSummon;
    // state
    summonMethod = StandDefaultSummon;
    runCDsMethod = StandSkillDefaultCDs;
    active = false;
    state = StandState.Idle;
    alphaTarget = 0;
    idlePos = StandDefaultPos;
    target = noone;
    altAttack = false;
    // position
    xTo = objPlayer.x;
    yTo = objPlayer.y;
    // stats
    stats = array_clone(_stats);
    spd = stats[StandStat.BaseSpd];
    // skills
    skills = array_clone(_skills);
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandDefaultStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(StandDefaultDraw), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);
    objPlayer.myStand = self;
}
return _stand;

#define RemoveStand

with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == "timestop")
        {
            instance_destroy(self);
        }
    }
}
if (instance_exists(objPlayer))
{
    with (objPlayer)
    {
        if (instance_exists(myStand))
        {
            with (myStand)
            {
                state = StandState.Idle;
                for (var i = StandState.SkillAOff; i < StandState.SkillD; i++)
                {
                    ResetCD(i);
                }
            }
            instance_destroy(myStand);
        }
        myStand = noone;
    }
}



