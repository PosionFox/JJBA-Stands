
global.jjbamDiscShadow = ItemCreate(
    undefined,
    Localize("standDiscName") + "SHADOW",
    Localize("standDiscDescription") + "Shadow",
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

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscShadow);
    exit;
}
GiveShadow(player);

#define ShadowEvolve(m, s)

if (xp >= maxXp)
{
    audio_play_sound(global.sndStwEvolve, 5, false);
    var _o = ModObjectSpawn(x, y, 0);
    with (_o)
    {
        timer = 1;
        
        InstanceAssignMethod(self, "step", ScriptWrap(ShadowEvolveStep), false);
    }
}
else
{
    ResetCD(s);
    state = StandState.Idle;
}

#define ShadowEvolveStep

if (instance_exists(STAND))
{
    RemoveStand(player);
}
FireEffect(c_white, /*#*/0x66a0d9);
timer -= DT;
if (timer <= 0)
{
    GiveTwr(player);
    instance_destroy(self);
}

#define GiveShadow(_owner) //stand

var _s = GiveShadowTheWorld(_owner);
with (_s)
{
    name = "Shadow";
    sprite_index = global.sprShadow;
    color = 0x36f2fb;
    UpdateRarity(Rarity.Mythical);
    summonSound = global.sndStw2Summon;
    saveKey = "jjbamShadow";
    discType = global.jjbamDiscShadow;
    knifeSprite = global.sprKnifeShad;
    auraParticleSprite = global.sprStandParticle2;
    skills[StandState.SkillD, StandSkill.SkillAlt] = ShadowEvolve;
    //skills[StandState.SkillDOff, StandSkill.IconAlt] = global.sprSkillSkip;
}
return _s;
