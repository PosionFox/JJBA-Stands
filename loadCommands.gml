
#define CheatGiveStand(args)

with (objPlayer) {
    if (instance_exists(myStand)) {
        instance_destroy(myStand);
        myStand = noone;
    }
}
switch (args[0]) {
    case "sp": GiveStarPlatinum(); break;
    case "sc": GiveSilverChariot(); break;
    case "sptw": GiveSPTW(); break;
    case "tw": GiveTheWorld(); break;
    case "anubis": GiveAnubis(); break;
    case "d4c": GiveD4C(); break;
    case "d4clt": GiveD4CLT(); break;
    case "twau": GiveTheWorldAU(); break;
    case "stw": GiveShadowTheWorld(); break;
    case "kq": GiveKillerQueen(); break;
    case "kqbtd": GiveKillerQueenBtD(); break;
    case "sf": GiveStickyFingers(); break;
    case "ge": GiveGoldExperience(); break;
    case "ws": GiveWhiteSnake(); break;
    case "cm": GiveCMoon(); break;
}

#define TestCommand

Trace("hello");

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




