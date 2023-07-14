
global.jjbamDiscPd4clt = ItemCreate(
    undefined,
    "DISC:PD4CLT",
    "The label says: Patriot D4C Love Train",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscPd4cltUse),
    5 * 10,
    true
);

#define DiscPd4cltUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscPd4clt);
    exit;
}
GivePd4clt(player);

#define GivePd4clt(_owner) //stand

var _s = GiveD4CLT(_owner);
with (_s)
{
    sprite_index = global.sprPD4CLT;
    name = "Patriot D4C: Love Train";
    color = /*#*/0xff9b63;
    isRare = true;
    powerMultiplier = 7.5;
    auraParticleSprite = global.sprStandParticle4;
    saveKey = "jjbamPd4clt";
    discType = global.jjbamDiscPd4clt;
}
return _s;


