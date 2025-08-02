
global.jjbamDiscTwru = ItemCreate(
    undefined,
    tr("standDiscName") + "TWRu",
    tr("standDiscDescription") + "The World Runic",
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
    color = Color.Gold;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle6;
    saveKey = "jjbamTwru";
    discType = global.jjbamDiscTwru;
    
    evolutions[0] = [global.sprTWRuOH, global.sprDiosDiary, Rarity.Mythical];
}
return _s;
