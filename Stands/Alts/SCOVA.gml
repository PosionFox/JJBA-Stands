
global.jjbamDiscScova = ItemCreate(
    undefined,
    Localize("standDiscName") + "SCOVA",
    Localize("standDiscDescription") + "Silver Chariot OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscScovaUse),
    5 * 10,
    true
);

#define DiscScovaUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscScova);
    exit;
}
GiveScova(player);

#define GiveScova(_owner) //stand

var _s = GiveSilverChariot(_owner);
with (_s)
{
    sprite_index = global.sprSilverChariotOVA;
    sprArmored = sprite_index;
    sprArmorless = sprite_index;
    name = "Silver Chariot OVA";
    color = 0x36f2fb;
    UpdateRarity(Rarity.Rare);
    saveKey = "jjbamScova";
    discType = global.jjbamDiscScova;
}
return _s;
