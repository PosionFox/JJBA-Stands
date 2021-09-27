
#define TestCommand



#define JjbamDebug

if (!modTypeExists("jjbamDebug"))
{
    var _o = ModObjectSpawnPersistent(0, 0, 0);
    with (_o)
    {
        InstanceAssignMethod(self, "draw", ScriptWrap(JjbamDebugDraw), false);
    }
}
else
{
    var _o = modTypeFind("jjbamDebug");
    instance_destroy(_o);
}

#define JjbamDebugDraw

with (all)
{
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    draw_circle(x, y, 1, false);
}

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
        case "kq": GiveKillerQueen(); break;
        case "kqbtd": GiveKillerQueenBtD(); break;
        
        case "jjbamTw": GiveTheWorld(); break;
        case "jjbamSp": GiveStarPlatinum(); break;
        case "jjbamAnubis": GiveAnubis(); break;
        case "jjbamD4clt": GiveD4CLT(); break;
        case "jjbamTwau": GiveTheWorldAU(); break;
        case "jjbamStw": GiveShadowTheWorld(); break;
        case "jjbamKq": GiveKillerQueen(); break;
        case "jjbamKqbtd": GiveKillerQueenBtD(); break;
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

#define Main

global.timeIsFrozen = false;

loadSounds();
loadSprites();
loadEffects();
loadAttacks();
loadStands();
loadItems();

CommandCreate("stand", true, ScriptWrap(CheatGiveStand), "name");
CommandCreate("testcommand", false, ScriptWrap(TestCommand));
CommandCreate("jjbamDebug", true, ScriptWrap(JjbamDebug));

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
