
global.jjbamDiscHe = ItemCreate(
    undefined,
    Localize("standDiscName") + "HE",
    Localize("standDiscDescription") + "Hierophant Eve",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscHeUse),
    5 * 10,
    true
);

#define DiscHeUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscHe);
    exit;
}
GiveHE(player);

#define GiveHE(_owner)

var _s = GiveHierophantGreen(_owner);
with (_s)
{
    name = "Hierophant Eve"
    sprite_index = global.sprHierophantEve;
    color = 0x6357d9;
    UpdateRarity(Rarity.Event);
    saveKey = "jjbamHe";
    discType = global.jjbamDiscHe;
}
return _s;
