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
            if (skills[i, StandSkill.Cooldown] <= 0)
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
                    skills[i, StandSkill.Cooldown] = 0;
                    skills[i, StandSkill.ExecutionTime] = 0;
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

if (keyboard_check_pressed(ord("Q"))) {
    active = !active;
}

x = lerp(x, xTo, spd);
y = lerp(y, yTo, spd);

if (active) {
    switch (state) {
        case StandState.Idle:
            var xPos = mouse_x > owner.x ? 1 : -1;
            image_xscale = xPos;
            image_alpha = lerp(image_alpha, 1, 0.1);
            xTo = owner.x - (xPos * 8);
            yTo = owner.y - 8;
            y += sin(current_time / 1000);
            
            if (keyboard_check_pressed(ord("R"))) {
                if (instance_exists(parEnemy)) {
                    var _t = instance_nearest(mouse_x, mouse_y, parEnemy);
                    if (point_distance(owner.x, owner.y, _t.x, _t.y) < range) {
                        target = _t;
                        spd = 0.1;
                        state = StandState.SkillA;
                    }
                }
            }
        break;
        case StandState.SkillA:
            ScriptCall(StrongPunch);
        break;
    }
} else {
    image_alpha = lerp(image_alpha, 0, 0.2);
    xTo = owner.x;
    yTo = owner.y;
}

#define GiveStarPlatinum

var _name = "Star Platinum";
var _sprite = global.sprStarPlatinum;
var _stats = [
    50,
    10,
    0.5
];
var _skills = [
    ScriptWrap(StrongPunch),
    ScriptWrap(EventHandler),
    ScriptWrap(EventHandler),
    ScriptWrap(EventHandler)
]
StandBuilder(_name, _sprite, _stats, _skills);

InstanceAssignMethod(objPlayer.myStand, "step", ScriptWrap(StarPlatinumStep), false);

#endregion

#region The World

#define TheWorldStep



#define GiveTheWorld

var _name = "The World";
var _sprite = global.sprTheWorld;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.5;

var _skills;
var _s;

_s = StandState.SkillA;
_skills[_s, StandSkill.Skill] = StandBarrage;
_skills[_s, StandSkill.Key] = "R";
_skills[_s, StandSkill.Icon] = global.sprSkillBarrage;
_skills[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_skills[_s, StandSkill.MaxCooldown] = 5;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.MaxExecutionTime] = 2;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillB;
_skills[_s, StandSkill.Skill] = StrongPunch;
_skills[_s, StandSkill.Key] = "F";
_skills[_s, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_skills[_s, StandSkill.MaxCooldown] = 8;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.MaxExecutionTime] = 1;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillC;
_skills[_s, StandSkill.Skill] = TripleKnifeThrow;
_skills[_s, StandSkill.Key] = "C";
_skills[_s, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_skills[_s, StandSkill.MaxCooldown] = 3;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.MaxExecutionTime] = 1;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillD;
_skills[_s, StandSkill.Skill] = Timestop;
_skills[_s, StandSkill.Key] = "G";
_skills[_s, StandSkill.Icon] = global.sprSkillTimestop;
_skills[_s, StandSkill.Damage] = _stats[StandStat.AttackDamage];
_skills[_s, StandSkill.MaxCooldown] = 30;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.MaxExecutionTime] = 1;
_skills[_s, StandSkill.ExecutionTime] = 0;

StandBuilder(_name, _sprite, _stats, _skills);

InstanceAssignMethod(objPlayer.myStand, "step", ScriptWrap(StandDefaultStep), false);
InstanceAssignMethod(objPlayer.myStand, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);
SaveStand("tw");

#endregion

#define AnubisStep



#define GiveAnubis

var _name = "Anubis";
var _sprite = global.sprAnubis;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 8;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.9;

var _skills;
var _s;

_s = StandState.SkillA;
_skills[_s, StandSkill.Skill] = HorizontalSlash;
_skills[_s, StandSkill.Key] = "R";
_skills[_s, StandSkill.MaxCooldown] = 1;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[_s, StandSkill.MaxExecutionTime] = 0;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillB;
_skills[_s, StandSkill.Skill] = EventHandler;
_skills[_s, StandSkill.Key] = "F";
_skills[_s, StandSkill.MaxCooldown] = 1;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[_s, StandSkill.MaxExecutionTime] = 0;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillC;
_skills[_s, StandSkill.Skill] = EventHandler;
_skills[_s, StandSkill.Key] = "C";
_skills[_s, StandSkill.MaxCooldown] = 1;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.Icon] = global.sprSkillTemplate;
_skills[_s, StandSkill.MaxExecutionTime] = 0;
_skills[_s, StandSkill.ExecutionTime] = 0;

_s = StandState.SkillD;
_skills[_s, StandSkill.Skill] = EventHandler;
_skills[_s, StandSkill.Key] = "G";
_skills[_s, StandSkill.MaxCooldown] = 1;
_skills[_s, StandSkill.Cooldown] = 0;
_skills[_s, StandSkill.Icon] = global.sprSkillTemplate;
_skills[_s, StandSkill.MaxExecutionTime] = 0;
_skills[_s, StandSkill.ExecutionTime] = 0;

StandBuilder(_name, _sprite, _stats, _skills);

InstanceAssignMethod(objPlayer.myStand, "step", ScriptWrap(StandDefaultStep), false);
InstanceAssignMethod(objPlayer.myStand, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);

#define StandBuilder(name, sprite, stats, skills)

// init
objPlayer.myStand = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
objPlayer.myStand.label = "stand";
objPlayer.myStand.name = name;
objPlayer.myStand.sprite_index = sprite;
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
}
