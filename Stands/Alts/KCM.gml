
global.jjbamDiscKcm = ItemCreate(
    undefined,
    "DISC:KCM",
    "The label says: King Crimson Manga",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscKcmUse),
    5 * 10,
    true
);

#define DiscKcmUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKcm);
    exit;
}
GiveKcm(player);

#define GiveKcm(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKingCrimsonManga;
    name = "King Crimson Manga";
    color = 0xba7bd7;
    isRare = true;
    saveKey = "jjbamKcm";
    discType = global.jjbamDiscKcm;
}
return _s;
