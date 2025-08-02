
#define GiveP03(_owner)

var _s = GiveStickyFingers(_owner);
with (_s)
{
    sprite_index = global.sprP03;
    name = "P03";
    color = Color.Aqua;
    colorAlt = Color.Teal;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle8;
    saveKey = "jjsP03";
    
    skills[StandState.SkillD, StandSkill.Vars] = { portalSkin : global.sprP03Portal };
}
return _s;
