
//wip
global.jjbamDiscCmn = ItemCreate(
    undefined,
    "DISC:CMN",
    "The label says: C-Moon",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscCmnUse),
    5 * 10,
    true
);

#define DiscCmnUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscCmn);
    exit;
}
GiveCMoon(player);

#define GiveCMoon(_owner) //stand

var _name = "C-Moon";
var _sprite = global.sprCMoon;
var _color = /*#*/0x30be6a;

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "C-Moon";
    sprite_index = global.sprCMoon;
    color = /*#*/0x30be6a;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamCmn";
    discType = global.jjbamDiscCmn;
}
