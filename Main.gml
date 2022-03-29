
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
    if ("skCustomStands" in objPlayer)
    {
        _map[? "jjbamCustomStands"] = objPlayer.skCustomStands;
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
}

// Trace(_map[? "jjbamAbilitySkills"]);
// if (_map[? "jjbamAbilitySkills"] != undefined)
// {
//     objPlayer.myStand.skills = array_clone(json_decode(_map[? "jjbamAbilitySkills"])); // load skills
// }

if (_custom == true)
{
    //Trace("custom is: " + string(_custom));
    if (instance_exists(objPlayer))
    {
        if ("skCustomStands" in objPlayer)
        {
            global.hasCustomStands = true;
            StructureEdit(global.jjbamStandWorkshop, StructureData.Unlocked, true);
        }
    }
}
else
{
    //Trace("custom is: " + string(_custom));
    if (instance_exists(objPlayer))
    {
        if ("skCustomStands" in objPlayer)
        {
            objPlayer.skCustomStands = false;
        }
    }
}

#define InitPlayerVariables

if (instance_exists(objPlayer))
{
    if !("myStand" in objPlayer)
    {
        objPlayer.myStand = noone;
    }
    if !("skCustomStands" in objPlayer)
    {
        objPlayer.skCustomStands = false;
    }
}

#define newClass(class)

return array_clone(class);

#define Main

global.timeIsFrozen = false;

loadSprites();
loadSounds();
// loadStands();
loadItems();
loadStructures();
loadCommands();

#define OnPlayerDamage(_dodge, _damage)

if (modTypeExists("loveTrain"))
{
    objPlayer.hp += _damage;
    if (instance_exists(parEnemy))
    {
        var _t = instance_nearest(objPlayer.x, objPlayer.y, parEnemy);
        _t.hp -= (_t.hpMax * 0.06) + _damage;
        objPlayer.invulFrames = 0;
        LTPunishEffect(_t.x, _t.y);
        audio_play_sound(global.sndLtPunish, 5, false);
    }
}
if (modSubtypeExists("geFrog"))
{
    objPlayer.hp += _damage;
    if (instance_exists(parEnemy))
    {
        var _t = instance_nearest(objPlayer.x, objPlayer.y, parEnemy);
        _t.hp -= _damage;
        objPlayer.invulFrames = 0;
    }
}

#define OnMobDeath(_mob)

if (instance_exists(player))
{
    if ("myStand" in player)
    {
        switch (STAND.name)
        {
            case "Shadow The World":
                if (STAND.xp < STAND.maxXp)
                {
                    STAND.xp += _mob.hpMax;
                }
            break;
            case "Tusk":
                STAND.act4Meter += _mob.hpMax * 0.25;
            break;
        }
    }
}

#define OnStructureInteract(type, structure, inst)

if (structure == global.jjbamStandWorkshop)
{
    if ("myStand" in objPlayer)
    {
        if (instance_exists(objPlayer))
        {
            OpenStandWorkshop();
        }
    }
}

#define OnDig(_x, _y)

if (_x >= 968 and _y <= 1144 and _y >= 200)
{
    if (place_meeting(_x, _y, objDigSpot))
    {
        if (random(1) < 0.25)
        {
            var _pool = [
                global.jjbamHeart,
                global.jjbamEye
            ]
            
            var _item = irandom(array_length(_pool) - 1);
            DropItem(_x, _y, _pool[_item], 1);
        }
    }
}

#define OnNewGame

InitPlayerVariables();
GiveRandomStand();

#define OnRoomLoad

if (room == rmSkillGrid)
{
    //SkillStandWorkshop();
}

#define OnSave

SaveData();

#define OnLoad

InitPlayerVariables();
LoadData();





