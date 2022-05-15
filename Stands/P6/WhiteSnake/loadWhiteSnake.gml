
//wip

#define AcidicSpit(m, s)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = other.skills[s, StandSkill.Damage];
    baseSpd = 8;
    direction = _dir;
    canMoveInTs = false;
    //sprite_index = global.sprKnife;
    image_blend = c_lime;
}
FireCD(s);
state = StandState.Idle;

#define Pilot(m, s)

isPilot = !isPilot;
FireCD(s);
state = StandState.Idle;

#define GiveWhiteSnake //stand

var _name = "WhiteSnake";
var _sprite = global.sprWhiteSnake;
var _color = /*#*/0xfcdbcb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5.5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.\ndmg: " + DMG;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = GunShot;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.\ndmg: " + DMG;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AcidicSpit;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.\ndmg: " + DMG;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = Pilot;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndSpSummon;
    saveKey = "jjbamWs";
    discType = global.jjbamDiscWs;
    
    isPilot = false;
}
