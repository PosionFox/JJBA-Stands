
#define GiveCg(_owner)

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprCG;
    image_speed = 0.5;
    name = "Crimson Grid";
    color = Color.Red;
    colorAlt = Color.Pink;
    UpdateRarity(Rarity.Bizarre);
    saveKey = "jjbamCg";
    auraParticleSprite = global.sprCGParticle;
    summonSound = global.sndCgSummon;
    tpSound = global.sndCgTp;
    teSound = global.sndCgTe;
    //teBassSound = global.sndCgTeBass;
    teEndSound = global.sndCgTeEnd;
    
    skills[StandState.SkillB, StandSkill.VarsAlt].sound = global.sndCgChop;
    skills[StandState.SkillC, StandSkill.Vars] = { tp_sound : global.sndCgTp };
    skills[StandState.SkillD, StandSkill.Vars] = { te_count : 0, bass_sounds : [ global.sndCgTeBass1, global.sndCgTeBass2, global.sndCgTeBass3 ] };
}
return _s;
