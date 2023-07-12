
global.jjbamDiscNeo = ItemCreate(
    undefined,
    "DISC:NEO",
    "The label says: The World NEO",
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

#define GiveNeo(_owner) //stand

var _s = GiveTheWorldAU(_owner);
with (_s)
{
    sprite_index = global.sprTheWorldNeo;
    name = "The World Neo";
    color = 0xff9b63;
    isRare = true;
    powerMultiplier = 7.5;
    auraParticleSprite = global.sprStandParticle3;
    sprKnife = global.sprNeoKnife;
    saveKey = "jjbamNeo";
    discType = global.jjbamDiscNeo;
}
return _s;
