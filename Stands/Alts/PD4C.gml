
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
    if (_c <= 1)
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
    color = 0xff9b63;
    colorAlt = 0x3232ac;
    UpdateRarity(Rarity.Epic);
    auraParticleSprite = global.sprStandParticle3;
    saveKey = "jjbamPd4c";
    discType = global.jjbamDiscPd4c;
    
    evolutions[0] = [global.sprPD4CLT, [global.sprLeftArm, global.sprEye], Rarity.Epic];
    evolutions[1] = [global.sprEvergreen, [global.sprLeftArm, global.sprEye], Rarity.Ascended];
}
return _s;

