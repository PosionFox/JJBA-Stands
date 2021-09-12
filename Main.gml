
#define TestCommand



#define EventHandler



#define SaveStand(_name)

var _map = ds_map_create();
_map[? "pAbility"] = _name;
ModSaveDataSubmit(_map);
ds_map_destroy(_map);

#define LoadStand

var _map = ModSaveDataFetch();
var _stand = _map[? "pAbility"];

if (_stand != noone)
{
    switch (_stand)
    {
        case "tw": GiveTheWorld(); break;
        case "sp": GiveStarPlatinum(); break;
        case "anubis": GiveAnubis(); break;
        case "d4clt": GiveD4CLT(); break;
        case "twau": GiveTheWorldAU(); break;
        case "stw": GiveShadowTheWorld(); break;
    }
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

#define Main

global.timeIsFrozen = false;

loadSounds();
loadSprites();
loadAttacks();
loadStands();
loadItems();

CommandCreate("stand", true, ScriptWrap(CheatGiveStand), "name");
CommandCreate("testcommand", false, ScriptWrap(TestCommand));

#define OnPlayerDamage(_dodge, _damage)

if (modTypeExists("loveTrain")) {
    objPlayer.hp++;
    if (instance_exists(parEnemy))
    {
        var _t = instance_nearest(objPlayer.x, objPlayer.y, parEnemy);
        _t.hp -= (_t.hpMax * 0.06) + _damage;
        objPlayer.invulFrames = 0;
    }
}

#define OnNewGame

GiveRandomStand();

#define OnRoomLoad



#define OnSave



#define OnLoad

if (instance_exists(objPlayer)) {
    if !("myStand" in objPlayer) {
        objPlayer.myStand = noone;
        LoadStand();
    }
    else
    {
        LoadStand();
    }
    
    //var _s = ModSaveDataFetch();
    //Trace(_s[? "pAbility"]);
}

/* TODO
    
    
    
*/
