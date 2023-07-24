
global.jjbamDiscTwroh = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWROH",
    Localize("standDiscDescription") + "The World Retro Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwrohUse),
    5 * 10,
    true
);

#define DiscTwrohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwroh);
    exit;
}
GiveTwroh(player);

#define GiveTwroh(_owner) //stand

var _s = GiveTWOH(_owner);
with (_s)
{
    name = "The World Retro\nOver Heaven";
    sprite_index = global.sprTWROH;
    color = /*#*/0x50e599;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle3;
    saveKey = "jjbamTwroh";
    discType = global.jjbamDiscTwroh;
}
return _s;
