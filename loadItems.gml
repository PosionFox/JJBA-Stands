

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

global.jjbamRequiem = ItemCreate(
    undefined,
    "Very Suspicious Arrow",
    "An arrow with a fancy beetle design.",
    global.sprArrowBeetle,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [
        Item.Wood, 1,
        Item.StarFragment, 1,
        Item.CosmicSteel, 1
    ],
    ScriptWrap(VerySusArrowUse),
    5 * 20,
    true
);

var _newArray = StructureGet(Structure.Forge, StructureData.Items);
array_push(_newArray, global.jjbamArrow);
array_push(_newArray, global.jjbamDisc);
array_push(_newArray, global.jjbamRequiem);
StructureEdit(Structure.Forge, StructureData.Items, _newArray);

#define SusArrowUse

DmgPlayer(1, false);
GiveRandomStand();

#define VerySusArrowUse

switch (objPlayer.myStand.name)
{
    case "Killer Queen":
        DmgPlayer(1, false);
        RemoveStand();
        GiveKillerQueenBtD();
    break;
}

#define GiveRandomStand

var _standPool =
[
    GiveTheWorld,
    GiveStarPlatinum,
    GiveTheWorldAU,
    GiveShadowTheWorld,
    GiveD4CLT,
    GiveKillerQueen
]

var _c = irandom(array_length(_standPool) - 1);
script_execute(_standPool[_c]);

#define DiscUse

DmgPlayer(1, false);
RemoveStand();
SaveStand(noone);


