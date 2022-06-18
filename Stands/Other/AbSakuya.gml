

#define GiveSakuya //stand

var _name = "Sakuya Izayoi";
var _sprite = global.sprKnife;
var _color = /*#*/0x0000FF;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = KnifeBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.3;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 0.2;
_skills[sk, StandSkill.Desc] = @"knifes:
tosses a few knifes.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = MeetingCall;
_skills[sk, StandSkill.Icon] = global.sprSkillMeetingCall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.5;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = @"meeting call:
presses a button that damages enemies.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = Kill;
_skills[sk, StandSkill.Icon] = global.sprSkillKill;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 10;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = @"kill:
teleports to a nearby enemy and heavily damages them.";

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndImposterSummon;
    saveKey = "jjbamSus";
    discType = global.jjbamDiscSus;
    isRare = true;
    rot = 0;
    
    InstanceAssignMethod(self, "draw", ScriptWrap(ImposterDraw), false);
}


