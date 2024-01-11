
CommandCreate("jjStand", true, ScriptWrap(jjCheatGiveStand), "name");
CommandCreate("jjTest", false, ScriptWrap(jjTestCommand));
CommandCreate("jjDebug", true, ScriptWrap(jjbamDebug));

CommandCreate("jjSpawnPucci", true, ScriptWrap(jjbamSpawnPucci));
CommandCreate("jjPucciCheck", true, ScriptWrap(jjbamPucciCheck));
CommandCreate("jjKillPucci", true, ScriptWrap(jjbamKillPucci));
CommandCreate("jjKillNPCs", true, ScriptWrap(jjbamKillNPCs));

CommandCreate("jjVarSpy", true, ScriptWrap(jjVarSpy), "obj");

CommandCreate("jjRemapKeybind", false, ScriptWrap(jjRemapKeybind), "summon/ability", "key");

CommandCreate("jjMaxExp", true, ScriptWrap(jjMaxExp))

CommandCreate("jjSpawnDio", true, ScriptWrap(jjSpawnDio))

CommandCreate("jjCheckGrimoires", false, ScriptWrap(jjCheckGrimoires));

CommandCreate("jjSpawnShards", true, ScriptWrap(jjSpawnShards));

CommandCreate("jjCheckMonth", false, ScriptWrap(jjCheckMonth));

CommandCreate("jjTrait", true, ScriptWrap(jjTrait), "trait");

CommandCreate("jjPrintVersion", false, ScriptWrap(jjPrintVersion))

#define jjPrintVersion

printVersion();

#define jjTrait(args)

trait_set_by_key(player, args[0]);

#define jjCheckMonth

Trace(current_month);

#define jjSpawnShards

repeat (100)
{
    var _pool =
    [
        [global.jjCommonShard, 128],
        [global.jjUncommonShard, 64],
        [global.jjRareShard, 32],
        [global.jjEpicShard, 16],
        [global.jjLegendaryShard, 8],
        [global.jjMythicalShard, 4],
        [global.jjAscendedShard, 2],
        [global.jjUltimateShard, 1],
    ]
    var _shard = random_weight(_pool);
    DropItem(player.x, player.y, _shard, 1);
}

#define jjCheckGrimoires

var _result = ModFind("Grimoires");
if (_result == -1)
{
    Trace("grimoires is not installed");
}
else
{
    Trace("grimoires is installed");
}

#define jjSpawnDio

var _d = EnemyDioSpawn();
_d.sun_immunity = true;

#define jjMaxExp

if (instance_exists(STAND) and bool("xp" in STAND))
{
    STAND.xp += 100000000;
}

#define jjRemapKeybind(args)

var _key = string_upper(args[1]);

switch (args[0])
{
    case "summon":
        player.summonKeybind = _key;
    break;
    case "ability1":
        player.abilityKeybind1 = _key;
        STAND.skills[StandState.SkillAOff, StandSkill.Key] = _key;
        STAND.skills[StandState.SkillA, StandSkill.Key] = _key;
    break;
    case "ability2":
        player.abilityKeybind2 = _key;
        STAND.skills[StandState.SkillBOff, StandSkill.Key] = _key;
        STAND.skills[StandState.SkillB, StandSkill.Key] = _key;
    break;
    case "ability3":
        player.abilityKeybind3 = _key;
        STAND.skills[StandState.SkillCOff, StandSkill.Key] = _key;
        STAND.skills[StandState.SkillC, StandSkill.Key] = _key;
    break;
    case "ability4":
        player.abilityKeybind4 = _key;
        STAND.skills[StandState.SkillDOff, StandSkill.Key] = _key;
        STAND.skills[StandState.SkillD, StandSkill.Key] = _key;
    break;
}

#define jjCheatGiveStand(args)

RemoveStand(player);

switch (args[0])
{
    // p3
    case "sp": GiveStarPlatinum(player); break;
    case "sc": GiveSilverChariot(player); break;
    case "tw": GiveTheWorld(player); break;
    case "anubis": GiveAnubis(player); break;
    case "stw": GiveShadowTheWorld(player); break;
    case "spp": GiveSpp(player); break;
    case "mr": GiveMagiciansRed(player); break;
    case "hg": GiveHierophantGreen(player); break;
    // p4
    case "sptw": GiveSPTW(player); break;
    case "kq": GiveKillerQueen(player); break;
    case "kqbtd": GiveKillerQueenBtD(player); break;
    case "hd": GiveHeavensDoor(player); break;
    // p5
    case "sf": GiveStickyFingers(player); break;
    case "ge": GiveGoldExperience(player); break;
    case "ger": GiveGer(player); break;
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
    //p8
    case "snw": GiveSoftAndWet(player); break;
    // alts
    case "sw": GiveSpookyWorld(player); break;
    case "spr": GiveSpr(player); break;
    case "twr": GiveTwr(player); break;
    case "spova": GiveSpova(player); break;
    case "twova": GiveTwova(player); break;
    case "shadow": GiveShadow(player); break;
    case "kcm": GiveKcm(player); break;
    case "sqbtd": GiveSQBTD(player); break;
    case "scova": GiveScova(player); break;
    case "neo": GiveNeo(player); break;
    case "te": GiveTe(player); break;
    case "bs": GiveBs(player); break;
    case "snwg": GiveSnwg(player); break;
    case "pd4c": GivePd4c(player); break;
    case "pd4clt": GivePd4clt(player); break;
    case "eg": GiveEg(player); break;
    case "twgh": GiveTwgh(player); break;
    case "twg": GiveTwg(player); break;
    case "kcmo": GiveKcmo(player); break;
    case "kca": GiveKca(player); break;
    case "twru": GiveTwru(player); break;
    case "spg": GiveSpg(player); break;
    case "twau3000": GiveTwau3000(player); break;
    case "sfg": GiveSfg(player); break;
    case "sfr": GiveSfr(player); break;
    case "kcg": GiveKcg(player); break;
    case "gm": GiveGm(player); break;
    case "twroh": GiveTwroh(player); break;
    case "dw": GiveDw(player); break;
    case "twruoh": GiveTwruoh(player); break;
    case "hr": GiveHr(player); break;
    case "hb": GiveHb(player); break;
    case "ep": GiveEP(player); break;
    case "twf": GiveTWF(player); break;
    case "kcf": GiveKCF(player); break;
    case "he": GiveHE(player); break;
    case "spoh": GiveSPOH(player); break;
    case "sproh": GiveSPROH(player); break;
    // other
    // other
    case "sus": GiveImposter(player); break;
    case "twoh": GiveTWOH(player); break;
    
    default: Trace("not found");
}

#define jjTestCommand

Trace(display_get_gui_width());
Trace(display_get_gui_height());

#define jjVarSpy(args)

var _obj = asset_get_index(args[0]);

var _list = ds_list_create();
variable_instance_get_names(_obj, _list);
for (var i = 0, n = ds_list_size(_list); i < n; i++)
{
    Trace(_list[| i]);
}
ds_list_destroy(_list);

#define jjbamDebug

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

#define jjbamDebugDraw

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

