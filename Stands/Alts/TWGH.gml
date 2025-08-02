
global.jjbamDiscTwgh = ItemCreate(
    undefined,
    tr("standDiscName") + "TWGH",
    tr("standDiscDescription") + "The World Greatest High",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwrUse),
    5 * 10,
    true
);

#define DiscTwghUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwgh);
    exit;
}
GiveTwgh(player);

#define GiveTwgh(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World\nGreatest High";
    sprite_index = global.sprTWGH;
    color = Color.FaintPurple;
    colorAlt = Color.BrightRed;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamTwgh";
    discType = global.jjbamDiscTwgh;
    
    evolutions = [];
}
return _s;
