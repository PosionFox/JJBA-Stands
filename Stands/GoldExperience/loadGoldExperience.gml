
#define GeBarrage(method, skill) //attacks
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _dmg = 0.5 + (owner.level * 0.06) + owner.dmg;

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
var _dmg = 2 + (owner.level * 0.1) + owner.dmg;
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
            onHitSound = global.sndGePunch;
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
image_xscale = sign(dcos(_dir));

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 1:
        if (instance_exists(owner))
        {
            var _s = audio_play_sound(global.sndGeLife, 0, false);
            audio_sound_pitch(_s, random_range(0.8, 1.2));
            var _e = ShrinkingCircleEffect(objPlayer.x, objPlayer.y);
            _e.color = c_lime;
            _e.radius = 8;
            owner.hp += _heal;
            FireEffect(c_white, c_lime);
            FireCD(skill);
            state = StandState.Idle;
        }
    break;
}
attackStateTimer += 1 / room_speed;

#define LifeFormScorpion(method, skill)
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(16, _dir)
yTo = owner.y + lengthdir_y(16, _dir)
alphaTarget = 1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _s = audio_play_sound(global.sndGeLife, 0, false);
        audio_sound_pitch(_s, random_range(0.8, 1.2));
        var _e = ShrinkingCircleEffect(x, y);
        _e.color = c_lime;
        _e.radius = 8;
        ScorpionCreate(x, y);
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define LifeFormPlant(method, skill)
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
//var _dmg = 2 + (owner.level * 0.03) + owner.dmg;
var xx = owner.x + lengthdir_x(16, _dir);
var yy = owner.y + lengthdir_y(16, _dir);
var xs = (floor(xx / 16) * 16) + 8;
var ys = (floor(yy / 16) * 16) + 8;
alphaTarget = 1;
var _nat = collision_circle(xs, ys, 2, parNatural, false, true);
var _herb = collision_circle(xs, ys, 2, parHerb, false, true);
if (_nat or _herb or WaterCollision(xs, ys))
{
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}

xTo = xs;
yTo = ys;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _pool = 
        [
            Spawn.Tree,
            Spawn.Bush,
            Spawn.Cotton,
            Spawn.Flower,
            Spawn.Beet,
            Spawn.Wheat
        ]
        var _pick = irandom(array_length(_pool) - 1);
        var _s = audio_play_sound(global.sndGeLife, 0, false);
        audio_sound_pitch(_s, random_range(0.8, 1.2));
        var _grid = ResourceSnapshot();
        var _res = ResourceSpawn(_grid, _pool[_pick]);
        _res.x = xs;
        _res.y = ys;
        ds_grid_destroy(_grid);
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define LifeFormFrog(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);
alphaTarget = 1;
image_xscale = sign(dcos(_dir + 180));

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _s = audio_play_sound(global.sndGeLife, 0, false);
        audio_sound_pitch(_s, random_range(0.8, 1.2));
        var _e = ShrinkingCircleEffect(objPlayer.x, objPlayer.y);
        _e.color = c_lime;
        _e.radius = 8;
        FrogCreate(objPlayer.x, objPlayer.y);
        FireCD(skill);
        state = StandState.Idle;
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
    damage = 2 + (objPlayer.level * 0.1) + objPlayer.dmg;
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
sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = LifeFormPlant;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormPlant;
_skills[sk, StandSkill.MaxCooldown] = 15;

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = LifeFormScorpion;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormScorpion;
_skills[sk, StandSkill.MaxCooldown] = 20;

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = LifeFormFrog;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormFrog;
_skills[sk, StandSkill.MaxCooldown] = 20;

sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = GeBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 7;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = LifePunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = SelfHeal;
_skills[sk, StandSkill.Icon] = global.sprSkillSelfHeal;
_skills[sk, StandSkill.MaxCooldown] = 15;

sk = StandState.SkillD;

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndGeSummon;
    saveKey = "jjbamGe";
    discType = global.jjbamDiscGe;
}
