
global.jjbamDiscSpg = ItemCreate(
    undefined,
    tr("standDiscName") + "SPG",
    tr("standDiscDescription") + "Star Platinum Gray",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSpgUse),
    5 * 10,
    true
);

#define DiscSpgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpg);
    exit;
}
GiveSpg(player);

#define GiveSpg(_owner)

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum Gray";
    sprite_index = global.sprSPG;
    color = c_gray;
    colorAlt = c_ltgray;
    scarf_color = c_dkgray;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjbamSpg";
    discType = global.jjbamDiscSpg;
    
    evolutions = [];
}
return _s;
