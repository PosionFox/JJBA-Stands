
// wip

#define SpinningNails(m, s) // act 1 from here
if (nails <= 0)
{
    ResetCD(s);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_yellow;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    damage = other.skills[s, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    GlowOrderCreate(self, 0.1, c_yellow);
}
nails--;
FireCD(s);
state = StandState.Idle;

#define NailScratch(m, s)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
PunchCreate(player.x, player.y, _dir, skills[s, StandSkill.Damage], 1);
FireCD(s);
state = StandState.Idle;

#define HerbTea(m, s)

player.hp++;
STAND.nails += 2;
STAND.nails = clamp(STAND.nails, 0, STAND.nailsMax);
FireCD(s);
state = StandState.Idle;

#define BulletHole // act 2 from here

var _o = ProjectileCreate(x, y)
with (_o)
{
    type = "bulletHole";
    sprite_index = global.sprNailVoid;
    visible = false;
    damage = 2 + player.level * 0.1 + player.dmg;
    direction = random(360);
    xTo = lengthdir_x(100, direction);
    yTo = lengthdir_y(100, direction);
    GlowOrderCreate(self, 0.1, c_purple);
    
    InstanceAssignMethod(self, "step", ScriptWrap(BulletHoleStep));
}

#define BulletHoleStep

image_angle -= 16;
var pd = point_direction(x, y, xTo, yTo);
var dd = angle_difference(direction, pd);
direction -= min(abs(dd), 6) * sign(dd);
visible = true;
baseSpd *= 0.99;
image_alpha = min(1, despawnTime * 0.1);

#define GoldenRectangleNails(m, s)

if (nails <= 0)
{
    ResetCD(s);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_yellow;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    onHitEvent = BulletHole;
    damage = other.skills[s, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    GlowOrderCreate(self, 0.1, c_yellow);
}
nails--;
FireCD(s);
state = StandState.Idle;

#define DoubleGoldenRectangleNails(m, s)
if (nails <= 0)
{
    ResetCD(s);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

if (attackStateTimer >= 0.2)
{
    var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
    with (_p)
    {
        audio_play_sound(global.sndGunShot, 0, false);
        baseSpd = 10;
        sprite_index = global.sprBtdVoidTrace;
        image_blend = c_yellow;
        mask_index = global.sprKnife;
        despawnTime = room_speed * 5;
        onHitEvent = BulletHole;
        damage = other.skills[s, StandSkill.Damage];
        direction = _dir;
        canMoveInTs = false;
        GlowOrderCreate(self, 0.1, c_yellow);
    }
    nails--;
    attackState++;
    attackStateTimer = 0;
}
attackStateTimer += 1 / room_speed;
if (attackState >= 2)
{
    FireCD(s);
    state = StandState.Idle;
}

#define BulletHoleRedirection(m, s)

with (MOBJ)
{
    if ("type" in self and type == "bulletHole")
    {
        xTo = mouse_x;
        yTo = mouse_y;
    }
}
FireCD(s);
state = StandState.Idle;

#define WormholeNail(m, s)

if (nails <= 0)
{
    ResetCD(s);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_fuchsia;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    onHitEvent = BulletHole;
    damage = other.skills[s, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    tpTime = 0;
    GlowOrderCreate(self, 0.1, c_yellow);
    
    InstanceAssignMethod(self, "step", ScriptWrap(WormholeNailStep));
}
nails--;
FireCD(s);
state = StandState.Idle;

#define WormholeNailStep

tpTime += 1 / room_speed;
if (tpTime >= 1)
{
    if (instance_exists(ENEMY))
    {
        var _near = instance_nearest(x, y, ENEMY);
        var _d = random(360);
        x = _near.x + lengthdir_x(32, _d);
        y = _near.y + lengthdir_y(32, _d);
         var _dir = point_direction(x, y, _near.x, _near.y);
        direction = _dir;
        tpTime = 0;
    }
}

#define SpatialWormhole(m, s) // act 3 from here

switch (attackState)
{
    case 0:
        ShrinkingCircleEffect(x, y);
        if (attackStateTimer >= 0.2)
        {
            attackState++;
        }
    break;
    case 1:
        if !(place_meeting(mouse_x, mouse_y, parSolid) and WaterCollision(mouse_x, mouse_y))
        {
            ShrinkingCircleEffect(mouse_x, mouse_y);
            if (attackStateTimer >= 0.4)
            {
                attackState++;
            }
        }
        else
        {
            ResetCD(s);
            state = StandState.Idle;
        }
    break;
    case 2:
        player.x = mouse_x;
        player.y = mouse_y;
        FireCD(s);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define SpatialWormholeReverse(m, s)

if !(place_meeting(mouse_x, mouse_y, parSolid) and WaterCollision(mouse_x, mouse_y))
{
    var _c = collision_circle(mouse_x, mouse_y, 8, ENEMY, false, true);
    if (_c)
    {
        var _dir = point_direction(player.x, player.y, _c.x, _c.y);
        _c.x = player.x + lengthdir_x(32, _dir);
        _c.y = player.y + lengthdir_y(32, _dir);
    }
    FireCD(s);
    state = StandState.Idle;
}
else
{
    ResetCD(s);
    state = StandState.Idle;
}

#define InfiniteRotation(m, s) // act 4 from here

if (nails <= 0)
{
    ResetCD(s);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

var _p = ProjectileCreate(player.x, player.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_yellow;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    onHitEvent = BulletHole;
    damage = other.skills[s, StandSkill.Damage] * other.act4Meter;
    direction = _dir;
    canMoveInTs = false;
    GlowOrderCreate(self, 0.1, c_yellow);
}
act4Meter *= 0.85;
nails--;
FireCD(s);
state = StandState.Idle;

#define TuskAct1BtnCreate(_moveset)

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, -10000);
with (_o)
{
    type = "tuskAct1Btn";
    sprite_index = global.sprBtdStare;
    moveset = _moveset;
    
    InstanceAssignMethod(self, "step", ScriptWrap(TuskAct1BtnStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(TuskActBtnDestroy));
}

#define TuskAct2BtnCreate(_moveset)

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, -10000);
with (_o)
{
    type = "tuskAct2Btn";
    sprite_index = global.sprBtdStare;
    moveset = _moveset;
    
    InstanceAssignMethod(self, "step", ScriptWrap(TuskAct2BtnStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(TuskActBtnDestroy));
}

#define TuskAct3BtnCreate(_moveset)

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, -10000);
with (_o)
{
    type = "tuskAct3Btn";
    sprite_index = global.sprBtdStare;
    moveset = _moveset;
    
    InstanceAssignMethod(self, "step", ScriptWrap(TuskAct3BtnStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(TuskActBtnDestroy));
}

#define TuskAct4BtnCreate(_moveset)

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, -10000);
with (_o)
{
    type = "tuskAct4Btn";
    sprite_index = global.sprBtdStare;
    moveset = _moveset;
    
    InstanceAssignMethod(self, "step", ScriptWrap(TuskAct4BtnStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(TuskActBtnDestroy));
}

#define TuskAct1BtnStep

x = lerp(x, CAM.x + 64, 0.9);
y = lerp(y, CAM.y, 0.9);

#define TuskAct2BtnStep

x = lerp(x, CAM.x, 0.9);
y = lerp(y, CAM.y - 64, 0.9);

#define TuskAct3BtnStep

x = lerp(x, CAM.x - 64, 0.9);
y = lerp(y, CAM.y, 0.9);

#define TuskAct4BtnStep

x = lerp(x, CAM.x, 0.9);
y = lerp(y, CAM.y + 64, 0.9);

#define TuskActBtnDestroy

if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
{
    with (STAND)
    {
        skills = other.moveset;
        switch (other.type)
        {
            case "tuskAct1Btn":
                sprite_index = global.sprTuskAct1;
                currentAct = "act 1";
                summonSound = global.sndTa1Summon;
            break;
            case "tuskAct2Btn":
                sprite_index = global.sprTuskAct2;
                currentAct = "act 2";
                summonSound = global.sndTa2Summon;
            break;
            case "tuskAct3Btn":
                sprite_index = global.sprTuskAct3;
                currentAct = "act 3";
                summonSound = global.sndTa3Summon;
            break;
            case "tuskAct4Btn":
                sprite_index = global.sprTuskAct4;
                currentAct = "act 4";
                summonSound = global.sndTa4Summon;
            break;
        }
        active = true;
        if (!audio_is_playing(summonSound) and summonSound != noone)
        {
            audio_play_sound(summonSound, 0, false);
        }
    }
}

#define StandTuskSummon

if (keyboard_check_pressed(ord("Q")) and state == StandState.Idle) {
    if (active)
    {
        currentAct = "";
        skills = defMoveset;
        active = false;
    }
    else
    {
        if (hasAct1 and !modTypeExists("tuskAct1Btn"))
        {
            TuskAct1BtnCreate(act1Moveset);
        }
        if (hasAct2 and !modTypeExists("tuskAct2Btn"))
        {
            TuskAct2BtnCreate(act2Moveset);
        }
        if (hasAct3 and !modTypeExists("tuskAct3Btn"))
        {
            TuskAct3BtnCreate(act3Moveset);
        }
        if (hasAct4 and !modTypeExists("tuskAct4Btn") and act4Meter >= 25)
        {
            TuskAct4BtnCreate(act4Moveset);
        }
    }
}
if (keyboard_check_released(ord("Q")))
{
    var _b1 = modTypeFind("tuskAct1Btn");
    var _b2 = modTypeFind("tuskAct2Btn");
    var _b3 = modTypeFind("tuskAct3Btn");
    var _b4 = modTypeFind("tuskAct4Btn");
    if (instance_exists(_b1))
    {
        instance_destroy(_b1);
    }
    if (instance_exists(_b2))
    {
        instance_destroy(_b2);
    }
    if (instance_exists(_b3))
    {
        instance_destroy(_b3);
    }
    if (instance_exists(_b4))
    {
        instance_destroy(_b4);
    }
}

#define StandTuskStep

if (nailCD <= 0)
{
    nails = min(nails + 1, nailsMax);
    nailCD = nailMaxCD;
}
if (nails < nailsMax)
{
    nailCD -= 1 / room_speed;
}

if (hasAct3)
{
    nailsMax = 20;
}

if (hasAct4)
{
    if (instance_exists(player))
    {
        if (player.h != 0 or player.v != 0)
        {
            act4Meter += 0.02;
        }
    }
    act4Meter = clamp(act4Meter, 0, act4MeterMax);
    
    if (currentAct == "act 4")
    {
        act4Meter -= 0.05;
        if (act4Meter <= 0)
        {
            currentAct = "";
            skills = defMoveset;
            active = false;
        }
    }
}

#define StandTuskDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;
var _txt = string(currentAct);

draw_set_color(c_fuchsia);
draw_text(256, _height - 160, _txt);
draw_set_color(c_white);

if (hasAct1 and !hasAct2)
{
    draw_sprite_ext(global.sprHeart, 0, 384, _height - 104, 2, 2, 0, c_dkgray, 1);
}
if (hasAct2 and !hasAct3)
{
    draw_sprite_ext(global.sprEye, 0, 384, _height - 104, 2, 2, 0, c_dkgray, 1);
}

if (hasAct4)
{
    var _c = c_black;
    if (act4Meter >= 25) { _c = c_fuchsia; }
    draw_set_color(c_gray);
    draw_line_width(32, _height - 160, 32 + 256, _height - 160, 2);
    draw_set_color(_c);
    draw_line_width(32, _height - 160, 32 + (act4Meter / act4MeterMax) * 256, _height - 160, 2);
    draw_set_color(c_white);
}

for (var i = 0; i < balls; i++)
{
    draw_sprite_ext(global.sprSteelBall, 0, 320 + (32 * i), _height - 108, 2, 2, 0, c_white, 1);
}
for (var i = 0; i < nails; i++)
{
    draw_sprite_ext(global.sprNailGUI, 0, 320 + (i mod 10) * 8, _height - 80 + (i div 10) * 8, 2, 2, 0, c_white, 1);
}

#define StandSkillTuskCDs

StandSkillRunCD(defMoveset);
StandSkillRunCD(act1Moveset);
StandSkillRunCD(act2Moveset);
StandSkillRunCD(act3Moveset);
StandSkillRunCD(act4Moveset);

#define GiveTusk //stand

var _name = "Tusk";
var _sprite = global.sprTuskAct1;
var _color = /*#*/0xba7bd7;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5.5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.5;

var _skills, _skills1, _skills2, _skills3, _skills4;
var sk;

_skills = StandSkillInit(_stats);
_skills1 = StandSkillInit(_stats);
_skills2 = StandSkillInit(_stats);
_skills3 = StandSkillInit(_stats);
_skills4 = StandSkillInit(_stats);

#region standless moveset

sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = SteelBall;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.4) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = "steel ball:\nlaunch a steel ball with spin energy.\ndmg: " + DMG;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = GuidedSteelBall;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.3) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = "guided steel ball:\nlaunch a guided steel ball.\ndmg: " + DMG;

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = SkinHarden;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = "skin harden!:\nhardens your skin decreasing damage taken.";

#endregion

#region act 1 moveset

sk = StandState.SkillA;
_skills1[sk, StandSkill.Skill] = SpinningNails;
_skills1[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills1[sk, StandSkill.Icon] = global.sprSkillSpinningNail;
_skills1[sk, StandSkill.MaxCooldown] = 0.8;

sk = StandState.SkillB;
_skills1[sk, StandSkill.Skill] = NailScratch;
_skills1[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills1[sk, StandSkill.Icon] = global.sprSkillScratch;
_skills1[sk, StandSkill.MaxCooldown] = 5;

// sk = StandState.SkillC;
// _skills1[sk, StandSkill.Skill] = StarFinger;
// _skills1[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.05) + objPlayer.dmg;
// _skills1[sk, StandSkill.Icon] = global.sprSkillStarFinger;
// _skills1[sk, StandSkill.MaxCooldown] = 3;
// _skills1[sk, StandSkill.MaxExecutionTime] = 0.7;

sk = StandState.SkillD;
_skills1[sk, StandSkill.Skill] = HerbTea;
_skills1[sk, StandSkill.Icon] = global.sprSkillHerbTea;
_skills1[sk, StandSkill.MaxCooldown] = 20;
_skills1[sk, StandSkill.MaxExecutionTime] = 1;

#endregion

#region act 2 moveset

sk = StandState.SkillA;
_skills2[sk, StandSkill.Skill] = GoldenRectangleNails;
_skills2[sk, StandSkill.Damage] = 2 + (player.level * 0.1) + player.dmg;
_skills2[sk, StandSkill.Icon] = global.sprSkillGoldenRectangleNail;
_skills2[sk, StandSkill.MaxCooldown] = 0.8;

sk = StandState.SkillB;
_skills2[sk, StandSkill.Skill] = DoubleGoldenRectangleNails;
_skills2[sk, StandSkill.Damage] = 2 + (player.level * 0.1) + player.dmg;
_skills2[sk, StandSkill.Icon] = global.sprSkillDoubleGoldenRectangleNail;
_skills2[sk, StandSkill.MaxCooldown] = 1.2;

sk = StandState.SkillC;
_skills2[sk, StandSkill.Skill] = BulletHoleRedirection;
_skills2[sk, StandSkill.Icon] = global.sprSkillNailVoidRedirection;
_skills2[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillD;
_skills2[sk, StandSkill.Skill] = WormholeNail;
_skills2[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills2[sk, StandSkill.Icon] = global.sprSkillWormholeNail;
_skills2[sk, StandSkill.MaxCooldown] = 10;

#endregion

#region act 3 moveset

sk = StandState.SkillA;
_skills3[sk, StandSkill.Skill] = WormholeNail;
_skills3[sk, StandSkill.Damage] = 4 + (objPlayer.level * 0.3) + objPlayer.dmg;
_skills3[sk, StandSkill.Icon] = global.sprSkillWormholeNail;
_skills3[sk, StandSkill.MaxCooldown] = 5;
_skills3[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills3[sk, StandSkill.Skill] = SpatialWormhole;
_skills3[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills3[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills3[sk, StandSkill.Skill] = SpatialWormholeReverse;
_skills3[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills3[sk, StandSkill.MaxCooldown] = 8;

#endregion

#region act 4 moveset

sk = StandState.SkillA;
_skills4[sk, StandSkill.Skill] = StandBarrage;
_skills4[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills4[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills4[sk, StandSkill.MaxCooldown] = 5;
_skills4[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills4[sk, StandSkill.Skill] = StrongPunch;
_skills4[sk, StandSkill.Damage] = 5 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills4[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills4[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills4[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills4[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills4[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills4[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillD;
_skills4[sk, StandSkill.Skill] = InfiniteRotation;
_skills4[sk, StandSkill.Damage] = ((1 + sqrt(5)) / 2) * player.level;
_skills4[sk, StandSkill.Icon] = global.sprSkillInfiniteRotation;
_skills4[sk, StandSkill.MaxCooldown] = 60;

#endregion

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndTa1Summon;
    saveKey = "jjbamTsk";
    discType = global.jjbamDiscTsk;
    
    summonMethod = StandTuskSummon;
    runCDsMethod = StandSkillTuskCDs;
    
    currentAct = "";
    hasAct1 = true;
    hasAct2 = false;
    hasAct3 = false;
    hasAct4 = false;
    
    act4MeterMax = 100;
    act4Meter = 0;
    
    defMoveset = _skills;
    act1Moveset = _skills1;
    act2Moveset = _skills2;
    act3Moveset = _skills3;
    act4Moveset = _skills4;
    
    balls = 2;
    nailMaxCD = 2;
    nailCD = nailMaxCD;
    nailsMax = 10;
    nails = nailsMax;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandTuskDrawGUI));
    InstanceAssignMethod(self, "step", ScriptWrap(StandTuskStep));
}
return _s;

#define GiveTusk4

var _s = GiveTusk();
with (_s)
{
    hasAct2 = true;
    hasAct3 = true;
    hasAct4 = true;
    nailsMax = 20;
    nails += 5;
}

