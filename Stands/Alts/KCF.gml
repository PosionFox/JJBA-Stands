
global.jjbamDiscKcf = ItemCreate(
    undefined,
    Localize("standDiscName") + "KCF",
    Localize("standDiscDescription") + "King Crimson Festive",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscKcfUse),
    5 * 10,
    true
);

#define DiscKcfUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKcf);
    exit;
}
GiveKCF(player);

#define GiveKCF(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKCF;
    name = "King Crimson Festive";
    color = 0x6357d9;
    colorAlt = c_lime;
    UpdateRarity(Rarity.Event);
    saveKey = "jjbamKcf";
    discType = global.jjbamDiscKcf;
}
return _s;
