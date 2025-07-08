
global.jjbamDiscSfg = ItemCreate(
    undefined,
    tr("standDiscName") + "SFG",
    tr("standDiscDescription") + "Sticky Fingers Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSfgUse),
    5 * 10,
    true
);

#define DiscSfgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSfg);
    exit;
}
GiveSfg(player);

#define GiveSfg(_owner) //stand

var _s = GiveStickyFingers(_owner);
with (_s)
{
    sprite_index = global.sprSFG;
    name = "Sticky Fingers Gray";
    color = c_gray;
    colorAlt = c_ltgray;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamSfg";
    discType = global.jjbamDiscSfg;
}
return _s;
