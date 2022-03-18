
#define FireCD(skill)

attackState = 0;
if (altAttack)
{
    skills[skill, StandSkill.CooldownAlt] = skills[skill, StandSkill.MaxCooldownAlt];
}
else
{
    skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown];
}
attackStateTimer = 0;
altAttack = false;
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

FireCD(skill);
skills[skill, StandSkill.Cooldown] = 0;

#define AttackHandler(method, skill)

//ResetCD(skill);
state = StandState.Idle;

#define ProjectileCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprBullet;
    baseAnimSpd = 1;
    image_speed = baseAnimSpd;
    visible = false;
    type = "projectile";
    subtype = "projectile";
    owner = other;
    despawnTime = room_speed * 5;
    baseSpd = 5;
    spd = baseSpd;
    baseDamage = 0;
    damage = baseDamage;
    destroyOnImpact = true;
    instancesHit = [];
    stationary = false;
    distance = 0;
    canMoveInTs = true;
    canDespawnInTs = false;
    knockback = 0;
    knockbackDuration = 0.5;
    onHitSound = global.sndPunchHit;
    onHitEvent = noone;
    onHitEventArg = undefined;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ProjectileStep), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(ProjectileDestroy), false);
}
return _o;

#define ProjectileStep

if (!visible) { visible = true; }
depth = -y;

if (global.timeIsFrozen and canDespawnInTs or !global.timeIsFrozen)
{
    despawnTime--;
}
if (despawnTime <= 0) {
    instance_destroy(self);
}

if (instance_exists(self)) {
    image_angle = direction;
    image_yscale = sign(dcos(image_angle));
    
    if (stationary)
    {
        x = owner.x + lengthdir_x(distance, direction);
        y = owner.y + lengthdir_y(distance, direction);
    }
    else
    {
        if (!global.timeIsFrozen)
        {
            spd = baseSpd;
            image_speed = baseAnimSpd;
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
        else if (global.timeIsFrozen and canMoveInTs)
        {
            spd = baseSpd;
            image_speed = baseAnimSpd;
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
        else if (global.timeIsFrozen and !canMoveInTs)
        {
            spd = lerp(spd, 0, 0.15);
            image_speed = lerp(image_speed, 0, 0.1);
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
    }
    
    with (parEnemy)
    {
        if (place_meeting(x, y, other) and scale != 0)
        {
            if (array_find_index(other.instancesHit, id) == -1)
            {
                if (other.onHitSound != noone)
                {
                    if (audio_is_playing(other.onHitSound))
                    {
                        audio_stop_sound(other.onHitSound);
                    }
                    var _s = audio_play_sound(other.onHitSound, 0, false);
                    audio_sound_pitch(_s, random_range(0.9, 1.1));
                }
                if (other.onHitEvent != noone)
                {
                    with (other)
                    {
                        script_execute(onHitEvent, onHitEventArg, undefined);
                    }
                }
                PunchEffectCreate(other.x, other.y);
                DustEntityAdd(other.x, other.y);
                var _dir = point_direction(x, y, other.x, other.y) - 180;
                // if (other.knockback > 0)
                // {
                //     KnockbackCreate(self, other.knockback, other.direction, other.knockbackDuration);
                // }
                h = lengthdir_x(other.knockback, other.direction);
                v = lengthdir_y(other.knockback, other.direction);
                hp -= other.damage;
                array_push(other.instancesHit, id);
                if (other.destroyOnImpact)
                {
                    instance_destroy(other);
                }
            }
        }
    }
}

#define ProjectileDestroy



#define KnockbackCreate(_target, _strength, _direction, _duration)

var _o = ModObjectSpawn(x, y, 0);
with (_o)
{
    target = _target;
    strength = _strength;
    dir = _direction;
    duration = _duration;
    
    InstanceAssignMethod(self, "step", ScriptWrap(KnockbackStep), false);
}
return _o;

#define KnockbackStep

if (duration <= 0)
{
    instance_destroy(self);
    exit;
}
duration -= 1 / room_speed;

if (instance_exists(target))
{
    target.h = lengthdir_x(strength, dir);
    target.v = lengthdir_y(strength, dir);
}

#define TimestopCreate(_length)

type = "timestop";
global.timeIsFrozen = true;
radiusGrow = true;
growthTarget = 0;
growth = 800;
maxLength = _length;
length = 0;
whiteScreen = 0.1;

#define TimestopStep

if (whiteScreen > 0)
{
    whiteScreen -= 1 / room_speed;
}

with (parEnemy)
{
    freeze = 2;
    // var _o = ModObjectSpawn(x, y, depth);
    // _o.type = "TsEnemy";
    // _o.target = self;
    // _o.sprite_index = sprite_index;
    // _o.image_speed = 0;
    // _o.image_index = image_index;
    // _o.image_xscale = -image_xscale;
    // _o.image_yscale = image_yscale;
    // _o.damageStack = 0;
    // InstanceAssignMethod(_o, "step", ScriptWrap(TsEnemyStep), false);
    // InstanceAssignMethod(_o, "destroy", ScriptWrap(TsEnemyDestroy), false);
    // instance_deactivate_object(self);
}

if (instance_exists(owner))
{
    x = owner.x;
    y = owner.y;
}

//growth = clamp(growth, 0, 500);
growth = lerp(growth, growthTarget, 0.1);/*
with (objModEnemy)
{
    var _col = instance_place(x, y, objEmpty);
    if ("projectile" in _col)
    {
        damageStack += _col.damage;
    }
}*/
length += 1 / room_speed;
if (length >= maxLength)
{
    instance_destroy(self);
}

#define TimestopDraw

if (whiteScreen > 0)
{
    draw_circle(x, y, 1000, false);
}
else
{
    draw_set_color(c_white);
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
    draw_circle(x, y, growth, false);
    gpu_set_blendmode(bm_normal);
    draw_set_color(image_blend);
}

#define TimestopDestroy

audio_play_sound(global.sndTwTsResume, 5, false);
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == "TsEnemy")
        {
            instance_destroy(self);
        }
    }
}
global.timeIsFrozen = false;

#define TsEnemyStep

var _col = instance_place(x, y, objModEmpty);
if (_col)
{
    if ("type" in _col)
    {
        if (_col.type == "projectile")
        {
            damageStack += _col.damage;
        }
    }
}

#define TsEnemyDestroy

target.hp -= damageStack;

#define PunchCreate(_x, _y, _dir, _dmg, _knockback)

var _p = ProjectileCreate(_x, _y);
with (_p)
{
    sprite_index = global.sprAttackPunch;
    image_blend = other.color;
    damage = _dmg;
    despawnTime = room_speed * 0.1;
    canDespawnInTs = true;
    destroyOnImpact = false;
    direction = _dir;
    knockback = _knockback;
}
return _p;

#define StandBarrage(method, skill)
var _dis = point_distance(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

xTo = objPlayer.x + lengthdir_x(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
yTo = objPlayer.y + lengthdir_y(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
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
        var ddir = _dir + random_range(-45, 45);
        var _p = PunchCreate(xx, yy, ddir, skills[skill, StandSkill.Damage], 0);
        _p.onHitSound = global.sndPunchHit;
        InstanceAssignMethod(_p, "step", ScriptWrap(StandBarrageStep), true);
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

#define StandBarrageStep

var pd = point_direction(x, y, mouse_x, mouse_y);
var xx = objPlayer.x + lengthdir_x(32, pd);
var yy = objPlayer.y + lengthdir_y(32, pd);
pd = point_direction(x, y, xx, yy);
var dd = angle_difference(direction, pd);
direction -= min(abs(dd), 10) * sign(dd);

#define StrongPunch(method, skill)

var _dis = point_distance(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y)

var _xx = objPlayer.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = objPlayer.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
        break;
    case 1:
        var _p = PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 3);
        _p.onHitSound = global.sndStrongPunch;
        FireCD(skill);
        state = StandState.Idle;
        break;
}
attackStateTimer += 1 / room_speed;

#define LastingDamageCreate(_target, _dmg, _time, _percentageDamage)

var _o = ModObjectSpawn(_target.x, _target.y, _target.depth);
with (_o)
{
    target = _target;
    damage = _dmg;
    timeMax = _time;
    time = 0;
    percentageDamage = _percentageDamage;
    
    InstanceAssignMethod(self, "step", ScriptWrap(LastingDamageStep), false);
}
return _o;

#define LastingDamageStep

if (instance_exists(target))
{
    x = target.x;
    y = target.y;
    
    if ("hp" in target)
    {
        if (percentageDamage)
        {
            target.hp -= target.hpMax * damage;
        }
        else
        {
            target.hp -= damage;
        }
    }
    
    if (time >= timeMax)
    {
        instance_destroy(self);
        exit;
    }
    time += 1 / room_speed;
}

#define SteelBallCreate(_x, _y, _dir, _dmg)

var _o = ProjectileCreate(_x, _y)
with (_o)
{
    type = "steelBall";
    sprite_index = global.sprSteelBallProj;
    direction = _dir;
    destroyOnImpact = false;
    damage = _dmg;
    isGuided = false;
    empowered = false;
    despawnTime = room_speed * 20;
    live = 3;
    
    state = "chase";
    
    InstanceAssignMethod(self, "step", ScriptWrap(SteelBallStep))
}
return _o;

#define SteelBallStep

live -= 1 / room_speed;
if (live <= 0)
{
    state = "comeback";
}

var _c = collision_circle(x, y, 4, MOBJ, false, true);
if (_c and "type" in _c)
{
    if (_c.type == "steelBall" and !empowered)
    {
        damage *= 2;
        empowered = true;
    }
}

if (empowered)
{
    FireEffect(c_lime, c_yellow);
}

switch (state)
{
    case "chase":
        if (isGuided)
        {
            var pd = point_direction(x, y, mouse_x, mouse_y);
            var dd = angle_difference(direction, pd);
            direction -= min(abs(dd), 3) * sign(dd);
        }
        if (place_meeting(x, y, parEnemy))
        {
            state = "comeback";
        }
    break;
    case "comeback":
        var pd = point_direction(x, y, STAND.x, STAND.y);
        var dd = angle_difference(direction, pd);
        direction -= min(abs(dd), 8) * sign(dd);
        if (place_meeting(x, y, STAND))
        {
            if ("balls" in STAND)
            {
                STAND.balls++;
            }
            instance_destroy(self);
        }
    break;
}

