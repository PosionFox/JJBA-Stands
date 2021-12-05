
#define JosephKnife(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = other.skills[skill, StandSkill.Damage];
    baseSpd = 8;
    onHitEvent = StuckKnife;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = global.sprKnife;
}
FireCD(skill);
state = StandState.Idle;

#define StopSign(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        stopSign.x = objPlayer.x;
        stopSign.y = objPlayer.y;
        stopSign.visible = true;
        stopSign.image_angle = _dir;
        stopSign.direction = _dir;
        stopSign.image_xscale = 0;
        attackState++;
    break;
    case 1:
        stopSign.image_xscale = lerp(stopSign.image_xscale, 1, 0.2);
        stopSign.x = objPlayer.x;
        stopSign.y = objPlayer.y;
        stopSign.image_angle = lerp(stopSign.image_angle, stopSign.direction - 125, 0.1);
        if (attackStateTimer >= 0.5)
        {
            var _dmg = other.skills[skill, StandSkill.Damage];
            var _p = PunchCreate(objPlayer.x, objPlayer.y, stopSign.direction, _dmg, 3);
            _p.onHitSound = global.sndStopSign;
            _p.image_alpha = 0;
            _p.mask_index = global.sprHorizontalSlash;
            attackState++;
        }
    break;
    case 2:
        stopSign.x = objPlayer.x;
        stopSign.y = objPlayer.y;
        stopSign.image_angle = lerp(stopSign.image_angle, stopSign.direction + 90, 0.5);
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 3:
        stopSign.image_xscale = lerp(stopSign.image_xscale, 0, 0.3);
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 4:
        stopSign.visible = false;
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define TripleKnifeThrow(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));

repeat (5)
{
    var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
    with (_p)
    {
        x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
        y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
        despawnTime = room_speed * 5;
        damage = other.skills[skill, StandSkill.Damage];
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnife;
    }
}
FireCD(skill);
state = StandState.Idle;

#define TimestopTw(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(9); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define StuckKnife //attack properties

if (instance_exists(parEnemy))
{
    var _near = instance_nearest(x, y, parEnemy);
    LastingDamageCreate(_near, 0.001, 3, true);
}

#define GiveTheWorld //stand

var _name = "The World";
var _sprite = global.sprTheWorld;
var _color = 0x36f2fb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 6;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 7 + (objPlayer.level * 0.15) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = StwDivineBlood;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTw;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndTwSummon;
    saveKey = "jjbamTw";
    discType = global.jjbamDiscTw;
    
    stopSign = ModObjectSpawn(x, y, depth);
    with (stopSign)
    {
        sprite_index = global.sprStopSign;
        visible = false;
    }
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(TheWorldDestroy), true);
}

#define TheWorldDestroy

if (instance_exists(stopSign))
{
    instance_destroy(stopSign);
}
