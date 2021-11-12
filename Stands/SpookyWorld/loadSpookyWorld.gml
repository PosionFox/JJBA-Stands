
#define GiveSpookyWorld //stand

var _name = "Spooky World";
var _sprite = global.sprSpookyWorld;
var _color = 0x322022;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTw;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndTwSummon;

objPlayer.myStand.saveKey = "jjbamSw";
objPlayer.myStand.discType = global.jjbamDiscSw;
