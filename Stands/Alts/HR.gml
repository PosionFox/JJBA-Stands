
global.jjbamDiscHr = ItemCreate(
    undefined,
    Localize("standDiscName") + "HR",
    Localize("standDiscDescription") + "Hierophant Black",
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
    color = /*#*/0x6357d9;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamHr";
    discType = global.jjbamDiscHr;
}
return _s;
