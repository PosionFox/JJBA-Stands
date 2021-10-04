
#define CheatGiveStand(args)

with (objPlayer) {
    if (instance_exists(myStand)) {
        instance_destroy(myStand);
        myStand = noone;
    }
}
switch (args[0]) {
    case "sp": GiveStarPlatinum(); break;
    case "tw": GiveTheWorld(); break;
    case "anubis": GiveAnubis(); break;
    case "d4clt": GiveD4CLT(); break;
    case "twau": GiveTheWorldAU(); break;
    case "stw": GiveShadowTheWorld(); break;
    case "kq": GiveKillerQueen(); break;
    case "kqbtd": GiveKillerQueenBtD(); break;
    case "sf": GiveStickyFingers(); break;
}

#define TestCommand

GiveRandomStand();

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
