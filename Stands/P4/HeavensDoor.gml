
#define GiveHeavensDoor(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
// _skills[sk, StandSkill.Skill] = JosephKnife;
// _skills[sk, StandSkill.Damage] = 3;
// _skills[sk, StandSkill.DamageScale] = 0.1;
// _skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
// _skills[sk, StandSkill.MaxCooldown] = 6;
// _skills[sk, StandSkill.Desc] = tr("josephKnifeDesc");

// sk = StandState.SkillBOff;
// _skills[sk, StandSkill.Skill] = StopSign;
// _skills[sk, StandSkill.Damage] = 30;
// _skills[sk, StandSkill.DamageScale] = 0.15;
// _skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
// _skills[sk, StandSkill.MaxCooldown] = 10;
// _skills[sk, StandSkill.Desc] = tr("stopSignDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TwBloodDrain;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = tr("bloodDrainDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TimeStopTeleport;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = tr("tsTpDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = tr("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 25;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("strongPunchDesc");

// sk = StandState.SkillC;
// _skills[sk, StandSkill.Skill] = TwKnifeWall;
// _skills[sk, StandSkill.Damage] = 2;
// _skills[sk, StandSkill.DamageScale] = 0.02;
// _skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
// _skills[sk, StandSkill.MaxCooldown] = 5;
// _skills[sk, StandSkill.Desc] = tr("knifeWallDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = tr("twTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Heaven's Door";
    sprite_index = global.sprHeavensDoor;
    color = 0xffffff;
    summonSound = global.sndTwSummon;
    saveKey = "jjbamHd";
    UpdateRarity(Rarity.WIP);
}
return _s;

