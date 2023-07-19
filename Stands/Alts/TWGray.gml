
global.jjbamDiscTwg = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWG",
    Localize("standDiscDescription") + "The World Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscTwgUse),
    5 * 10,
    true
);

#define DiscTwgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwg);
    exit;
}
GiveTwg(player);

#define GiveTwg(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World Gray";
    sprite_index = global.sprTWG;
    color = /*#*/0xa9a9a9;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamTwg";
    discType = global.jjbamDiscTwg;
}
return _s;