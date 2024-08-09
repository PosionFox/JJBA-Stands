
global.jjbamDiscNeo = ItemCreate(
    undefined,
    Localize("standDiscName") + "NEO",
    Localize("standDiscDescription") + "The World NEO",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscNeoUse),
    5 * 10,
    true
);

#define DiscNeoUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscNeo);
    exit;
}
GiveNeo(player);

#define NeoTs(m, s)

var _length = 5 + (0.15 * player.level);
if (player.hp <= player.maxHp / 2)
{
    jj_play_audio(global.sndTwAuTsPanic, 5, false);
    _length = 8 + (0.2 * player.level);
}
else
{
    jj_play_audio(global.sndNeoTs, 5, false);
}
var _t = TimestopCreate(_length);
_t.resumeSound = global.sndNeoTsResume;
EndAtk(s);

#define GiveNeo(_owner) //stand

var _s = GiveTheWorldAU(_owner);
with (_s)
{
    sprite_index = global.sprTheWorldNeo;
    name = "The World Neo\nAlternate Universe";
    color = 0xff9b63;
    UpdateRarity(Rarity.Epic);
    auraParticleSprite = global.sprStandParticle3;
    sprKnife = global.sprNeoKnife;
    saveKey = "jjbamNeo";
    discType = global.jjbamDiscNeo;
    
    skills[StandState.SkillD, StandSkill.Skill] = NeoTs;
}
return _s;
