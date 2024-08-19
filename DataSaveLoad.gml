
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
}

#define LoadStand(_map)
//  for non rmGame rooms
var _stand = _map[? "jjbamAbility"];
if (_stand != undefined)
{
    DeconstructStandData(_stand);
}

// switch (_stand)
// {
//     case "jjbamD4c":
//         STAND.hasArm = _map[? "jjbamD4cHasArm"];
//         STAND.hasHeart = _map[? "jjbamD4cHasHeart"];
//         STAND.hasEye = _map[? "jjbamD4cHasEye"];
//     break;
//     case "jjbamTsk":
//         STAND.hasAct1 = _map[? "jjbamTuskA1"];
//         STAND.hasAct2 = _map[? "jjbamTuskA2"];
//         STAND.hasAct3 = _map[? "jjbamTuskA3"];
//         STAND.hasAct4 = _map[? "jjbamTuskA4"];
//     break;
// }

#define SaveData

var _map = ds_map_create();

if (instance_exists(player))
{
    if (instance_exists(STAND))
    {
        _map[? "jjbamAbility"] = ConstructStandData(STAND); // save stand
        //Trace("saving stand: " + string(STAND.saveKey));
        // _map[? "jjbamAbilitySkills"] = string(array_clone(objPlayer.myStand.skills)); // save stand skills
        // Trace(_map[? "jjbamAbilitySkills"]);
        
        switch (STAND.saveKey)
        {
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

// mod settings
_map[? "jjAudioVolume"] = global.jjAudioVolume;

// stand slots
for (var i = 0; i < array_length(global.jjStandSlots); i++)
{
    var _key = "jjStandSlot" + string(i);
    _map[? _key] = global.jjStandSlots[i];
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

if (instance_exists(player) and instance_exists(STAND))
{
    LoadRunes(_map);
}

#endregion

#region mod settings

if (_map[? "jjAudioVolume"] != undefined)
{
    global.jjAudioVolume = _map[? "jjAudioVolume"];
}
else
{
    global.jjAudioVolume = 1.0;
}

#endregion

#region stand slots

for (var i = 0; i < array_length(global.jjStandSlots); i++)
{
    var _key = "jjStandSlot" + string(i);
    if (_map[? _key] != undefined)
    {
        global.jjStandSlots[i] = _map[? _key];
    }
    else
    {
        global.jjStandSlots[i] = undefined
    }
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
            case "skMissing": RuneEquip(player, ConstructRuneBase()); break;
            case "skRuneStandMight1": RuneEquip(player, ConstructRuneStandMight1()); break;
            case "skRuneStandMight2": RuneEquip(player, ConstructRuneStandMight2()); break;
            case "skRuneStandMight3": RuneEquip(player, ConstructRuneStandMight3()); break;
            case "skRuneStandMight4": RuneEquip(player, ConstructRuneStandMight4()); break;
            case "skRuneStandMight5": RuneEquip(player, ConstructRuneStandMight5()); break;
            case "skRuneStandMight6": RuneEquip(player, ConstructRuneStandMight6()); break;
            case "skRuneStandMight7": RuneEquip(player, ConstructRuneStandMight7()); break;
            case "skRuneStandMight8": RuneEquip(player, ConstructRuneStandMight8()); break;
            
            case "skRuneReach1": RuneEquip(player, ConstructRuneReach1()); break;
            case "skRuneReach2": RuneEquip(player, ConstructRuneReach2()); break;
            case "skRuneReach3": RuneEquip(player, ConstructRuneReach3()); break;
            case "skRuneReach4": RuneEquip(player, ConstructRuneReach4()); break;
            case "skRuneReach5": RuneEquip(player, ConstructRuneReach5()); break;
            case "skRuneReach6": RuneEquip(player, ConstructRuneReach6()); break;
            case "skRuneReach7": RuneEquip(player, ConstructRuneReach7()); break;
            case "skRuneReach8": RuneEquip(player, ConstructRuneReach8()); break;
            
            case "skRuneMending1": RuneEquip(player, ConstructRuneMending1()); break;
            case "skRuneMending2": RuneEquip(player, ConstructRuneMending2()); break;
            case "skRuneMending3": RuneEquip(player, ConstructRuneMending3()); break;
            case "skRuneMending4": RuneEquip(player, ConstructRuneMending4()); break;
            case "skRuneMending5": RuneEquip(player, ConstructRuneMending5()); break;
            case "skRuneMending6": RuneEquip(player, ConstructRuneMending6()); break;
            case "skRuneMending7": RuneEquip(player, ConstructRuneMending7()); break;
            case "skRuneMending8": RuneEquip(player, ConstructRuneMending8()); break;
            
            case "skRuneEnergize1": RuneEquip(player, ConstructRuneEnergize1()); break;
            case "skRuneEnergize2": RuneEquip(player, ConstructRuneEnergize2()); break;
            case "skRuneEnergize3": RuneEquip(player, ConstructRuneEnergize3()); break;
            case "skRuneEnergize4": RuneEquip(player, ConstructRuneEnergize4()); break;
            case "skRuneEnergize5": RuneEquip(player, ConstructRuneEnergize5()); break;
            case "skRuneEnergize6": RuneEquip(player, ConstructRuneEnergize6()); break;
            case "skRuneEnergize7": RuneEquip(player, ConstructRuneEnergize7()); break;
            case "skRuneEnergize8": RuneEquip(player, ConstructRuneEnergize8()); break;
            
            case "skRuneBriefRaspite": RuneEquip(player, ConstructRuneBriefRaspite()); break;
            default: RuneEquip(player, ConstructRuneBase()); break;
        }
    }
}
