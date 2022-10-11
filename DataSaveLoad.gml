
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

_map[? "jjQuestPucciBlueprintCompleted"] = global.questPucciBlueprintCompleted;

if (global.pucciSpawned == true)
{
    _map[? "jjbamPucciSpawned"] = global.pucciSpawned;
    if (instance_exists(global.pucciRef))
    {
        _map[? "jjbamPucciX"] = global.pucciRef.x;
        _map[? "jjbamPucciY"] = global.pucciRef.y;
    }
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
    case "tw": GiveTheWorld(player); break;
    case "sp": GiveStarPlatinum(player); break;
    case "anubis": GiveAnubis(player); break;
    case "d4clt": GiveD4CLT(player); break;
    case "twau": GiveTheWorldAU(player); break;
    case "stw": GiveShadowTheWorld(player); break;
    case "kq": GiveKillerQueen(player); break;
    case "kqbtd": GiveKillerQueenBtD(player); break;
}
switch (_stand)
{
    // p3
    case "jjbamTw": GiveTheWorld(player); break;
    case "jjbamSp": GiveStarPlatinum(player); break;
    case "jjbamSc": GiveSilverChariot(player); break;
    case "jjbamAnubis": GiveAnubis(player); break;
    case "jjbamStw":
        GiveShadowTheWorld(player);
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
    case "jjbamSptw": GiveSPTW(player); break;
    case "jjbamKq": GiveKillerQueen(player); break;
    case "jjbamKqbtd": GiveKillerQueenBtD(player); break;
    // p5
    case "jjbamSf": GiveStickyFingers(player); break;
    case "jjbamGe": GiveGoldExperience(player); break;
    case "jjbamKc": GiveKingCrimson(player); break;
    // p6
    case "jjbamWs": GiveWhiteSnake(player); break;
    case "jjbamCmn": GiveCMoon(player); break;
    // p7
    case "jjbamD4c":
        GiveD4C(player);
        STAND.hasArm = _map[? "jjbamD4cHasArm"];
        STAND.hasHeart = _map[? "jjbamD4cHasHeart"];
        STAND.hasEye = _map[? "jjbamD4cHasEye"];
    break;
    case "jjbamD4clt": GiveD4CLT(player); break;
    case "jjbamTwau": GiveTheWorldAU(player); break;
    case "jjbamSpin": GiveSpin(player); break;
    case "jjbamTsk":
        GiveTusk(player);
        STAND.hasAct1 = _map[? "jjbamTuskA1"];
        STAND.hasAct2 = _map[? "jjbamTuskA2"];
        STAND.hasAct3 = _map[? "jjbamTuskA3"];
        STAND.hasAct4 = _map[? "jjbamTuskA4"];
    break;
    // other
    case "jjbamSw": GiveSpookyWorld(player); break;
    case "jjbamSus": GiveImposter(player); break;
    case "jjbamSpr": GiveSpr(player); break;
    case "jjbamTwr": GiveTwr(player); break;
    case "jjbamSpova": GiveSpova(player); break;
    case "jjbamTwova": GiveTwova(player); break;
    case "jjbamShadow": GiveShadow(player); break;
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

#region quests

global.questPucciBlueprintCompleted = _map[? "jjQuestPucciBlueprintCompleted"];

#endregion


#region npcs

// load pucci
if (_map[? "jjbamPucciSpawned"] == true)
{
    var xx = _map[? "jjbamPucciX"];
    var yy = _map[? "jjbamPucciY"];
    SpawnPucci(xx, yy);
}

#endregion


