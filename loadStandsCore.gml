enum StandState {
    Idle,
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

if (!active) { exit; }

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

//draw_text(128, 128, string(objPlayer.dmg));
draw_text(168, _height - 160, string_lower(name));
for (var i = StandState.SkillA; i <= StandState.SkillD; i++) {
    var xx = (64 * i);
    var _cc = skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown];
    if (skills[i, StandSkill.IconAlt] != global.sprSkillSkip)
    {
        draw_sprite_ext(global.sprSkillHoldTemplate, 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, (_height - 32) - (_cc * 64), 2, 2, 0, c_white, 1);
    }
    draw_sprite_ext(global.sprSkillTemplate, 0, xx, _height - 96, 2, 2, 0, c_white, 1);
    draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, _height - 96, 2, 2, 0, c_white, 1);
    draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
    if (skills[i, StandSkill.Cooldown] > 0) {
        var cyy = _cc * 2;
        draw_sprite_ext(global.sprSkillCooldown, 0, xx, _height - 96, 2, cyy, 0, c_white, 0.8);
        draw_text(xx + 8, _height - 64, string(skills[i, StandSkill.Cooldown]));
    }
}

#define StandSkillManage

if (active)
{
    for (var i = 1; i < StandState.LEN; i++)
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
                    FireCD(i)
                    state = StandState.Idle;
                }
            }
        }
    }
}

for (var i = 4; i > 0; i--) {
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

if (keyboard_check_pressed(ord("Q"))) {
    active = !active;
    if (active)
    {
        if (!audio_is_playing(summonSound))
        {
            audio_play_sound(summonSound, 0, false);
        }
    }
}

x = lerp(x, xTo, spd);
y = lerp(y, yTo, spd);

if (active)
{
    if (state == StandState.Idle)
    {
        image_xscale = mouse_x > owner.x ? 1 : -1;
        image_alpha = lerp(image_alpha, 1, 0.1);
        StandDefaultPos()
        y += sin(current_time / 1000);
    }
}
else
{
    image_alpha = lerp(image_alpha, 0, 0.2);
    xTo = owner.x;
    yTo = owner.y;
}

StandSkillManage();

#define StandDefaultDraw

draw_self();

#define StandSkillInit(_stats)

var _arr;
var _s;

// tap
_s = StandState.SkillA;
_arr[_s, StandSkill.Skill] = AttackHandler;
_arr[_s, StandSkill.SkillAlt] = AttackHandler;
_arr[_s, StandSkill.Key] = "R";
_arr[_s, StandSkill.Icon] = global.sprSkillSkip;
_arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
_arr[_s, StandSkill.MaxHold] = 0.5;
_arr[_s, StandSkill.Hold] = 0;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillB;
_arr[_s, StandSkill.Skill] = AttackHandler;
_arr[_s, StandSkill.SkillAlt] = AttackHandler;
_arr[_s, StandSkill.Key] = "F";
_arr[_s, StandSkill.Icon] = global.sprSkillSkip;
_arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
_arr[_s, StandSkill.MaxHold] = 0.5;
_arr[_s, StandSkill.Hold] = 0;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillC;
_arr[_s, StandSkill.Skill] = AttackHandler;
_arr[_s, StandSkill.SkillAlt] = AttackHandler;
_arr[_s, StandSkill.Key] = "C";
_arr[_s, StandSkill.Icon] = global.sprSkillSkip;
_arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
_arr[_s, StandSkill.MaxHold] = 0.5;
_arr[_s, StandSkill.Hold] = 0;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillD;
_arr[_s, StandSkill.Skill] = AttackHandler;
_arr[_s, StandSkill.SkillAlt] = AttackHandler;
_arr[_s, StandSkill.Key] = "G";
_arr[_s, StandSkill.Icon] = global.sprSkillSkip;
_arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
_arr[_s, StandSkill.MaxHold] = 0.5;
_arr[_s, StandSkill.Hold] = 0;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

return _arr;

#define StandBuilder(name, sprite, stats, skills, punchSprite)

// init
objPlayer.myStand = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
objPlayer.myStand.type = "stand";
objPlayer.myStand.name = name;
objPlayer.myStand.sprite_index = sprite;
objPlayer.myStand.punchSprite = punchSprite;
objPlayer.myStand.attackState = 0;
objPlayer.myStand.attackStateTimer = 0;
objPlayer.myStand.summonSound = global.sndStandSummon;
// state
objPlayer.myStand.active = false;
objPlayer.myStand.state = StandState.Idle;
objPlayer.myStand.owner = objPlayer;
objPlayer.myStand.target = noone;
objPlayer.myStand.altAttack = false;
// position
objPlayer.myStand.xTo = objPlayer.x;
objPlayer.myStand.yTo = objPlayer.y;
// stats
objPlayer.myStand.stats = array_clone(stats);
objPlayer.myStand.spd = objPlayer.myStand.stats[StandStat.BaseSpd];
// skills
objPlayer.myStand.skills = array_clone(skills);

InstanceAssignMethod(objPlayer.myStand, "step", ScriptWrap(StandDefaultStep), false);
InstanceAssignMethod(objPlayer.myStand, "draw", ScriptWrap(StandDefaultDraw), false);
InstanceAssignMethod(objPlayer.myStand, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);

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
with (objPlayer)
{
    instance_destroy(myStand);
    myStand = noone;
}



