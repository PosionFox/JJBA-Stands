
global.jjbamDiscKcau = ItemCreate(
    undefined,
    Localize("standDiscName") + "KCAU",
    Localize("standDiscDescription") + "King Crimson Alternate Universe",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscKcauUse),
    5 * 10,
    true
);

#define DiscKcauUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKcau);
    exit;
}
GiveKCAU(player);

#define GiveKCAU(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = ScalpelSlash;
_skills[sk, StandSkill.Icon] = global.sprSkillScalpelSlash;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = Localize("scalpelSlashDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = ScalpelThrow;
_skills[sk, StandSkill.Icon] = global.sprSkillScalpelThrow;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("scalpelThrowDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = KcBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("kcBarrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = KcChop;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.SkillAlt] = KcHeavyChop;
_skills[sk, StandSkill.DamageAlt] = 15;
_skills[sk, StandSkill.DamageScaleAlt] = 0.15;
_skills[sk, StandSkill.IconAlt] = global.sprSkillHeavyChop;
_skills[sk, StandSkill.MaxCooldownAlt] = 15;
_skills[sk, StandSkill.Desc] = Localize("chopDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TimeSkip;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = Localize("timeSkipDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimeErase;
_skills[sk, StandSkill.MaxCooldown] = 35;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeErase;
_skills[sk, StandSkill.Desc] = Localize("timeEraseDesc");


var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "King Crimson Alternate Universe";
    sprite_index = global.sprKCAU;
    color = 0x6357d9;
    colorAlt = c_red;
    dmgStack = 0;
    armChopRange = 72;
    armChopShow = false;
    
    idlePos = KcPos;
    summonSound = global.sndKcauSummon;
    discType = global.jjbamDiscKcau;
    teSound = global.sndKcauTeStart;
    teBassSound = global.sndKcTeBass;
    teEndSound = global.sndKcauTeEnd;
    
    saveKey = "jjbamKcau";
}
return _s;
