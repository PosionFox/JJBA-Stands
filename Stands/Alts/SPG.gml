
global.jjbamDiscSpg = ItemCreate(
    undefined,
    Localize("standDiscName") + "SPG",
    Localize("standDiscDescription") + "Star Platinum Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSpgUse),
    5 * 10,
    true
);

#define DiscSpgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpg);
    exit;
}
GiveSpg(player);

#define GiveSpg(_owner)

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum Gray";
    sprite_index = global.sprSPG;
    color = /*#*/0x424242;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamSpg";
    discType = global.jjbamDiscSpg;
}
return _s;
