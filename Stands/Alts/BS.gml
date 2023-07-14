
global.jjbamDiscBs = ItemCreate(
    undefined,
    Localize("standDiscName") + "BS",
    Localize("standDiscDescription") + "BlackSnake",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscBsUse),
    5 * 10,
    true
);

#define DiscBsUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscBs);
    exit;
}
GiveBs(player);

#define GiveBs(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "BlackSnake"
    sprite_index = global.sprBlackSnake;
    color = /*#*/0x342022;
    tier = {
        name : "rare",
        color : c_blue
    }
    powerMultiplier = 5;
    auraParticleSprite = global.sprStandParticle4;
    saveKey = "jjbamBs";
    discType = global.jjbamDiscBs;
}
return _s;
