
global.jjbamDiscKcg = ItemCreate(
    undefined,
    Localize("standDiscName") + "KCG",
    Localize("standDiscDescription") + "King Crimson Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscKcgUse),
    5 * 10,
    true
);

#define DiscKcgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKcg);
    exit;
}
GiveKcg(player);

#define GiveKcg(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKCG;
    name = "King Crimson Gray";
    color = /*#*/0x737373;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamKcg";
    discType = global.jjbamDiscKcg;
}
return _s;

