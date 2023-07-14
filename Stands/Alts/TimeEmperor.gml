
global.jjbamDiscTe = ItemCreate(
    undefined,
    Localize("standDiscName") + "TE",
    Localize("standDiscDescription") + "Time Emperor",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTeUse),
    5 * 10,
    true
);

#define DiscTeUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTe);
    exit;
}
GiveTe(player);

#define GiveTe(_owner)

var _s = GiveSPTW(_owner);
with (_s)
{
    name = "Time Emperor"
    sprite_index = global.sprTimeEmperor;
    color = /*#*/0xe16e5b;
    isRare = true;
    powerMultiplier = 10;
    auraParticleSprite = global.sprStandParticle6;
    auraParticleRotation = 4;
    saveKey = "jjbamTe";
    discType = global.jjbamDiscTe;
}
return _s;
