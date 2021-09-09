
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
        case "tw":
            GiveTheWorld();
            break;
        case "anubis":
            GiveAnubis();
            break;
    }
}

#define Main

global.timeIsFrozen = false;

loadSounds();
loadSprites();
loadAttacks();
loadStands();
loadItems();

CommandCreate("stand", true, ScriptWrap(CheatGiveStand), "name");
//CommandCreate("timestop", true, ScriptWrap(TestCommand));

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
