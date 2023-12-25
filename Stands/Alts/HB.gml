
global.jjbamDiscHb = ItemCreate(
    undefined,
    Localize("standDiscName") + "HB",
    Localize("standDiscDescription") + "Hierophant Black",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscHbUse),
    5 * 10,
    true
);

#define DiscHbUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscHb);
    exit;
}
GiveHb(player);

#define GiveHb(_owner)

var _s = GiveHierophantGreen(_owner);
with (_s)
{
    name = "Hierophant Black"
    sprite_index = global.sprHierophantBlack;
    color = 0x342022;
    UpdateRarity(Rarity.Rare);
    auraParticleSprite = global.sprStandParticle2;
    saveKey = "jjbamHb";
    discType = global.jjbamDiscHb;
}
return _s;
