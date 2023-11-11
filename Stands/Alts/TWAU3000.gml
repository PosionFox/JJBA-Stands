
global.jjbamDiscTwau3000 = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWAU3000",
    Localize("standDiscDescription") + "The World 3000 Alternate Universe",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwau3000Use),
    5 * 10,
    true
);

#define DiscTwau3000Use

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwau3000);
    exit;
}
GiveTwau3000(player);

#define GiveTwau3000(_owner) //stand

var _s = GiveTheWorldAU(_owner);
with (_s)
{
    sprite_index = global.sprTWAU3000;
    name = "The World 3000\nAlternate Universe";
    color = /*#*/0x3c2845;
    UpdateRarity(Rarity.Legendary);
    auraParticleSprite = global.sprStandParticle4;
    saveKey = "jjbamTwau3000";
    discType = global.jjbamDiscTwau3000;
}
return _s;
