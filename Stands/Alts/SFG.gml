
global.jjbamDiscSfg = ItemCreate(
    undefined,
    Localize("standDiscName") + "SFG",
    Localize("standDiscDescription") + "Sticky Fingers Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSfgUse),
    5 * 10,
    true
);

#define DiscSfgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSfg);
    exit;
}
GiveSfg(player);

#define GiveSfg(_owner) //stand

var _s = GiveStickyFingers(_owner);
with (_s)
{
    sprite_index = global.sprSFG;
    name = "Sticky Fingers Gray";
    color = /*#*/0x969696;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamSfg";
    discType = global.jjbamDiscSfg;
}
return _s;
