
#define GiveStandByKey(_key, _owner)

switch (_key)
{
    // p3
    case "jjbamTw": GiveTheWorld(_owner); break;
    case "jjbamSpp": GiveSpp(_owner); break;
    case "jjbamSp": GiveStarPlatinum(_owner); break;
    case "jjbamSc": GiveSilverChariot(_owner); break;
    case "jjbamAnubis": GiveAnubis(_owner); break;
    case "jjbamStw": GiveShadowTheWorld(_owner); break;
    case "jjbamMr": GiveMagiciansRed(_owner); break;
    case "jjbamHg": GiveHierophantGreen(_owner); break;
    // p4
    case "jjbamSptw": GiveSPTW(_owner); break;
    case "jjbamKq": GiveKillerQueen(_owner); break;
    case "jjbamKqbtd": GiveKillerQueenBtD(_owner); break;
    case "jjbamCd": GiveCrazyDiamond(_owner); break;
    // p5
    case "jjbamSf": GiveStickyFingers(_owner); break;
    case "jjbamGe": GiveGoldExperience(_owner); break;
    case "jjbamGer": GiveGer(_owner); break;
    case "jjbamKc": GiveKingCrimson(_owner); break;
    // p6
    case "jjbamWs": GiveWhiteSnake(_owner); break;
    case "jjbamCmn": GiveCMoon(_owner); break;
    case "jjbamWr": GiveWeatherReport(_owner); break;
    // p7
    case "jjbamD4c": GiveD4C(_owner); break;
    case "jjbamD4clt": GiveD4CLT(_owner); break;
    case "jjbamTwau": GiveTheWorldAU(_owner); break;
    case "jjbamSpin": GiveSpin(_owner); break;
    case "jjbamTsk": GiveTusk(_owner); break;
    // p8
    case "jjbamSnw": GiveSoftAndWet(_owner); break;
    // other
    case "jjbamSw": GiveSpookyWorld(_owner); break;
    case "jjbamSus": GiveImposter(_owner); break;
    case "jjbamSpr": GiveSpr(_owner); break;
    case "jjbamTwr": GiveTwr(_owner); break;
    case "jjbamSpova": GiveSpova(_owner); break;
    case "jjbamTwova": GiveTwova(_owner); break;
    case "jjbamShadow": GiveShadow(_owner); break;
    case "jjbamSqbtd": GiveSQBTD(_owner); break;
    case "jjbamKcm": GiveKcm(_owner); break;
    case "jjbamScova": GiveScova(_owner); break;
    case "jjbamNeo": GiveNeo(_owner); break;
    case "jjbamTe": GiveTe(_owner); break;
    case "jjbamBs": GiveBs(_owner); break;
    case "jjbamSnwg": GiveSnwg(_owner); break;
    case "jjbamPd4c": GivePd4c(_owner); break;
    case "jjbamPd4clt": GivePd4clt(_owner); break;
    case "jjbamEg": GiveEg(_owner); break;
    case "jjbamTwgh": GiveTwgh(_owner); break;
    case "jjbamTwg": GiveTwg(_owner); break;
    case "jjbamKcmo": GiveKcmo(_owner); break;
    case "jjbamKca": GiveKca(_owner); break;
    case "jjbamTwru": GiveTwru(_owner); break;
    case "jjbamSpg": GiveSpg(_owner); break;
    case "jjbamTwau3000": GiveTwau3000(_owner); break;
    case "jjbamSfg": GiveSfg(_owner); break;
    case "jjbamSfr": GiveSfr(_owner); break;
    case "jjbamKcg": GiveKcg(_owner); break;
    case "jjbamGm": GiveGm(_owner); break;
    case "jjbamTwoh": GiveTWOH(_owner); break;
    case "jjbamTwroh": GiveTwroh(_owner); break;
    case "jjbamTwruoh": GiveTwruoh(_owner); break;
    case "jjbamDw": GiveDw(_owner); break;
    case "jjbamHr": GiveHr(_owner); break;
    case "jjbamHb": GiveHb(_owner); break;
    case "jjbamEp": GiveEP(_owner); break;
    case "jjbamTwf": GiveTWF(_owner); break;
    case "jjbamKcf": GiveKCF(_owner); break;
    case "jjbamHe": GiveHE(_owner); break;
    case "jjbamSpoh": GiveSPOH(_owner); break;
    case "jjbamSproh": GiveSPROH(_owner); break;
    case "jjbamSans": GiveSans(_owner); break;
    case "jjbamGojo": GiveGojo(_owner); break;
    case "jjbamKcau": GiveKCAU(_owner); break;
    case "jjbamSukuna": GiveSukuna(_owner); break;
    case "jjbamKce": GiveKce(_owner); break;
    case "jjsP03": GiveP03(_owner); break;
    case "jjGreenSnake": GiveGreenSnake(_owner); break;
    case "jjBlueSnake": GiveBlueSnake(_owner); break;
    case "jjPurpleSnake": GivePurpleSnake(_owner); break;
    case "jjYellowSnake": GiveYellowSnake(_owner); break;
    case "jjRedSnake": GiveRedSnake(_owner); break;
    case "jjOrangeSnake": GiveOrangeSnake(_owner); break;
    case "jjPinkSnake": GivePinkSnake(_owner); break;
    case "jjbamWsu": GiveWsu(_owner); break;
    case "jjsPs": GivePrisoner(_owner); break;
}

#define LoadStand(_map)

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

// var _sett_map = ds_map_create();

// ModSettingsSubmit(_sett_map);
// ds_map_destroy(_sett_map);


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

if (instance_exists(global.pucciRef))
{
    _map[? "jjsPucciSpawned"] = global.pucciSpawned;
    _map[? "jjsPucciX"] = global.pucciRef.x;
    _map[? "jjsPucciY"] = global.pucciRef.y;
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
_map[? "jjsSettLevelUpSound"] = global.jjsSettLevelUpSound;
_map[? "jjsSettLevelUpParticle"] = global.jjsSettLevelUpParticle;
_map[? "jjsSettCustomModMenuSounds"] = global.jjsSettCustomModMenuSounds;
_map[? "jjsSettDisplayEmptyRunes"] = global.jjsSettDisplayEmptyRunes;

// stand storage
var _ss = array_length(global.jjStandSlots);
for (var i = 0; i < _ss; i++)
{
    // actual data
    var _key = "jjStandSlot" + string(i);
    _map[? _key] = global.jjStandSlots[i];
    // storage display data
    var _nkey = "jjMenuStorageName" + string(i);
    if (global.jjMenuStorageNames[i] == undefined)
    {
        _map[? _nkey] = undefined;
    }
    else
    {
        _map[? _nkey] = string(global.jjMenuStorageNames[i][0]) + "|" + string(global.jjMenuStorageNames[i][1]) + "|" + string(global.jjMenuStorageNames[i][2]);
    }
}

// skills storage
var _sks = array_length(global.jjsStandWorkshopStorage);
for (var i = 0; i < _sks; i++)
{
    var _key = "jjsStandWorkshopStorageSlot" + string(i);
    _map[? _key] = global.jjsStandWorkshopStorage[i];
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

LoadNPCs(_map);

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

if (_map[? "jjsSettLevelUpSound"] != undefined)
{
    global.jjsSettLevelUpSound = _map[? "jjsSettLevelUpSound"];
}
else
{
    global.jjsSettLevelUpSound = true;
}

if (_map[? "jjsSettLevelUpParticle"] != undefined)
{
    global.jjsSettLevelUpParticle = _map[? "jjsSettLevelUpParticle"];
}
else
{
    global.jjsSettLevelUpParticle = true;
}

if (_map[? "jjsSettCustomModMenuSounds"] != undefined)
{
    global.jjsSettCustomModMenuSounds = _map[? "jjsSettCustomModMenuSounds"];
}
else
{
    global.jjsSettCustomModMenuSounds = true;
}

if (_map[? "jjsSettDisplayEmptyRunes"] != undefined)
{
    global.jjsSettDisplayEmptyRunes = _map[? "jjsSettDisplayEmptyRunes"];
}
else
{
    global.jjsSettDisplayEmptyRunes = true;
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
        var _nkey = "jjMenuStorageName" + string(i);
        if (_map[? _nkey] != undefined)
        {
            global.jjMenuStorageNames[i] = string_split(_map[? _nkey], "|");
            if (array_length(global.jjMenuStorageNames[i]) < 3)
            {
                global.jjMenuStorageNames[i] = "???";
            }
        }
    }
    else
    {
        global.jjStandSlots[i] = undefined;
        global.jjMenuStorageNames[i] = undefined;
    }
}

#endregion

#region skills storage

// var _sks = array_length(global.jjsStandWorkshopStorage);
// for (var i = 0; i < _sks; i++)
// {
//     var _key = "jjsStandWorkshopStorageSlot" + string(i);
//     var _loaded_data = _map[? _key];
//     if (_loaded_data != undefined)
//     {
//         global.jjsStandWorkshopStorage[i] = _loaded_data;
//     }
//     else
//     {
//         global.jjsStandWorkshopStorage[i] = undefined;
//     }
// }

#endregion

ds_map_destroy(_map);
