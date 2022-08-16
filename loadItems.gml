

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
// stand discs were moved to their stand files

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
        // case "D4C":
        //     STAND.hasHeart = true;
        //     D4CEvolveIfCan();
        // break;
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

