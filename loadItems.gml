

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

#region discs

global.jjbamDisc = ItemCreate(
    undefined,
    "DISC",
    "A disc to remove and store data.",
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

#region p3

global.jjbamDiscTw = ItemCreate(
    undefined,
    "DISC:TW",
    "The label says: The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveTheWorld),
    5 * 10,
    true
);

global.jjbamDiscSp = ItemCreate(
    undefined,
    "DISC:SP",
    "The label says: Star Platinum",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveStarPlatinum),
    5 * 10,
    true
);

global.jjbamDiscSc = ItemCreate(
    undefined,
    "DISC:SC",
    "The label says: Silver Chariot",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveSilverChariot),
    5 * 10,
    true
);

global.jjbamDiscStw = ItemCreate(
    undefined,
    "DISC:STW",
    "The label says: Shadow The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveShadowTheWorld),
    5 * 10,
    true
);

#endregion

#region p4

global.jjbamDiscSptw = ItemCreate(
    undefined,
    "DISC:SPTW",
    "The label says: Star Platinum: The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveSPTW),
    5 * 10,
    true
);

global.jjbamDiscKq = ItemCreate(
    undefined,
    "DISC:KQ",
    "The label says: Killer Queen",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveKillerQueen),
    5 * 10,
    true
);

global.jjbamDiscKqbtd = ItemCreate(
    undefined,
    "DISC:KQBTD",
    "The label says: KQ Bites the Dust",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveKillerQueenBtD),
    5 * 10,
    true
);

#endregion

#region p5

global.jjbamDiscSf = ItemCreate(
    undefined,
    "DISC:SF",
    "The label says: Sticky Fingers",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveStickyFingers),
    5 * 10,
    true
);

global.jjbamDiscGe = ItemCreate(
    undefined,
    "DISC:GE",
    "The label says: Gold Experience",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveGoldExperience),
    5 * 10,
    true
);

#endregion

#region p6

global.jjbamDiscWs = ItemCreate(
    undefined,
    "DISC:WS",
    "The label says: WhiteSnake",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveWhiteSnake),
    5 * 10,
    true
);

global.jjbamDiscCmn = ItemCreate(
    undefined,
    "DISC:CMN",
    "The label says: C-Moon",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveCMoon),
    5 * 10,
    true
);

#endregion

#region p7

global.jjbamDiscTwau = ItemCreate(
    undefined,
    "DISC:TWAU",
    "The label says: The World AU",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveTheWorldAU),
    5 * 10,
    true
);

global.jjbamDiscD4c = ItemCreate(
    undefined,
    "DISC:D4C",
    "The label says: Dirty Deeds Done Dirt Cheap",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveD4C),
    5 * 10,
    true
);

global.jjbamDiscD4clt = ItemCreate(
    undefined,
    "DISC:D4CLT",
    "The label says: D4C Love Train",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveD4CLT),
    5 * 10,
    true
);

global.jjbamDiscTsk = ItemCreate(
    undefined,
    "DISC:TUSK",
    "The label says: Tusk",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveTusk),
    5 * 10,
    true
);

#endregion

#region other

global.jjbamDiscSw = ItemCreate(
    undefined,
    "DISC:SW",
    "The label says: Spooky World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveSpookyWorld),
    5 * 10,
    true
);

global.jjbamDiscSus = ItemCreate(
    undefined,
    "DISC:SUS",
    "The label says: Imposter",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveImposter),
    5 * 10,
    true
);

#endregion

#endregion

global.jjbamRequiem = ItemCreate(
    undefined,
    "Requiem Arrow",
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

global.jjbamSteelBall = ItemCreate(
    undefined,
    "Steel Ball",
    "Learn the ways of spin.",
    global.sprSteelBall,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [
        Item.GoldIngot, 1,
        Item.RoyalSteel, 1
    ],
    ScriptWrap(GiveSpin),
    5 * 20,
    true
);

// var _newArray = StructureGet(Structure.Forge, StructureData.Items);
// array_push(_newArray, global.jjbamArrow);
// array_push(_newArray, global.jjbamDisc);
// array_push(_newArray, global.jjbamRequiem);
// StructureEdit(Structure.Forge, StructureData.Items, _newArray);

StructureAddItem(Structure.Forge, global.jjbamArrow);
StructureAddItem(Structure.Forge, global.jjbamDisc);
StructureAddItem(Structure.Forge, global.jjbamRequiem);
//StructureAddItem(Structure.Forge, global.jjbamSteelBall);

global.jjbamHeart = ItemCreate(
    undefined,
    "Heart",
    "The heart of the saint.",
    global.sprHeart,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    undefined,
    ScriptWrap(HeartUse),
    5 * 20,
    true
);

global.jjbamEye = ItemCreate(
    undefined,
    "Eye",
    "The eye of the saint.",
    global.sprEye,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    undefined,
    ScriptWrap(EyeUse),
    5 * 20,
    true
)

global.jjbamLeftArm = ItemCreate(
    undefined,
    "Left Arm",
    "The left arm of the saint.",
    global.sprLeftArm,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    undefined,
    ScriptWrap(LeftArmUse),
    5 * 20,
    true
)

#define SusArrowUse

DmgPlayer(1, false);
if (objPlayer.myStand == noone)
{
    GiveRandomStand();
}

#define VerySusArrowUse

DmgPlayer(1, false);
if (instance_exists(objPlayer.myStand))
{
    switch (objPlayer.myStand.name)
    {
        case "Killer Queen":
            RemoveStand();
            GiveKillerQueenBtD();
        break;
    }
}

#define GiveRandomStand

var _standPool =
[
    [GiveStarPlatinum, 20],
    [GiveShadowTheWorld, 20],
    [GiveKillerQueen, 20],
    [GiveStickyFingers, 20],
    [GiveGoldExperience, 20]
]

var sumWeight = 0;
for(var i = 0; i < array_length(_standPool); i++)
{
    sumWeight += _standPool[i, 1];
}
var rnd = random(sumWeight);
for(var i = 0; i < array_length(_standPool); i++)
{
    if (rnd < _standPool[i, 1])
    {
        script_execute(_standPool[i, 0]);
        exit;
    }
    rnd -= _standPool[i, 1];
}

//var _c = irandom(array_length(_standPool) - 1);
//script_execute(_standPool[_c]);

#define DiscUse

DmgPlayer(1, false);
if (instance_exists(objPlayer))
{
    try
    {
        if ("myStand" in objPlayer)
        {
            if (instance_exists(objPlayer.myStand))
            {
                GainItem(objPlayer.myStand.discType);
            }
        }
    }
    catch (e)
    {
        Trace("stand not known");
    }
    RemoveStand();
}

#define LeftArmUse

if ("myStand" in player and instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Spin":
            GiveTusk();
        break;
        case "D4C":
            STAND.hasArm = true;
            D4CEvolveIfCan();
        break;
    }
}

#define HeartUse

if ("myStand" in player and instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Tusk":
            STAND.hasAct2 = true;
        exit;
        case "D4C":
            STAND.hasHeart = true;
            D4CEvolveIfCan();
        exit;
    }
}
GiveD4C();

#define EyeUse

if ("myStand" in player and instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Tusk":
            if (STAND.hasAct2)
            {
                STAND.hasAct3 = true;
                STAND.hasAct4 = true;
                STAND.nailsMax = 20;
                STAND.nails += 5;
            }
        exit;
        case "D4C":
            STAND.hasEye = true;
            D4CEvolveIfCan();
        exit;
    }
}
GiveTheWorldAU();

