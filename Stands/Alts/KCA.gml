
global.jjbamDiscKca = ItemCreate(
    undefined,
    tr("standDiscName") + "KCA",
    tr("standDiscDescription") + "King Crimson Aqua",
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
    color = Color.Blue;
    colorAlt = Color.Aqua;
    UpdateRarity(Rarity.Rare);
    saveKey = "jjbamKca";
    discType = global.jjbamDiscKca;
}
return _s;

