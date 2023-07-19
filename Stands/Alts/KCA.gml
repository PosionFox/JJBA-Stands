
global.jjbamDiscKca = ItemCreate(
    undefined,
    Localize("standDiscName") + "KCA",
    Localize("standDiscDescription") + "King Crimson Aqua",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscKcaUse),
    5 * 10,
    true
);

#define DiscKcaUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKca);
    exit;
}
GiveKca(player);

#define GiveKca(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKingCrimsonAqua;
    name = "King Crimson Aqua";
    color = /*#*/0xff9b63;
    UpdateRarity(Rarity.Rare);
    saveKey = "jjbamKca";
    discType = global.jjbamDiscKca;
}
return _s;

