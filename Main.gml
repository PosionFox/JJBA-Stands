
#define EventHandler



#define SaveData

var _map = ds_map_create();

if (instance_exists(player))
{
    if ("myStand" in player and instance_exists(STAND))
    {
        _map[? "jjbamAbility"] = STAND.saveKey; // save stand
        // _map[? "jjbamAbilitySkills"] = string(array_clone(objPlayer.myStand.skills)); // save stand skills
        // Trace(_map[? "jjbamAbilitySkills"]);
        
        switch (STAND.saveKey)
        {
            case "jjbamStw": // save stw xp
                _map[? "jjbamStwXp"] = STAND.xp;
            break;
            case "jjbamTsk": // save tusk acts
                _map[? "jjbamTuskA1"] = STAND.hasAct1;
                _map[? "jjbamTuskA2"] = STAND.hasAct2;
                _map[? "jjbamTuskA3"] = STAND.hasAct3;
                _map[? "jjbamTuskA4"] = STAND.hasAct4;
            break;
            case "jjbamD4c":
                _map[? "jjbamD4cHasArm"] = STAND.hasArm;
                _map[? "jjbamD4cHasHeart"] = STAND.hasHeart;
                _map[? "jjbamD4cHasEye"] = STAND.hasEye;
            break;
        }
    }
    if ("skCustomStands" in player)
    {
        _map[? "jjbamCustomStands"] = player.skCustomStands;
    }
}

if (global.pucciSpawned == true)
{
    _map[? "jjbamPucciSpawned"] = global.pucciSpawned;
    _map[? "jjbamPucciX"] = global.pucciRef.x;
    _map[? "jjbamPucciY"] = global.pucciRef.y;
}

ModSaveDataSubmit(_map);
ds_map_destroy(_map);

#define LoadData

var _map = ModSaveDataFetch();

var _standCompatibility = _map[? "pAbility"];
var _stand = _map[? "jjbamAbility"];
var _custom = _map[? "jjbamCustomStands"];
//Trace(_custom);

switch (_standCompatibility)
{
    case "tw": GiveTheWorld(); break;
    case "sp": GiveStarPlatinum(); break;
    case "anubis": GiveAnubis(); break;
    case "d4clt": GiveD4CLT(); break;
    case "twau": GiveTheWorldAU(); break;
    case "stw": GiveShadowTheWorld(); break;
    case "kq": GiveKillerQueen(); break;
    case "kqbtd": GiveKillerQueenBtD(); break;
}
switch (_stand)
{
    // p3
    case "jjbamTw": GiveTheWorld(); break;
    case "jjbamSp": GiveStarPlatinum(); break;
    case "jjbamSc": GiveSilverChariot(); break;
    case "jjbamAnubis": GiveAnubis(); break;
    case "jjbamStw":
        GiveShadowTheWorld();
        var _xp = _map[? "jjbamStwXp"];
        if (_xp == undefined)
        {
            STAND.xp = 0;
        }
        else
        {
            STAND.xp = _xp;
        }
    break;
    // p4
    case "jjbamSptw": GiveSPTW(); break;
    case "jjbamKq": GiveKillerQueen(); break;
    case "jjbamKqbtd": GiveKillerQueenBtD(); break;
    // p5
    case "jjbamSf": GiveStickyFingers(); break;
    case "jjbamGe": GiveGoldExperience(); break;
    case "jjbamKc": GiveKingCrimson(); break;
    // p6
    case "jjbamWs": GiveWhiteSnake(); break;
    case "jjbamCmn": GiveCMoon(); break;
    // p7
    case "jjbamD4c":
        GiveD4C();
        STAND.hasArm = _map[? "jjbamD4cHasArm"];
        STAND.hasHeart = _map[? "jjbamD4cHasHeart"];
        STAND.hasEye = _map[? "jjbamD4cHasEye"];
    break;
    case "jjbamD4clt": GiveD4CLT(); break;
    case "jjbamTwau": GiveTheWorldAU(); break;
    case "jjbamSpin": GiveSpin(); break;
    case "jjbamTsk":
        GiveTusk();
        STAND.hasAct1 = _map[? "jjbamTuskA1"];
        STAND.hasAct2 = _map[? "jjbamTuskA2"];
        STAND.hasAct3 = _map[? "jjbamTuskA3"];
        STAND.hasAct4 = _map[? "jjbamTuskA4"];
    break;
    // other
    case "jjbamSw": GiveSpookyWorld(); break;
    case "jjbamSus": GiveImposter(); break;
    case "jjbamSpr": GiveSpr(); break;
    case "jjbamTwr": GiveTwr(); break;
    case "jjbamSpova": GiveSpova(); break;
    case "jjbamTwova": GiveTwova(); break;
}

// Trace(_map[? "jjbamAbilitySkills"]);
// if (_map[? "jjbamAbilitySkills"] != undefined)
// {
//     objPlayer.myStand.skills = array_clone(json_decode(_map[? "jjbamAbilitySkills"])); // load skills
// }

if (_custom == true)
{
    //Trace("custom is: " + string(_custom));
    if (instance_exists(player))
    {
        if ("skCustomStands" in player)
        {
            global.hasCustomStands = true;
            StructureEdit(global.jjbamStandWorkshop, StructureData.Unlocked, true);
        }
    }
}
else
{
    //Trace("custom is: " + string(_custom));
    if (instance_exists(player))
    {
        if ("skCustomStands" in player)
        {
            player.skCustomStands = false;
        }
    }
}

// load pucci
if (_map[? "jjbamPucciSpawned"] == true)
{
    var xx = _map[? "jjbamPucciX"];
    var yy = _map[? "jjbamPucciY"];
    SpawnPucci(xx, yy);
}

#define InitPlayerVariables

if (instance_exists(player))
{
    if !("myStand" in player)
    {
        STAND = noone;
    }
    if !("skCustomStands" in player)
    {
        player.skCustomStands = false;
    }
}

#define newClass(class)

return array_clone(class);

#define printVersion

Trace("jjbas v0.5.0");

#define Main

printVersion();

global.timeIsFrozen = false;

loadSprites();
loadSounds();
loadItems();
loadStands();
loadStructures();
loadNPCs();
loadCommands();




