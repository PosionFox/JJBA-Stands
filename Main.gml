
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
        case "bunny": GiveD4C(); break;
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
