
CommandCreate("jjbamStand", true, ScriptWrap(CheatGiveStand), "name");
CommandCreate("jjbamTest", false, ScriptWrap(TestCommand));
CommandCreate("jjbamDebug", true, ScriptWrap(JjbamDebug));

CommandCreate("jjbamSpawnPucci", true, ScriptWrap(jjbamSpawnPucci));
CommandCreate("jjbamPucciCheck", true, ScriptWrap(jjbamPucciCheck));
CommandCreate("jjbamKillPucci", true, ScriptWrap(jjbamKillPucci));
CommandCreate("jjbamKillNPCs", true, ScriptWrap(jjbamKillNPCs));

CommandCreate("jjVarSpy", true, ScriptWrap(JjVarSpy), "obj");



#define CheatGiveStand(args)

with (objPlayer)
{
    if (instance_exists(myStand))
    {
        instance_destroy(myStand);
        myStand = noone;
    }
}
switch (args[0])
{
    // p3
    case "sp": GiveStarPlatinum(player); break;
    case "sc": GiveSilverChariot(player); break;
    case "tw": GiveTheWorld(player); break;
    case "anubis": GiveAnubis(player); break;
    case "stw": GiveShadowTheWorld(player); break;
    // p4
    case "sptw": GiveSPTW(player); break;
    case "kq": GiveKillerQueen(player); break;
    case "kqbtd": GiveKillerQueenBtD(player); break;
    // p5
    case "sf": GiveStickyFingers(player); break;
    case "ge": GiveGoldExperience(player); break;
    case "kc": GiveKingCrimson(player); break;
    // p6
    case "ws": GiveWhiteSnake(player); break;
    case "cm": GiveCMoon(player); break;
    // p7
    case "spn": GiveSpin(player); break;
    case "d4c": GiveD4C(player); break;
    case "d4clt": GiveD4CLT(player); break;
    case "twau": GiveTheWorldAU(player); break;
    case "tusk": GiveTusk(player); break;
    case "tusk4": GiveTusk4(); break;
    // alts
    case "sw": GiveSpookyWorld(player); break;
    case "spr": GiveSpr(player); break;
    case "twr": GiveTwr(player); break;
    case "spova": GiveSpova(player); break;
    case "twova": GiveTwova(player); break;
    case "shadow": GiveShadow(player); break;
    case "kcm": GiveKcm(player); break;
    // other
    case "sus": GiveImposter(player); break;
    
    default: Trace("not found");
}

#define TestCommand

Trace(STAND.saveKey);

#define JjVarSpy(args)

var _obj = asset_get_index(args[0]);

var _list = ds_list_create();
variable_instance_get_names(_obj, _list);
for (var i = 0, n = ds_list_size(_list); i < n; i++)
{
    Trace(_list[| i]);
}
ds_list_destroy(_list);

#define JjbamDebug

if (!modTypeExists("jjbamDebug"))
{
    var _o = ModObjectSpawnPersistent(0, 0, 0);
    with (_o)
    {
        type = "jjbamDebug";
        InstanceAssignMethod(self, "draw", ScriptWrap(JjbamDebugDraw), false);
    }
}
else
{
    var _o = modTypeFind("jjbamDebug");
    instance_destroy(_o);
}
var _o = instance_position(mouse_x, mouse_y, all);
if (_o)
{
    Trace(object_get_name(_o.object_index));
}

#define JjbamDebugDraw

draw_set_color(c_gray);
for (var v = 0; v < room_width; v += 16)
{
    draw_line(v, 0, v, room_height);
}
for (var h = h; h < room_height; h += 16)
{
    draw_line(0, h, room_width, h);
}
draw_set_color(c_white);
with (all)
{
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
    draw_circle(x, y, 1, false);
}

#define jjbamSpawnPucci

SpawnPucci(room_width / 2, room_height / 2);

#define jjbamPucciCheck

Trace(global.pucciRef.type);

#define jjbamKillPucci

DespawnPucci();

#define jjbamKillNPCs

instance_destroy(MNPC);

