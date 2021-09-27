
#define ComboDash(method, skill) //attacks
var _dmg = (skills[skill, StandSkill.Damage] * 0.05) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        owner.h += lengthdir_x(4, _dir);
        owner.v += lengthdir_y(4, _dir);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchCreate(x, y, _dir, _dmg, 0);
        with (_p)
        {
            onHitEvent = KnifeCoffin;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define KnifeCoffin(_x, _y)
var _dmg = (owner.myStand.stats[StandStat.AttackDamage] * 0.02) * owner.level;
//var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _target = owner;
if (instance_exists(parEnemy))
{
    _target = instance_nearest(x, y, parEnemy);
}

var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var _k = 8;
for (var i = 0; i <= _k; i++)
{
    var _xx = _target.x + lengthdir_x(64, i * (360 / _k));
    var _yy = _target.y + lengthdir_y(64, i * (360 / _k));
    var _p = ProjectileCreate(_xx, _yy);
    with (_p)
    {
        var _dir = (i * (360 / _k)) - 180;
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnifeStw;
    }
}

#define BackDashKnife(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.15) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

owner.h -= lengthdir_x(4, _dir);
owner.v -= lengthdir_y(4, _dir);
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    despawnTime = room_speed * 5;
    damage = _dmg;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = global.sprKnifeStw;
}
skills[skill, StandSkill.MaxCooldown] = 1;
skills[skill, StandSkill.Icon] = global.sprSkillRadialKnife;
FireCD(skill);
skills[skill, StandSkill.Skill] = RadialKnife;
state = StandState.Idle;

#define RadialKnife(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var _k = 8;
for (var i = 0; i <= _k; i++)
{
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir + (i * (360 / _k));
        canMoveInTs = false;
        sprite_index = global.sprKnifeStw;
    }
}
skills[skill, StandSkill.MaxCooldown] = 3;
skills[skill, StandSkill.Icon] = global.sprSkillBackDashKnife;
FireCD(skill);
skills[skill, StandSkill.Skill] = BackDashKnife;
state = StandState.Idle;

#define TripleCombo(method, skill)
var _dmg = 5 * (owner.level * 0.2);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        owner.h += lengthdir_x(2, _dir);
        owner.v += lengthdir_y(2, _dir);
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = _dmg;
            direction = _dir;
            canMoveInTs = false;
            sprite_index = global.sprKnifeStw;
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        owner.h += lengthdir_x(1, _dir);
        owner.v += lengthdir_y(1, _dir);
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchCreate(x, y, _dir + random_range(-8, 8), _dmg, 0);
        PunchCreate(x, y, _dir + random_range(-8, 8), _dmg, 0);
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 4:
        owner.h -= lengthdir_x(3, _dir);
        owner.v -= lengthdir_y(3, _dir);
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = _dmg;
            direction = _dir;
            canMoveInTs = false;
            sprite_index = global.sprKnifeStw;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define TimestopSTW(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndStwTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(2); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define GiveShadowTheWorld //stand

var _name = "Shadow The World";
var _sprite = global.sprShadowTheWorld;
var _punchSprite = global.sprStwPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = ComboDash;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeCoffin;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BackDashKnife;
_skills[sk, StandSkill.Icon] = global.sprSkillBackDashKnife;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleCombo;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleCombo;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSTW;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopStw;
_skills[sk, StandSkill.MaxCooldown] = 15;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("jjbamStw");
