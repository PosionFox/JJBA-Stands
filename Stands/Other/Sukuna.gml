
global.jjbamDiscSukuna = ItemCreate(
    undefined,
    tr("standDiscName") + "SUKUNA",
    tr("standDiscDescription") + "Ryomen Sukuna",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSukunaUse),
    5 * 10,
    true
);

#define DiscSukunaUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSukuna);
    exit;
}
GiveSukuna(player);

#define Dismantle(m, s)

#define Dismantle2(m, s)

#define GiveSukuna(_owner) //stand

var _skills = StandSkillInit();
// off
var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = StwUry;
_skills[sk, StandSkill.Damage] = 10;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillUry;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("uryDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StwSRSE;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillSRSE;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("srseDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = StwDivineBlood;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = tr("divineBloodDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = StwCharisma;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillCharisma;
_skills[sk, StandSkill.MaxCooldown] = 18;
_skills[sk, StandSkill.Desc] = tr("charismaDesc");
// on
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StwXXI;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.03;
_skills[sk, StandSkill.Icon] = global.sprSkillXXI;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = tr("xxiDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StwPunishment;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillPunishment;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = tr("punishmentDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StwThrowingKnifes;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillStwKnifes;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = tr("throwingKnifesDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = StwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopStw;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.SkillAlt] = StwTheWorld;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStwTw;
_skills[sk, StandSkill.MaxHold] = 2;
_skills[sk, StandSkill.Desc] = tr("stwTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Ryomen Sukuna";
    playSummonSound = false;
    idlePos = StwPos;
    discType = global.jjbamDiscSukuna;
    saveKey = "jjbamSukuna";
}
return _s;
