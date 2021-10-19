
#define EventHandler



#define SaveStand(_name)

var _map = ds_map_create();
_map[? "jjbamAbility"] = _name;
if (instance_exists(objPlayer))
{
    if ("myStand" in objPlayer)
    {
        if (instance_exists(objPlayer.myStand))
        {
            switch (objPlayer.myStand.name)
            {
                case "Shadow The World":
                    _map[? "jjbamStwXp"] = objPlayer.myStand.xp;
                break;
            }
        }
    }
}
ModSaveDataSubmit(_map);
ds_map_destroy(_map);

#define LoadStand

var _map = ModSaveDataFetch();
var _standCompatibility = _map[? "pAbility"];
var _stand = _map[? "jjbamAbility"];

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


#define modTypeExists(_type)

var _exists = false;
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == _type)
        {
            _exists = true;
        }
    }
}
return _exists;

#define modTypeFind(_type)

with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == _type)
        {
            return self;
        }
    }
}

#define modTypeCount(_type)

var _count = 0;
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == _type)
        {
            _count++;
        }
    }
}
return _count;

#define modSubtypeExists(_type)

var _exists = false;
with (objModEmpty)
{
    if ("subtype" in self)
    {
        if (subtype == _type)
        {
            _exists = true;
        }
    }
}
return _exists;

#define modSubtypeFind(_type)

with (objModEmpty)
{
    if ("subtype" in self)
    {
        if (subtype == _type)
        {
            return self;
        }
    }
}
return noone;

#define Main

global.timeIsFrozen = false;

loadSounds();
loadSprites();
loadEffects();
loadAttacks();
loadStandsCore();
loadActors();
loadStands();
loadItems();
loadCommands();

CommandCreate("jjbamStand", true, ScriptWrap(CheatGiveStand), "name");
CommandCreate("jjbamTest", false, ScriptWrap(TestCommand));
CommandCreate("jjbamDebug", true, ScriptWrap(JjbamDebug));

#define OnPlayerDamage(_dodge, _damage)

if (modTypeExists("loveTrain"))
{
    objPlayer.hp++;
    if (instance_exists(parEnemy))
    {
        var _t = instance_nearest(objPlayer.x, objPlayer.y, parEnemy);
        _t.hp -= (_t.hpMax * 0.06) + _damage;
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

#define OnNewGame

if (instance_exists(objPlayer))
{
    if !("myStand" in objPlayer)
    {
        objPlayer.myStand = noone;
    }
}
GiveRandomStand();

#define OnRoomLoad

if (instance_exists(objPlayer))
{
    if ("myStand" in objPlayer)
    {
        LoadStand();
    }
}

#define OnSave

if (instance_exists(objPlayer))
{
    if ("myStand" in objPlayer)
    {
        if (instance_exists(objPlayer.myStand))
        {
            SaveStand(objPlayer.myStand.saveKey);
        }
        else
        {
            SaveStand("jjbamStandless");
        }
    }
}

#define OnLoad

if (instance_exists(objPlayer))
{
    if !("myStand" in objPlayer)
    {
        objPlayer.myStand = noone;
        LoadStand();
    }
    else
    {
        LoadStand();
    }
}

/* TODO
    
    
    
*/
