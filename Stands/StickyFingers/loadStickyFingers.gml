
#define GiveStickyFingers //stand

var _name = "Sticky Fingers";
var _sprite = global.sprKillerQueen;
var _punchSprite = global.sprKqPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrageKq;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = PlaceBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillFirstBomb;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CoinBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillCoinBomb;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = ShaSummon;
_skills[sk, StandSkill.Icon] = global.sprSkillSHA;
_skills[sk, StandSkill.MaxCooldown] = 40;
_skills[sk, StandSkill.MaxExecutionTime] = 20;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

