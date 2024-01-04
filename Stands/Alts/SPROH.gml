

global.jjbamDiscSproh = ItemCreate(
    undefined,
    Localize("standDiscName") + "SPROH",
    Localize("standDiscDescription") + "Star Platinum Retro Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSprohUse),
    5 * 10,
    true
);

#define DiscSprohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSproh);
    exit;
}
GiveSPROH(player);

#define GiveSPROH(_owner) //stand

var _s = GiveSpr(_owner);
with (_s)
{
    name = "Star Platinum Retro\nOver Heaven";
    sprite_index = global.sprSPROH;
    color = 0x342022;
    UpdateRarity(Rarity.Ultimate);
    saveKey = "jjbamSproh";
    discType = global.jjbamDiscSproh;
}
return _s;

