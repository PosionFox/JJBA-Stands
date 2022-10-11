
global.jjbamDiscShadow = ItemCreate(
    undefined,
    "DISC:SHADOW",
    "The label says: Shadow",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscShadowUse),
    5 * 10,
    true
);

#define DiscShadowUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscShadow);
    exit;
}
GiveShadowTheWorld(player);

#define GiveShadow(_owner) //stand

var _s = GiveShadowTheWorld(_owner);
with (_s)
{
    name = "Shadow";
    image_blend = 0x36f2fb;
    color = 0x36f2fb;
    isRare = true;
    summonSound = global.sndStw2Summon;
    saveKey = "jjbamShadow";
    discType = global.jjbamDiscShadow;
    knifeSprite = global.sprKnifeShad;
    
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
    //skills[StandState.SkillDOff, StandSkill.IconAlt] = global.sprSkillSkip;
}
return _s;
