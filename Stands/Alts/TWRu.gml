
global.jjbamDiscTwru = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWRu",
    Localize("standDiscDescription") + "The World Runic",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwruUse),
    5 * 10,
    true
);

#define DiscTwruUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwru);
    exit;
}
GiveTwru(player);

#define GiveTwru(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World Runic";
    sprite_index = global.sprTWRu;
    color = /*#*/0x36f2fb;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle6;
    saveKey = "jjbamTwru";
    discType = global.jjbamDiscTwru;
}
return _s;
