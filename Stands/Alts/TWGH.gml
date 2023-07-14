
global.jjbamDiscTwgh = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWGH",
    Localize("standDiscDescription") + "The World Greatest High",
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
    name = "The World Greatest High";
    sprite_index = global.sprTWGH;
    color = /*#*/0x743f3f;
    isRare = true;
    powerMultiplier = 5;
    saveKey = "jjbamTwgh";
    discType = global.jjbamDiscTwgh;
}
return _s;
