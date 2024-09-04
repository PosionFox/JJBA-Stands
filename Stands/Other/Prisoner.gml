
#define GivePrisoner(_owner)

var _skills = StandSkillInit();

var sk;

sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 10;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;


var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Prisoner"
    color = 0xffffff;
    sprite_index = global.sprCoin;
    UpdateRarity(Rarity.Common);
    saveKey = "jjbamPs";
}
return _s;
