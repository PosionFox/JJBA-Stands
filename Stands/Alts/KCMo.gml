
global.jjbamDiscKcmo = ItemCreate(
    undefined,
    Localize("standDiscName") + "KCMo",
    Localize("standDiscDescription") + "King Crimson Monochrome",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscKcmoUse),
    5 * 10,
    true
);

#define DiscKcmoUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKcmo);
    exit;
}
GiveKcmo(player);

#define GiveKcmo(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKingCrimsonMono;
    name = "King Crimson Monochrome";
    color = 0x342022;
    colorAlt = c_white;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamKcmo";
    discType = global.jjbamDiscKcmo;
}
return _s;

