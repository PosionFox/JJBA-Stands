
global.jjbamDiscTwruoh = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWRuOH",
    Localize("standDiscDescription") + "The World Runic Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwruohUse),
    5 * 10,
    true
);

#define DiscTwruohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwruoh);
    exit;
}
GiveTwruoh(player);

#define GiveTwruoh(_owner) //stand

var _s = GiveTWOH(_owner);
with (_s)
{
    name = "The World Runic\nOver Heaven";
    sprite_index = global.sprTWRuOH;
    color = 0x36f2fb;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle3;
    saveKey = "jjbamTwruoh";
    discType = global.jjbamDiscTwruoh;
}
return _s;
