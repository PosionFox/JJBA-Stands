
global.jjbamDiscSf = ItemCreate(
    undefined,
    Localize("standDiscName") + "SF",
    Localize("standDiscDescription") + "Sticky Fingers",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSfUse),
    5 * 10,
    true
);

#define DiscSfUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSf);
    exit;
}
GiveStickyFingers(player);

#define SfBarrage(method, skill) //attacks
var _dis = point_distance(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

xTo = objPlayer.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = objPlayer.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > objPlayer.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.08)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(skill));
        with (_p)
        {
            destroyOnImpact = true;
            onHitSound = global.sndSfPunch;
            onHitEvent = ZipperInjury;
            onHitEventArg = [x, y];
        }
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

if (keyboard_check_pressed(ord(skills[skill, StandSkill.Key])))
{
    if (skills[skill, StandSkill.ExecutionTime] > 0)
    {
        FireCD(skill);
    }
    else
    {
        ResetCD(skill);
    }
    state = StandState.Idle;
}

#define ZipperPunch(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 3);
        with (_p)
        {
            onHitSound = global.sndSfStrong;
            onHitEvent = ZipperInjury;
            onHitEventArg = [x, y];
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT;

#define ZipperGrab(method, skill)
var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSfGrab, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, 3, 1);
        with (_p)
        {
            subtype = "sfGrab";
            target = noone;
            despawnTime = 10;
            timer = 0.4;
            grab = false;
            
            InstanceAssignMethod(self, "step", ScriptWrap(ZipperGrabStep), true);
            InstanceAssignMethod(self, "draw", ScriptWrap(ZipperGrabDraw), true);
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 4:
        var _o = modSubtypeFind("sfGrab");
        if (_o == noone)
        {
            FireCD(skill);
            state = StandState.Idle;
        }
        if (instance_place(x, y, _o))
        {
            with (_o)
            {
                if (instance_exists(target))
                {
                    target.behaviourEngage = true;
                }
                instance_destroy(self);
            }
            FireCD(skill);
            state = StandState.Idle;
        }
    break;
}
attackStateTimer += DT;

#define SfPortal(method, skill)
var _sc = collision_circle(mouse_x, mouse_y, 16, parSolid, false, true);
var _wc = WaterCollision(mouse_x, mouse_y);
if (_sc or _wc)
{
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(10, _dir);
yTo = objPlayer.y + lengthdir_y(10, _dir);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSfPortal, 1, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        if (!_sc and !_wc)
        {
            var _p1 = SfPortalCreate(xTo, yTo);
            _p1.subtype = "sfP1";
            var _p2 = SfPortalCreate(mouse_x, mouse_y);
            _p2.subtype = "sfP2";
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT;

#define ZipperInjury(_scr, _pos) //attack properties

var _o = ModObjectSpawn(_pos[0], _pos[1], 0);
with (_o)
{
    type = "sfInjury";
    sprite_index = global.sprSfZipper;
    image_angle = irandom(360);
    image_speed = 0.5;
    
    target = noone;
    if (instance_exists(ENEMY))
    {
        if (random(100) < 50)
        {
            var _s = audio_play_sound(global.sndSfInjury, 0, false);
            audio_sound_pitch(_s, random_range(0.9, 1.1));
        }
        target = instance_nearest(x, y, ENEMY);
        with (target)
        {
            hp -= (hpMax * 0.01) * 0.5;
        }
    }
    else
    {
        instance_destroy(self);
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(ZipperInjuryStep), false);
}

#define ZipperInjuryStep

if (instance_exists(target))
{
    x = target.x + irandom_range(-0.5, 0.5);
    y = target.y + irandom_range(-0.5, 0.5);
    depth = target.depth - 1;
}
if (image_index >= image_number - 1)
{
    image_speed = 0;
}

image_alpha -= 0.05;
if (image_alpha <= 0)
{
    instance_destroy(self);
}

#define ZipperGrabStep
var _dir = point_direction(x, y, STAND.x, STAND.y);

timer -= DT;
if (timer <= 0)
{
    direction = _dir;
    
    // if (place_meeting(x, y, objPlayer.myStand))
    // {
    //     if (instance_exists(target))
    //     {
    //         target.behaviourEngage = true;
    //     }
    //     instance_destroy(self);
    //     exit;
    // }
}

var _hit = instance_place(x, y, ENEMY);
if (_hit and !grab)
{
    audio_play_sound(global.sndSfGrabReturn, 0, false);
    target = _hit;
    grab = true;
    timer = 0;
}

if (grab and instance_exists(target))
{
    target.behaviourEngage = false;
    target.x = x;
    target.y = y;
}

#define ZipperGrabDraw

draw_set_color(c_yellow);
draw_line_width(x, y, STAND.x, STAND.y, 2);
draw_set_color(image_blend);

#define SfPortalCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "SfPortal";
    subtype = type;
    sprite_index = global.sprSfPortal;
    image_angle = random(360);
    image_speed = 0.5;
    
    life = 5;
    cooldown = 1;
    close = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(SfPortalStep), false);
}
return _o;

#define SfPortalStep

if (close)
{
    if (image_index <= 0)
    {
        instance_destroy(self);
        exit;
    }
    image_index -= 0.5;
}

life -= DT;
if (life <= 0)
{
    close = true;
}
if (image_index >= image_number - 1)
{
    image_speed = 0;
}
if (cooldown > 0)
{
    cooldown -= DT;
}

if (instance_exists(ENTITY))
{
    var _ins = instance_place(x, y, ENTITY);
    if (_ins and cooldown <= 0)
    {
        var _pt = objPlayer;
        if (subtype == "sfP1")
        {
            _pt = modSubtypeFind("sfP2");
        }
        else
        {
            _pt = modSubtypeFind("sfP1");
        }
        audio_play_sound(global.sndSfTp, 0, false);
        FireEffect(c_white, c_aqua);
        LineEffect(_ins.x, _ins.y, _pt.x, _pt.y).color = c_aqua;
        _ins.x = _pt.x;
        _ins.y = _pt.y;
        _pt.cooldown = 1;
        cooldown = 1;
    }
}

#define GiveStickyFingers(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = SfBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = Localize("sfBarrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = ZipperPunch;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 10;
_skills[sk, StandSkill.Desc] = Localize("zipperPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = ZipperGrab;
_skills[sk, StandSkill.Icon] = global.sprSkillZipperGrab;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = Localize("zipperGrabDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SfPortal;
_skills[sk, StandSkill.Icon] = global.sprSkillZipPortal;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 20;
_skills[sk, StandSkill.Desc] = Localize("portalThroughDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Sticky Fingers";
    sprite_index = global.sprStickyFingers;
    color = 0xfcdbcb;
    summonSound = global.sndSfSummon;
    discType = global.jjbamDiscSf;
    saveKey = "jjbamSf";
}
return _s;
