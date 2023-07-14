
global.jjbamDiscEg = ItemCreate(
    undefined,
    "DISC:Eg",
    "The label says: Evergreen",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscEgUse),
    5 * 10,
    true
);

#define DiscEgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscEg);
    exit;
}
GiveEg(player);

#define GiveEg(_owner) //stand

var _s = GiveD4CLT(_owner);
with (_s)
{
    sprite_index = global.sprEvergreen;
    name = "Evergreen";
    color = /*#*/0x50e599;
    isRare = true;
    powerMultiplier = 20;
    auraParticleSprite = global.sprStandParticle6;
    saveKey = "jjbamEg";
    discType = global.jjbamDiscEg;
}
return _s;
