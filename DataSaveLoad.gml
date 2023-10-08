
#define LoadStand(_map)
//  for non rmGame rooms
var _stand = _map[? "jjbamAbility"];

switch (_stand)
{
    // p3
    case "jjbamTw": GiveTheWorld(player); break;
    case "jjbamSpp": GiveSpp(player); break;
    case "jjbamSp":
        GiveStarPlatinum(player);
        var _xp = _map[? "jjbamSpXp"];
        if (_xp == undefined)
        {
            STAND.xp = 0;
        }
        else
        {
            STAND.xp = _xp;
        }
    break;
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
    case "jjbamGer": GiveGer(player); break;
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
    // p8
    case "jjbamSnw": GiveSoftAndWet(player); break;
    // other
    case "jjbamSw": GiveSpookyWorld(player); break;
    case "jjbamSus": GiveImposter(player); break;
    case "jjbamSpr": GiveSpr(player); break;
    case "jjbamTwr": GiveTwr(player); break;
    case "jjbamSpova": GiveSpova(player); break;
    case "jjbamTwova": GiveTwova(player); break;
    case "jjbamShadow":
        GiveShadow(player);
        var _xp = _map[? "jjbamShadowXp"];
        if (_xp == undefined)
        {
            STAND.xp = 0;
        }
        else
        {
            STAND.xp = _xp;
        }
    break;
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
}

#define SaveData

var _map = ds_map_create();

if (instance_exists(player))
{
    if (instance_exists(STAND))
    {
        _map[? "jjbamAbility"] = STAND.saveKey; // save stand
        //Trace("saving stand: " + string(STAND.saveKey));
        // _map[? "jjbamAbilitySkills"] = string(array_clone(objPlayer.myStand.skills)); // save stand skills
        // Trace(_map[? "jjbamAbilitySkills"]);
        
        switch (STAND.saveKey)
        {
            case "jjbamStw": // save stw xp
                _map[? "jjbamStwXp"] = STAND.xp;
            break;
            case "jjbamSp":
                _map[? "jjbamSpXp"] = STAND.xp;
            break;
            case "jjbamShadow":
                _map[? "jjbamShadowXp"] = STAND.xp;
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
    _map[? "jjSummonKeybind"] = player.summonKeybind;
    _map[? "jjAbilityKeybind1"] = player.abilityKeybind1;
    _map[? "jjAbilityKeybind2"] = player.abilityKeybind2;
    _map[? "jjAbilityKeybind3"] = player.abilityKeybind3;
    _map[? "jjAbilityKeybind4"] = player.abilityKeybind4;
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
if (instance_exists(player) and instance_exists(STAND))
{
    if (STAND.runes[0] != noone) _map[? "jjRune0"] = STAND.runes[0].save_key;
    if (STAND.runes[1] != noone) _map[? "jjRune1"] = STAND.runes[1].save_key;
    if (STAND.runes[2] != noone) _map[? "jjRune2"] = STAND.runes[2].save_key;
}

ModSaveDataSubmit(_map);
ds_map_destroy(_map);


#define LoadData

var _map = ModSaveDataFetch();

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

if (instance_exists(player) and instance_exists(STAND))
{
    LoadRunes(_map);
}

#endregion

ds_map_destroy(_map);

#define LoadRunes(_map)

var _rune_keys = [noone, noone, noone];
if ds_map_exists(_map, "jjRune0") _rune_keys[0] = _map[? "jjRune0"];
if ds_map_exists(_map, "jjRune1") _rune_keys[1] = _map[? "jjRune1"];
if ds_map_exists(_map, "jjRune2") _rune_keys[2] = _map[? "jjRune2"];

var _len = array_length(_rune_keys);
for (var i = 0; i < _len; i++)
{
    if (_rune_keys[i] != noone)
    {
        switch (_rune_keys[i])
        {
            case "skMissing":
                RuneEquip(player, ConstructRuneBase());
            break;
            case "skRuneStandMight":
                RuneEquip(player, ConstructRuneStandMight());
            break;
            case "skRuneBriefRaspite":
                RuneEquip(player, ConstructRuneBriefRaspite());
            break;
            default:
                RuneEquip(player, ConstructRuneBase());
            break;
        }
    }
}
