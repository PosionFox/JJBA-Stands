
//wip
global.jjbamDiscSptw = ItemCreate(
    undefined,
    "DISC:SPTW",
    "The label says: Star Platinum: The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscSptwUse),
    5 * 10,
    true
);

#define DiscSptwUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscSptw);
    exit;
}
GiveSPTW(player);

#define GiveSPTW(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SpTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Star Platinum: The World";
    sprite_index = global.sprSptw;
    color = /*#*/0xff9b63;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamSptw";
    discType = global.jjbamDiscSptw;
}
