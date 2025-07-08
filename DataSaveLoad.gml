
#define GiveStandByKey(_key)

switch (_key)
{
    // p3
    case "jjbamTw": GiveTheWorld(player); break;
    case "jjbamSpp": GiveSpp(player); break;
    case "jjbamSp": GiveStarPlatinum(player);
    break;
    case "jjbamSc": GiveSilverChariot(player); break;
    case "jjbamAnubis": GiveAnubis(player); break;
    case "jjbamStw": GiveShadowTheWorld(player);
    break;
    case "jjbamMr": GiveMagiciansRed(player); break;
    case "jjbamHg": GiveHierophantGreen(player); break;
    // p4
    case "jjbamSptw": GiveSPTW(player); break;
    case "jjbamKq": GiveKillerQueen(player); break;
    case "jjbamKqbtd": GiveKillerQueenBtD(player); break;
    case "jjbamCd": GiveCrazyDiamond(player); break;
    // p5
    case "jjbamSf": GiveStickyFingers(player); break;
    case "jjbamGe": GiveGoldExperience(player); break;
    case "jjbamGer": GiveGer(player); break;
    case "jjbamKc": GiveKingCrimson(player); break;
    // p6
    case "jjbamWs": GiveWhiteSnake(player); break;
    case "jjbamCmn": GiveCMoon(player); break;
    // p7
    case "jjbamD4c": GiveD4C(player);
    break;
    case "jjbamD4clt": GiveD4CLT(player); break;
    case "jjbamTwau": GiveTheWorldAU(player); break;
    case "jjbamSpin": GiveSpin(player); break;
    case "jjbamTsk": GiveTusk(player);
    break;
    // p8
    case "jjbamSnw": GiveSoftAndWet(player); break;
    // other
    case "jjbamSw": GiveSpookyWorld(player); break;
    case "jjbamSus": GiveImposter(player); break;
    case "jjbamSpr": GiveSpr(player); break;
    case "jjbamTwr": GiveTwr(player); break;
    case "jjbamSpova": GiveSpova(player); break;
    case "jjbamTwova": GiveTwova(player); break;
    case "jjbamShadow": GiveShadow(player); break;
    case "jjbamSqbtd": GiveSQBTD(player); break;
    case "jjbamKcm": GiveKcm(player); break;
    case "jjbamScova": GiveScova(player); break;
    case "jjbamNeo": GiveNeo(player); break;
    case "jjbamTe": GiveTe(player); break;
    case "jjbamBs": GiveBs(player); break;
    case "jjbamSnwg": GiveSnwg(player); break;
    case "jjbamPd4c": GivePd4c(player); break;
    case "jjbamPd4clt": GivePd4clt(player); break;
    case "jjbamEg": GiveEg(player); break;
    case "jjbamTwgh": GiveTwgh(player); break;
    case "jjbamTwg": GiveTwg(player); break;
    case "jjbamKcmo": GiveKcmo(player); break;
    case "jjbamKca": GiveKca(player); break;
    case "jjbamTwru": GiveTwru(player); break;
    case "jjbamSpg": GiveSpg(player); break;
    case "jjbamTwau3000": GiveTwau3000(player); break;
    case "jjbamSfg": GiveSfg(player); break;
    case "jjbamSfr": GiveSfr(player); break;
    case "jjbamKcg": GiveKcg(player); break;
    case "jjbamGm": GiveGm(player); break;
    case "jjbamTwoh": GiveTWOH(player); break;
    case "jjbamTwroh": GiveTwroh(player); break;
    case "jjbamTwruoh": GiveTwruoh(player); break;
    case "jjbamDw": GiveDw(player); break;
    case "jjbamHr": GiveHr(player); break;
    case "jjbamHb": GiveHb(player); break;
    case "jjbamEp": GiveEP(player); break;
    case "jjbamTwf": GiveTWF(player); break;
    case "jjbamKcf": GiveKCF(player); break;
    case "jjbamHe": GiveHE(player); break;
    case "jjbamSpoh": GiveSPOH(player); break;
    case "jjbamSproh": GiveSPROH(player); break;
    case "jjbamSans": GiveSans(player); break;
    case "jjbamGojo": GiveGojo(player); break;
    case "jjbamKcau": GiveKCAU(player); break;
    case "jjbamSukuna": GiveSukuna(player); break;
    case "jjbamKce": GiveKce(player); break;
    case "jjsP03": GiveP03(player); break;
    case "jjGreenSnake": GiveGreenSnake(player); break;
    case "jjBlueSnake": GiveBlueSnake(player); break;
    case "jjPurpleSnake": GivePurpleSnake(player); break;
    case "jjYellowSnake": GiveYellowSnake(player); break;
    case "jjRedSnake": GiveRedSnake(player); break;
    case "jjOrangeSnake": GiveOrangeSnake(player); break;
    case "jjPinkSnake": GivePinkSnake(player); break;
}

#define LoadStand(_map)
//  for non rmGame rooms
var _stand = _map[? "jjbamAbility"];
if (_stand != undefined)
{
    DeconstructStandData(_stand);
    
    var _key = string_split(_stand, ":")[0];

    switch (_key)
    {
        case "jjbamD4c":
            STAND.hasArm = _map[? "jjbamD4cHasArm"];
            STAND.hasHeart = _map[? "jjbamD4cHasHeart"];
            STAND.hasEye = _map[? "jjbamD4cHasEye"];
        break;
        case "jjbamPd4c":
            STAND.hasArm = _map[? "jjbamD4cHasArm"];
            STAND.hasHeart = _map[? "jjbamD4cHasHeart"];
            STAND.hasEye = _map[? "jjbamD4cHasEye"];
        break;
        case "jjbamTsk":
            STAND.hasAct1 = _map[? "jjbamTuskA1"];
            STAND.hasAct2 = _map[? "jjbamTuskA2"];
            STAND.hasAct3 = _map[? "jjbamTuskA3"];
            STAND.hasAct4 = _map[? "jjbamTuskA4"];
        break;
    }
}

#define SaveData

var _sett_map = ds_map_create();

_sett_map[? "jjsCurrentLang"] = global.jjsCurrentLang;

ModSettingsSubmit(_sett_map);
ds_map_destroy(_sett_map);


var _map = ds_map_create();

_map[? "jjNewGame"] = global.jjNewGame;

var _stand; // not using STAND macro because it errors on new worlds
if ("myStand" in player) { _stand = player.myStand; }

if (instance_exists(player))
{
    if (instance_exists(_stand))
    {
        _map[? "jjbamAbility"] = ConstructStandData(_stand); // save stand
        //Trace("saving stand: " + string(STAND.saveKey));
        // _map[? "jjbamAbilitySkills"] = string(array_clone(objPlayer.myStand.skills)); // save stand skills
        // Trace(_map[? "jjbamAbilitySkills"]);
        
        switch (_stand.saveKey)
        {
            case "jjbamTsk": // save tusk acts
                _map[? "jjbamTuskA1"] = _stand.hasAct1;
                _map[? "jjbamTuskA2"] = _stand.hasAct2;
                _map[? "jjbamTuskA3"] = _stand.hasAct3;
                _map[? "jjbamTuskA4"] = _stand.hasAct4;
            break;
            case "jjbamD4c":
                _map[? "jjbamD4cHasArm"] = _stand.hasArm;
                _map[? "jjbamD4cHasHeart"] = _stand.hasHeart;
                _map[? "jjbamD4cHasEye"] = _stand.hasEye;
            break;
            case "jjbamPd4c":
                _map[? "jjbamD4cHasArm"] = _stand.hasArm;
                _map[? "jjbamD4cHasHeart"] = _stand.hasHeart;
                _map[? "jjbamD4cHasEye"] = _stand.hasEye;
            break;
        }
    }
    if ("skCustomStands" in player)
    {
        _map[? "jjbamCustomStands"] = player.skCustomStands;
    }
    _map[? "jjSummonKeybind"] = "summonKeybind" in player ? player.summonKeybind : undefined;
    _map[? "jjAbilityKeybind2"] = "abilityKeybind2" in player ? player.abilityKeybind2 : undefined;
    _map[? "jjAbilityKeybind1"] = "abilityKeybind1" in player ? player.abilityKeybind1 : undefined;
    _map[? "jjAbilityKeybind3"] = "abilityKeybind3" in player ? player.abilityKeybind3 : undefined;
    _map[? "jjAbilityKeybind4"] = "abilityKeybind4" in player ? player.abilityKeybind4 : undefined;
    _map[? "jjSpecKeybind1"] = "specKeybind1" in player ? player.specKeybind1 : undefined;
    _map[? "jjSpecKeybind2"] = "specKeybind2" in player ? player.specKeybind2 : undefined;
}
// npcs
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
// enemies
_map[? "jjEnemyDioSpawned"] = global.enemyDioSpawned;
if (_map[? "jjEnemyDioSpawned"] == true)
{
    var _dio = modSubtypeFind("DIO");
    _map[? "jjEnemyDioX"] = _dio.x;
    _map[? "jjEnemyDioY"] = _dio.y;
    _map[? "jjEnemyDioHp"] = _dio.hp;
}

// runes
SaveRunes(_map);

// mod settings
_map[? "jjAudioVolume"] = global.jjSettAudioVolume;
_map[? "jjSettStandTalkIdle"] = global.jjSettStandTalkIdle;
_map[? "jjSettProjShadows"] = global.jjSettProjShadows;
_map[? "jjSettProjCollisions"] = global.jjSettProjCollisions;

// stand storage
var _ss = array_length(global.jjStandSlots);
for (var i = 0; i < _ss; i++)
{
    var _key = "jjStandSlot" + string(i);
    _map[? _key] = global.jjStandSlots[i];
}

ModSaveDataSubmit(_map);
ds_map_destroy(_map);

#define LoadData

var _map = ModSaveDataFetch();

if (_map[? "jjNewGame"] != undefined)
{
    global.jjNewGame = _map[? "jjNewGame"];
}
else
{
    global.jjNewGame = false;
}

var _standCompatibility = _map[? "pAbility"];
var _stand = _map[? "jjbamAbility"];
var _custom = _map[? "jjbamCustomStands"];
//Trace("loading stand: " + string(_stand));

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
LoadStand(_map);

if (instance_exists(player))
{
    if (_map[? "jjSummonKeybind"] != undefined) { player.summonKeybind = _map[? "jjSummonKeybind"]; }
    if (_map[? "jjAbilityKeybind1"] != undefined) { player.abilityKeybind1 = _map[? "jjAbilityKeybind1"]; }
    if (_map[? "jjAbilityKeybind2"] != undefined) { player.abilityKeybind2 = _map[? "jjAbilityKeybind2"]; }
    if (_map[? "jjAbilityKeybind3"] != undefined) { player.abilityKeybind3 = _map[? "jjAbilityKeybind3"]; }
    if (_map[? "jjAbilityKeybind4"] != undefined) { player.abilityKeybind4 = _map[? "jjAbilityKeybind4"]; }
    if (_map[? "jjSpecKeybind1"] != undefined) { player.specKeybind1 = _map[? "jjSpecKeybind1"]; }
    if (_map[? "jjSpecKeybind2"] != undefined) { player.specKeybind2 = _map[? "jjSpecKeybind2"]; }
}
if (instance_exists(STAND))
{
    STAND.skills[StandState.SkillAOff, StandSkill.Key] = player.abilityKeybind1;
    STAND.skills[StandState.SkillA, StandSkill.Key] = player.abilityKeybind1;
    STAND.skills[StandState.SkillBOff, StandSkill.Key] = player.abilityKeybind2;
    STAND.skills[StandState.SkillB, StandSkill.Key] = player.abilityKeybind2;
    STAND.skills[StandState.SkillCOff, StandSkill.Key] = player.abilityKeybind3;
    STAND.skills[StandState.SkillC, StandSkill.Key] = player.abilityKeybind3;
    STAND.skills[StandState.SkillDOff, StandSkill.Key] = player.abilityKeybind4;
    STAND.skills[StandState.SkillD, StandSkill.Key] = player.abilityKeybind4;
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
            StructureEdit(global.jjsStandWorkshop, StructureData.Unlocked, true);
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
if (room == rmGame and _map[? "jjbamPucciSpawned"] == true)
{
    var xx = _map[? "jjbamPucciX"];
    var yy = _map[? "jjbamPucciY"];
    SpawnPucci(xx, yy);
}

#endregion

#region enemies

if (_map[? "jjEnemyDioSpawned"])
{
    EnemyDioSpawn();
    var _dio = modSubtypeFind("DIO");
    if ds_map_exists(_map, "jjEnemyDioX") _dio.x = _map[? "jjEnemyDioX"];
    if ds_map_exists(_map, "jjEnemyDioY") _dio.y = _map[? "jjEnemyDioY"];
    if ds_map_exists(_map, "jjEnemyDioHp") _dio.hp = _map[? "jjEnemyDioHp"];
}

#endregion

#region runes

LoadRunes(_map);

#endregion

#region mod settings

if (_map[? "jjAudioVolume"] != undefined)
{
    global.jjSettAudioVolume = _map[? "jjAudioVolume"];
}
else
{
    global.jjSettAudioVolume = 1.0;
}

if (_map[? "jjSettStandTalkIdle"] != undefined)
{
    global.jjSettStandTalkIdle = _map[? "jjSettStandTalkIdle"];
}
else
{
    global.jjSettStandTalkIdle = true;
}

if (_map[? "jjSettProjShadows"] != undefined)
{
    global.jjSettProjShadows = _map[? "jjSettProjShadows"];
}
else
{
    global.jjSettProjShadows = true;
}

if (_map[? "jjSettProjCollisions"] != undefined)
{
    global.jjSettProjCollisions = _map[? "jjSettProjCollisions"];
}
else
{
    global.jjSettProjCollisions = false;
}

#endregion

#region stand storage

var _ss = array_length(global.jjStandSlots);
for (var i = 0; i < _ss; i++)
{
    var _key = "jjStandSlot" + string(i);
    var _loaded_stand = _map[? _key];
    if (_loaded_stand != undefined)
    {
        global.jjStandSlots[i] = _loaded_stand;
        global.jjMenuStorageNames[i] = string_split(_loaded_stand, ":")[1];
    }
    else
    {
        global.jjStandSlots[i] = undefined;
        global.jjMenuStorageNames[i] = undefined;
    }
}

#endregion

ds_map_destroy(_map);
