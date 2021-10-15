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
    Skill,
    SkillAlt,
    Key,
    Icon,
    IconAlt,
    MaxHold,
    Hold,
    Damage,
    MaxCooldown,
    Cooldown,
    MaxExecutionTime,
    ExecutionTime,
    LEN
}

#define StandSkillDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

draw_text(168, _height - 160, string_lower(name));
//draw_text(128, 128, string(objPlayer.dmg));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (active)
{
    for (var i = StandState.SkillA; i <= StandState.SkillD; i++) {
        var xx = (64 * i) - 256;
        var _cc = skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown];
        if (skills[i, StandSkill.IconAlt] != global.sprSkillSkip)
        {
            draw_sprite_ext(global.sprSkillHoldTemplate, 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, c_white, 1);
            draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, color, 1);
        }
        draw_sprite_ext(global.sprSkillTemplate, 0, xx, _height - 96, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, _height - 96, 2, 2, 0, color, 1);
        draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
        if (skills[i, StandSkill.Cooldown] > 0) {
            var cyy = _cc * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, _height - 96, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, _height - 64, string(skills[i, StandSkill.Cooldown]));
        }
    }
}
else
{
    for (var i = StandState.SkillAOff; i <= StandState.SkillDOff; i++) {
        var xx = (64 * i);
        var _cc = skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown];
        if (skills[i, StandSkill.IconAlt] != global.sprSkillSkip)
        {
            draw_sprite_ext(global.sprSkillHoldTemplate, 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, c_white, 1);
            draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, color, 1);
        }
        var _c = color;
        if (skills[i, StandSkill.Icon] == global.sprSkillSkip) { _c = c_white; }
        draw_sprite_ext(global.sprSkillTemplate, 0, xx, _height - 96, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, _height - 96, 2, 2, 0, _c, 1);
        draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
        if (skills[i, StandSkill.Cooldown] > 0) {
            var cyy = _cc * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, _height - 96, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, _height - 64, string(skills[i, StandSkill.Cooldown]));
        }
    }
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

#define StandSkillManage

if (!active)
{
    for (var i = 1; i < StandState.SkillA; i++)
    {
        if (skills[i, StandSkill.Cooldown] <= 0 and state == StandState.Idle)
        {
            if (keyboard_check(ord(skills[i, StandSkill.Key])))
            {
                skills[i, StandSkill.Hold] += 1 / room_speed;
                if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold])
                {
                    altAttack = true;
                    skills[i, StandSkill.Hold] = 0;
                    state = i;
                }
            }
            if (keyboard_check_released(ord(skills[i, StandSkill.Key])))
            {
                if (skills[i, StandSkill.Hold] < skills[i, StandSkill.MaxHold])
                {
                    skills[i, StandSkill.Hold] = 0;
                    state = i;
                }
            }
        }
    }
}
else
{
    for (var i = StandState.SkillA; i < StandState.LEN; i++)
    {
        if (skills[i, StandSkill.Cooldown] <= 0 and state == StandState.Idle)
        {
            if (keyboard_check(ord(skills[i, StandSkill.Key])))
            {
                skills[i, StandSkill.Hold] += 1 / room_speed;
                if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold])
                {
                    altAttack = true;
                    skills[i, StandSkill.Hold] = 0;
                    state = i;
                }
            }
            if (keyboard_check_released(ord(skills[i, StandSkill.Key])))
            {
                if (skills[i, StandSkill.Hold] < skills[i, StandSkill.MaxHold])
                {
                    skills[i, StandSkill.Hold] = 0;
                    state = i;
                }
            }
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

for (var i = StandState.LEN - 1; i > 0; i--) {
    if (skills[i, StandSkill.Cooldown] > 0) {
        skills[i, StandSkill.Cooldown] -= 1 / room_speed;
    }
}

#define StandDefaultPos

var xPos = mouse_x > owner.x ? 1 : -1;
xTo = owner.x - (xPos * 16);
yTo = owner.y - 8;

#define StandDefaultStep

depth = -y;

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
    _arr[_s, StandSkill.Skill] = AttackHandler;
    _arr[_s, StandSkill.SkillAlt] = AttackHandler;
    _arr[_s, StandSkill.Key] = "";
    _arr[_s, StandSkill.Icon] = global.sprSkillSkip;
    _arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
    _arr[_s, StandSkill.MaxHold] = 0.5;
    _arr[_s, StandSkill.Hold] = 0;
    _arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
    _arr[_s, StandSkill.MaxCooldown] = 1;
    _arr[_s, StandSkill.Cooldown] = 0;
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
    type = "stand";
    saveKey = "jjbamStandless";
    name = _name;
    sprite_index = _sprite;
    color = _color;
    attackState = 0;
    attackStateTimer = 0;
    summonSound = global.sndStandSummon;
    // state
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



