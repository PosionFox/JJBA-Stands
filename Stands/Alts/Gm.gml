
global.jjbamDiscGm = ItemCreate(
    undefined,
    tr("standDiscName") + "GM",
    tr("standDiscDescription") + "Gloomist",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscGmUse),
    5 * 10,
    true
);

#define DiscGmUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscGm);
    exit;
}
GiveGm(player);

#define GiveGm(_owner) //stand

var _s = GiveD4CLT(_owner);
with (_s)
{
    sprite_index = global.sprGloomist;
    name = "Gloomist";
    color = 0x8a4276;
    colorAlt = c_purple;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle4;
    saveKey = "jjbamGm";
    discType = global.jjbamDiscGm;
}
return _s;
