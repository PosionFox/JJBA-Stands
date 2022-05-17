
#define JosephKnife(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = GetDmg(skill);
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
            var _dmg = GetDmg(skill);
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
attackStateTimer += DT;

#define TwBloodDrain(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        //audio_play_sound(global.sndStwNazimuzo, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 0);
        with (_p)
        {
            var _arg = noone;
            if (instance_exists(parEnemy))
            {
                _arg = instance_nearest(x, y, parEnemy);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TripleKnifeThrow(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));

repeat (5)
{
    var _p = ProjectileCreate(player.x, player.y);
    with (_p)
    {
        x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
        y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
        damage = GetDmg(skill);
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnife;
    }
}
EndAtk(skill);

#define TwTimestop(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwTs, 5, false);
    TimestopCreate(9 + (0.05 * player.level));
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
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = "joseph knife:\nsend out a knife that causes bleed on impact.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 7;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = "stop sign:\nstrike with a stop sign.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TwBloodDrain;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "blood drain:\ndrain the target's health and heals the user.";

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5.5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "knife wall:\nsends out a burst of knifes.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = "time, stop!:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

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
return _s;

#define TheWorldDestroy

if (instance_exists(stopSign))
{
    instance_destroy(stopSign);
}
