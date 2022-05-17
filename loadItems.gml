

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

global.jjbamDiscTwova = ItemCreate(
    undefined,
    "DISC:TWOVA",
    "The label says: The World OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveTwova),
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

global.jjbamDiscSpova = ItemCreate(
    undefined,
    "DISC:SPOVA",
    "The label says: Star Platinum OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(GiveSpova),
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

global.jjbamAnubis = ItemCreate(
    undefined,
    "Anubis",
    "Anubis is the strongest stand!",
    global.sprAnubis,
    ItemType.Consumable,
    ItemSubType.None,
    0,
    0,
    0,
    undefined,
    ScriptWrap(AnubisUse),
    0,
    true,
    5
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

#region holy parts

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

#endregion

#define AnubisUse

var _dir = point_direction(x, y, mouse_x, mouse_y);

var _p = ProjectileCreate(x, y);
with (_p)
{
    sprite_index = global.sprHorizontalSlash;
    despawnFade = false;
    despawnTime = 0.1;
    damage = 5;
    distance = 24;
    direction = _dir;
    stationary = true;
    destroyOnImpact = false;
}
GainItem(global.jjbamAnubis);

#define SusArrowUse

if (!instance_exists(STAND))
{
    DmgPlayer(1, false);
    GiveRandomStand();
}
else
{
    GainItem(global.jjbamArrow);
}

#define VerySusArrowUse

if (instance_exists(STAND))
{
    DmgPlayer(1, false);
    switch (STAND.name)
    {
        case "Killer Queen":
            RemoveStand();
            GiveKillerQueenBtD();
        break;
        default:
            Trace("Nothing happens...");
            GainItem(global.jjbamRequiem);
        break;
    }
}
else
{
    GainItem(global.jjbamRequiem);
}

#define GiveRandomStand

var _standPool =
[
    [GiveStarPlatinum, 30],
    [GiveShadowTheWorld, 30],
    [GiveKillerQueen, 30],
    [GiveStickyFingers, 30],
    [GiveGoldExperience, 30],
    [GiveSpookyWorld, 1],
    [GiveImposter, 1],
    [GiveSpova, 1],
    [GiveTwova, 1]
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

if (instance_exists(STAND))
{
    if (STAND.discType != noone)
    {
        DmgPlayer(1, false);
        GainItem(STAND.discType);
        RemoveStand();
    }
}
else
{
    GainItem(global.jjbamDisc);
}

#define LeftArmUse

if (instance_exists(STAND))
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
        default:
            Trace("The holy part refuses to interact with you");
            GainItem(global.jjbamLeftArm);
        break;
    }
}
else
{
    Trace("The holy part refuses to interact with you");
    GainItem(global.jjbamLeftArm);
}

#define HeartUse

if (instance_exists(STAND))
{
    switch (STAND.name)
    {
        case "Tusk":
            STAND.hasAct2 = true;
        break;
        case "D4C":
            STAND.hasHeart = true;
            D4CEvolveIfCan();
        break;
        default:
            Trace("The holy part refuses to interact with you");
            GainItem(global.jjbamHeart);
        break;
    }
}
else
{
    GiveD4C();
}

#define EyeUse

if (instance_exists(STAND))
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
        break;
        default:
            Trace("The holy part refuses to interact with you");
            GainItem(global.jjbamEye);
        break;
    }
}
else
{
    GiveTheWorldAU();
}

