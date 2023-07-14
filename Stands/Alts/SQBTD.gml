
global.jjbamDiscSQBTD = ItemCreate(
    undefined,
    Localize("standDiscName") + "SQBTD",
    Localize("standDiscDescription") + "Shadow Queen: Bites the Dust",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSQBTDUse),
    5 * 10,
    true
);

#define DiscSQBTDUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSQBTD);
    exit;
}
GiveSQBTD(player);

#define GiveSQBTD(_owner) //stand

var _s = GiveKillerQueenBtD(_owner);
with (_s)
{
    sprite_index = global.sprSQBTD;
    name = "Shadow Queen:\nBites the Dust";
    color = 0x3c2845;
    tier = {
        name : "epic",
        color : c_purple
    }
    powerMultiplier = 10;
    auraParticleSprite = global.sprStandParticle2;
    saveKey = "jjbamSqbtd";
    discType = global.jjbamDiscSQBTD;
}
return _s;
