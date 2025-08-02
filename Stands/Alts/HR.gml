
global.jjbamDiscHr = ItemCreate(
    undefined,
    tr("standDiscName") + "HR",
    tr("standDiscDescription") + "Hierophant Red",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DischrUse),
    5 * 10,
    true
);

#define DischrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscHr);
    exit;
}
GiveHr(player);

#define GiveHr(_owner)

var _s = GiveHierophantGreen(_owner);
with (_s)
{
    name = "Hierophant Red"
    sprite_index = global.sprHierophantRed;
    color = Color.BrightRed;
    colorAlt = Color.DimWhite;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamHr";
    discType = global.jjbamDiscHr;
}
return _s;
