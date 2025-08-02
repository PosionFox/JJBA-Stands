
global.jjbamDiscSfr = ItemCreate(
    undefined,
    tr("standDiscName") + "SFR",
    tr("standDiscDescription") + "Sticky Fingers Red",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSfrUse),
    5 * 10,
    true
);

#define DiscSfrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSfr);
    exit;
}
GiveSfr(player);

#define GiveSfr(_owner) //stand

var _s = GiveStickyFingers(_owner);
with (_s)
{
    sprite_index = global.sprSFR;
    name = "Sticky Fingers Red";
    color = Color.BrightRed;
    colorAlt = Color.DimWhite;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamSfr";
    discType = global.jjbamDiscSfr;
}
return _s;

