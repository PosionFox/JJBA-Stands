
#define ZipperPunch(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(16, _dir);
yTo = owner.y + lengthdir_y(16, _dir);

switch (attackState)
{
    case 0:
        attackStateTimer += 1 / room_speed;
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _p = PunchCreate(x, y, _dir, 5, 1);
        with (_p)
        {
            despawnTime = room_speed * 0.2;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define GiveStickyFingers //stand

var _name = "Sticky Fingers";
var _sprite = global.sprStickyFingers;
var _color = 0xfcdbcb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = ZipperPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
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

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndSfSummon;
