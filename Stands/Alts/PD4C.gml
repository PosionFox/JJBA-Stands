
global.jjbamDiscPd4c = ItemCreate(
    undefined,
    Localize("standDiscName") + "PD4C",
    Localize("standDiscDescription") + "Patriot D4C",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscPd4cUse),
    5 * 10,
    true
);

#define DiscPd4cUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscPd4c);
    exit;
}
GivePd4c(player);

#define PD4CEvolveIfCan

if (STAND.hasArm and STAND.hasHeart and STAND.hasEye)
{
    var _c = irandom(100);
    if (_c <= 2)
    {
        GiveEg(player);
    }
    else
    {
        GivePd4clt(player);
    }
}

#define GivePd4c(_owner) //stand

var _s = GiveD4C(_owner);
with (_s)
{
    sprite_index = global.sprPD4C;
    name = "Patriot D4C";
    color = /*#*/0xff9b63;
    tier = {
        name : "epic",
        color : c_purple
    }
    powerMultiplier = 10;
    auraParticleSprite = global.sprStandParticle3;
    saveKey = "jjbamPd4c";
    discType = global.jjbamDiscPd4c;
}
return _s;

