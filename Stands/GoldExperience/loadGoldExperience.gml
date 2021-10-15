
#define GeBarrage(method, skill) //attacks
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _dmg = 2 + (owner.level * 0.03) + owner.dmg;

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.08)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-45, 45);
        var _p = PunchCreate(xx, yy, ddir, _dmg, 0);
        with (_p)
        {
            onHitSound = global.sndGeHit;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StandBarrageStep), true);
        }
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

if (keyboard_check_released(ord(skills[skill, StandSkill.Key])))
{
    if (skills[skill, StandSkill.ExecutionTime] > 0)
    {
        FireCD(skill);
    }
    else
    {
        ResetCD(skill);
    }
    state = StandState.Idle;
}

#define LifePunch(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
var _dmg = 2 + (owner.level * 0.05) + owner.dmg;
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _p = PunchCreate(x, y, _dir, _dmg, 3);
        with (_p)
        {
            destroyOnImpact = true;
            onHitEvent = LifeSoul;
            onHitEventArg = direction;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define SelfHeal(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
var _heal = 1 + floor(owner.level * 0.15);
xTo = owner.x + lengthdir_x(-8, _dir);
yTo = owner.y + lengthdir_y(-8, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        if (instance_exists(owner))
        {
            owner.hp += _heal;
            FireEffect(c_white, c_lime);
            FireCD(skill);
            state = StandState.Idle;
        }
    break;
}
attackStateTimer += 1 / room_speed;

#define LifeSoul(_scr, _dir) //attack properties

var _p = ProjectileCreate(x, y);
with (_p)
{
    target = noone
    if (instance_exists(parEnemy))
    {
        target = instance_nearest(x, y, parEnemy);
        sprite_index = target.sprite_index;
        image_speed = 0;
    }
    damage = 2 + (owner.level * 0.1) + owner.dmg;
    destroyOnImpact = false;
    direction = _dir;
    
    InstanceAssignMethod(self, "step", ScriptWrap(LifeSoulStep), true);
}

#define LifeSoulStep

if (instance_exists(target))
{
    target.behaviourEngage = false;
}

if (image_alpha <= 0)
{
    if (instance_exists(target))
    {
        target.behaviourEngage = true;
    }
    instance_destroy(self);
    exit;
}
image_alpha -= 0.04;

#define GiveGoldExperience //stand

var _name = "Gold Experience";
var _sprite = global.sprGoldExperience;
var _color = 0x36f2fb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = GeBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = LifePunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = SelfHeal;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTwAu;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndTwSummon;
    saveKey = "jjbamGe";
    //discType = global.jjbamDiscTw;
}
