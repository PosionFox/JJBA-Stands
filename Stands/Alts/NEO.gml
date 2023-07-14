
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

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndNeoTs, 5, false);
    var _t = TimestopCreate(5 + (0.15 * player.level));
    _t.resumeSound = global.sndNeoTsResume;
    FireCD(s);
}
state = StandState.Idle;

#define GiveNeo(_owner) //stand

var _s = GiveTheWorldAU(_owner);
with (_s)
{
    sprite_index = global.sprTheWorldNeo;
    name = "The World Neo";
    color = 0xff9b63;
    tier = {
        name : "epic",
        color : c_purple
    }
    powerMultiplier = 10;
    auraParticleSprite = global.sprStandParticle3;
    sprKnife = global.sprNeoKnife;
    saveKey = "jjbamNeo";
    discType = global.jjbamDiscNeo;
    
    skills[StandState.SkillD, StandSkill.Skill] = NeoTs;
}
return _s;
