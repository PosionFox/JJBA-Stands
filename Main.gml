
#define EventHandler



#define SaveData

var _map = ds_map_create();

if (instance_exists(objPlayer))
{
    if ("myStand" in objPlayer)
    {
        if (instance_exists(objPlayer.myStand))
        {
            _map[? "jjbamAbility"] = objPlayer.myStand.saveKey;
            switch (objPlayer.myStand.name)
            {
                case "Shadow The World":
                    _map[? "jjbamStwXp"] = objPlayer.myStand.xp;
                break;
            }
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
    case "jjbamTw": GiveTheWorld(); break;
    case "jjbamSp": GiveStarPlatinum(); break;
    case "jjbamAnubis": GiveAnubis(); break;
    case "jjbamD4c": GiveD4C(); break;
    case "jjbamD4clt": GiveD4CLT(); break;
    case "jjbamTwau": GiveTheWorldAU(); break;
    case "jjbamStw":
        GiveShadowTheWorld();
        var _xp = _map[? "jjbamStwXp"];
        if (_xp == undefined)
        {
            objPlayer.myStand.xp = 0;
        }
        else
        {
            objPlayer.myStand.xp = _xp;
        }
    break;
    case "jjbamKq": GiveKillerQueen(); break;
    case "jjbamKqbtd": GiveKillerQueenBtD(); break;
    case "jjbamSw": GiveSpookyWorld(); break;
    case "jjbamSf": GiveStickyFingers(); break;
    case "jjbamGe": GiveGoldExperience(); break;
}

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

#define Main

global.timeIsFrozen = false;

loadUtils();
loadSounds();
loadSprites();
loadEffects();
loadAttacks();
loadStandsCore();
loadActors();
loadStands();
loadItems();
loadStructures();
loadCommands();

CommandCreate("jjbamStand", true, ScriptWrap(CheatGiveStand), "name");
CommandCreate("jjbamTest", false, ScriptWrap(TestCommand));
CommandCreate("jjbamDebug", true, ScriptWrap(JjbamDebug));

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

if (instance_exists(objPlayer))
{
    if ("myStand" in objPlayer)
    {
        switch (objPlayer.myStand.name)
        {
            case "Shadow The World":
                if (objPlayer.myStand.xp < objPlayer.myStand.maxXp)
                {
                    objPlayer.myStand.xp += _mob.hpMax;
                }
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





