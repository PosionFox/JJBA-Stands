
global.jjbamDiscSnwg = ItemCreate(
    undefined,
    Localize("standDiscName") + "SnWG",
    Localize("standDiscDescription") + "Soft and Wet Golden",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSnwgUse),
    5 * 10,
    true
);

#define DiscSnwgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSnwg);
    exit;
}
GiveSnwg(player);

#define GiveSnwg(_owner)

var _s = GiveSoftAndWet(_owner);
with (_s)
{
    name = "Soft and Wet Golden"
    sprite_index = global.sprSoftAndWetGolden;
    color = 0x36f2fb;
    UpdateRarity(Rarity.Legendary);
    auraParticleSprite = global.sprStandParticle5;
    saveKey = "jjbamSnwg";
    discType = global.jjbamDiscSnwg;
}
return _s;
