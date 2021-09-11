enum StandState {
    Idle,
    SkillA,
    SkillB,
    SkillC,
    SkillD,
    LEN
}
enum StandStat {
    Range,
    AttackDamage,
    AttackRange,
    BaseSpd,
    LEN
}
enum StandSkill {
    Skill,
    Key,
    Icon,
    Damage,
    MaxCooldown,
    Cooldown,
    MaxExecutionTime,
    ExecutionTime,
    LEN
}

#define StandSkillDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height();

//draw_text(128, 128, "asd");
draw_text(168, _height - 160, string_lower(name));
for (var i = 1; i <= 4; i++) {
    var xx = (64 * i);
    draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, _height - 96, 2, 2, 0, c_white, 1);
    draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
    if (skills[i, StandSkill.Cooldown] > 0) {
        var cyy = (skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown]) * 2;
        draw_sprite_ext(global.sprSkillCooldown, 0, xx, _height - 96, 2, cyy, 0, c_white, 0.8);
        draw_text(xx + 8, _height - 64, string(skills[i, StandSkill.Cooldown]));
    }
}

#define StandSkillManage

if (active) {
    for (var i = 1; i < StandState.LEN; i++)
    {
        if (keyboard_check_pressed(ord(skills[i, StandSkill.Key])))
        {
            if (skills[i, StandSkill.Cooldown] <= 0 and state == StandState.Idle)
            {
                state = i;
            }
        }
    }
    if (state != StandState.Idle)
    {
        for (var i = 1; i < StandState.LEN; i++)
        {
            if (state == i)
            {
                script_execute(skills[i, StandSkill.Skill], state, undefined);
                if (skills[i, StandSkill.ExecutionTime] >= skills[i, StandSkill.MaxExecutionTime]) {
                    FireCD(i)
                    state = StandState.Idle;
                }
            }
        }
    }
}

for (var i = 4; i > 0; i--) {
    if (skills[i, StandSkill.Cooldown] > 0) {
        skills[i, StandSkill.Cooldown] -= 1 / room_speed;
    }
}

#define StandDefaultStep

depth = -y;

if (keyboard_check_pressed(ord("Q"))) {
    active = !active;
    if (active)
    {
        audio_play_sound(global.sndSpSummon, 0, false);
    }
}

x = lerp(x, xTo, spd);
y = lerp(y, yTo, spd);

if (active)
{
    if (state == StandState.Idle)
    {
        var xPos = mouse_x > owner.x ? 1 : -1;
        image_xscale = xPos;
        image_alpha = lerp(image_alpha, 1, 0.1);
        xTo = owner.x - (xPos * 8);
        yTo = owner.y - 8;
        y += sin(current_time / 1000);
    }
}
else
{
    image_alpha = lerp(image_alpha, 0, 0.2);
    xTo = owner.x;
    yTo = owner.y;
}

StandSkillManage();

#region Star Platinum

#define StarPlatinumStep



#define GiveStarPlatinum

var _name = "Star Platinum";
var _sprite = global.sprStarPlatinum;
var _punchSprite = global.sprStarPlatinumPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5.5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrageSp;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunchSp;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSp;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("sp");

#endregion

#region The World

#define TheWorldStep



#define GiveTheWorld

var _name = "The World";
var _sprite = global.sprTheWorld;
var _punchSprite = global.sprTheWorldPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTw;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("tw");

#endregion

#define AnubisStep



#define GiveAnubis

var _name = "Anubis";
var _sprite = global.sprAnubis;
var _punchSprite = global.sprTheWorldPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 8;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.9;

var _skills = StandSkillInit(_stats);

var sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = HorizontalSlash;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

#define GiveD4C

var _name = "D4C";
var _sprite = global.sprD4C;
var _punchSprite = global.sprTheWorldPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4.8;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.4;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = LoveTrain;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("bunny");

#define GiveTheWorldAU

var _name = "The World AU";
var _sprite = global.sprTheWorldAU;
var _punchSprite = global.sprTheWorldPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4.0;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = KnifeBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = GunShot;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTwAu;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 45;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("twau");

#define GiveShadowTheWorld

var _name = "Shadow The World";
var _sprite = global.sprShadowTheWorld;
var _punchSprite = global.sprStwPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = ComboDash;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeCoffin;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BackDashKnife;
_skills[sk, StandSkill.Icon] = global.sprSkillBackDashKnife;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TripleCombo;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleCombo;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSTW;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopStw;
_skills[sk, StandSkill.MaxCooldown] = 12;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("stw");

#define StandSkillInit(_stats)

var _arr;
var _s;

_s = StandState.SkillA;
_arr[_s, StandSkill.Skill] = EventHandler;
_arr[_s, StandSkill.Key] = "R";
_arr[_s, StandSkill.Icon] = global.sprSkillTemplate;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillB;
_arr[_s, StandSkill.Skill] = EventHandler;
_arr[_s, StandSkill.Key] = "F";
_arr[_s, StandSkill.Icon] = global.sprSkillTemplate;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillC;
_arr[_s, StandSkill.Skill] = EventHandler;
_arr[_s, StandSkill.Key] = "C";
_arr[_s, StandSkill.Icon] = global.sprSkillTemplate;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillD;
_arr[_s, StandSkill.Skill] = EventHandler;
_arr[_s, StandSkill.Key] = "G";
_arr[_s, StandSkill.Icon] = global.sprSkillTemplate;
_arr[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_arr[_s, StandSkill.MaxCooldown] = 1;
_arr[_s, StandSkill.Cooldown] = 0;
_arr[_s, StandSkill.MaxExecutionTime] = 0;
_arr[_s, StandSkill.ExecutionTime] = 0;

return _arr;

#define StandBuilder(name, sprite, stats, skills, punchSprite)

// init
objPlayer.myStand = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
objPlayer.myStand.type = "stand";
objPlayer.myStand.name = name;
objPlayer.myStand.sprite_index = sprite;
objPlayer.myStand.punchSprite = punchSprite;
objPlayer.myStand.attackState = 0;
objPlayer.myStand.attackStateTimer = 0;
// state
objPlayer.myStand.active = false;
objPlayer.myStand.state = StandState.Idle;
objPlayer.myStand.owner = objPlayer;
objPlayer.myStand.target = noone;
// position
objPlayer.myStand.xTo = objPlayer.x;
objPlayer.myStand.yTo = objPlayer.y;
// stats
objPlayer.myStand.stats = array_clone(stats);
objPlayer.myStand.spd = objPlayer.myStand.stats[StandStat.BaseSpd];
// skills
objPlayer.myStand.skills = array_clone(skills);

InstanceAssignMethod(objPlayer.myStand, "step", ScriptWrap(StandDefaultStep), false);
InstanceAssignMethod(objPlayer.myStand, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);

#define CheatGiveStand(args)

with (objPlayer) {
    if (instance_exists(myStand)) {
        instance_destroy(myStand);
        myStand = noone;
    }
}
switch (args[0]) {
    case "starplatinum": GiveStarPlatinum(); break;
    case "theworld": GiveTheWorld(); break;
    case "anubis": GiveAnubis(); break;
    case "d4c": GiveD4C(); break;
    case "twau": GiveTheWorldAU(); break;
    case "stw": GiveShadowTheWorld(); break;
}
