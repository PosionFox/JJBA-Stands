

global.jjbamArrow = ItemCreate(
    undefined,
    "Suspicious Arrow",
    "Looks like a normal arrow.",
    global.sprArrow,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [
        Item.Wood, 1,
        Item.StarFragment, 1
    ],
    ScriptWrap(SusArrowUse),
    5 * 10,
    true
);

global.jjbamDisc = ItemCreate(
    undefined,
    "DISC",
    "A disc to remove data.",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [
        Item.Glass, 2,
    ],
    ScriptWrap(DiscUse),
    5 * 10,
    true
);

var _newArray = StructureGet(Structure.Forge, StructureData.Items);
array_push(_newArray, global.jjbamArrow);
array_push(_newArray, global.jjbamDisc);
StructureEdit(Structure.Forge, StructureData.Items, _newArray);

#define SusArrowUse

DmgPlayer(1, false);
GiveRandomStand();

#define GiveRandomStand

var _standPool =
[
    GiveTheWorld,
    GiveStarPlatinum,
    GiveTheWorldAU,
    GiveShadowTheWorld
]

var _c = irandom(array_length(_standPool) - 1);
script_execute(_standPool[_c]);

#define DiscUse

DmgPlayer(1, false);
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == "timestop")
        {
            instance_destroy(self);
        }
    }
}
with (objPlayer)
{
    instance_destroy(myStand);
    myStand = noone;
}
SaveStand(noone);


