
#define GiveShadowDIO(_owner)

var _s = GiveShadowTheWorld(_owner);
with (_s)
{
    name = "Shadow DIO";
    sprite_index = global.sprShadowDIO;
    image_speed = 0.5;
    color = Color.Gold;
    colorAlt = Color.Yellow;
    UpdateRarity(Rarity.Bizarre);
    summonSound = global.sndStw2Summon;
    saveKey = "jjbamShadowDIO";
    discType = global.jjbamDiscShadow;
    knifeSprite = global.sprKnifeShad;
    auraParticleSprite = global.sprStandParticle2;
    skills[StandState.SkillD, StandSkill.SkillAlt] = noone;
    //skills[StandState.SkillDOff, StandSkill.IconAlt] = global.sprSkillSkip;
    
    //evolutions = [];
    //evolutions[0] = [global.sprTWR, "lv100", Rarity.Mythical];
}
return _s;
