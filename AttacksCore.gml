
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

#define EndAtk(skill)

angleTarget = 0;
angleTargetSpd = 0.1;
attackStateTimer = 0;
FireCD(skill);
state = StandState.Idle;

#define ResetAtk(skill)

angleTarget = 0;
angleTargetSpd = 0.1;
FireCD(skill);
skills[skill, StandSkill.Cooldown] = 0;
state = StandState.Idle;

#define AttackHandler(method, skill)

//ResetCD(skill);
state = StandState.Idle;

#define GetDmg(skill)

var _damage = 0;
_damage += skills[skill, StandSkill.Damage] + (owner.level * skills[skill, StandSkill.DamageScale]);
if (skills[skill, StandSkill.DamagePlayerStat])
{
    _damage += owner.dmg;
}
var _final_damage = _damage * powerMultiplier * GetRunesDamage();

return _final_damage;

#define GetDmgAlt(skill)

var _damage = 0;
_damage += skills[skill, StandSkill.DamageAlt] + (owner.level * skills[skill, StandSkill.DamageScaleAlt]);
if (skills[skill, StandSkill.DamagePlayerStatAlt])
{
    _damage += owner.dmg;
}
var _final_damage = _damage * powerMultiplier * GetRunesDamage();

return _final_damage;

#define ProjHitTarget(_target)

if (array_find_index(instancesHit, _target.id) == -1)
{
    if (onHitSound != noone)
    {
        if (audio_is_playing(onHitSound) and onHitSoundOverlap == false)
        {
            audio_stop_sound(onHitSound);
        }
        var _s = audio_play_sound(onHitSound, 0, false);
        audio_sound_pitch(_s, random_range(0.9, 1.1));
    }
    if (onHitEvent != noone)
    {
        script_execute(onHitEvent, onHitEventArg, undefined);
    }
    PunchEffectCreate(x, y);
    DustEntityAdd(x, y);
    var _dir = point_direction(x, y, _target.x, _target.y) - 180;
    // if (other.knockback > 0)
    // {
    //     KnockbackCreate(self, other.knockback, other.direction, other.knockbackDuration);
    // }
    _target.h = lengthdir_x(knockback, direction);
    _target.v = lengthdir_y(knockback, direction);
    if (_target.object_index == player)
    {
        DmgPlayer(damage / 10, true);
    }
    else
    {
        _target.hp -= damage;
    }
    array_push(instancesHit, _target.id);
    if (destroyOnImpact)
    {
        instance_destroy(self);
    }
}

#define ProjectileCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprBullet;
    mask_index = global.sprHitbox16x16;
    baseAnimSpd = 1;
    image_speed = baseAnimSpd;
    visible = false;
    type = "projectile";
    subtype = "projectile";
    owner = other;
    targets = other.targets;
    scale = 1;
    despawnFade = true;
    despawnTime = 5;
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
    onHitSound = sndHitMeat;
    onHitSoundOverlap = false;
    onHitEvent = noone;
    onHitEventArg = undefined;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ProjectileStep), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(ProjectileDestroy), false);
}
return _o;

#define ProjectileStep

if (!visible) { visible = true; }
depth = -y;

if (despawnFade)
{
    image_alpha = min(1, despawnTime);
}

if (global.timeIsFrozen and canDespawnInTs or !global.timeIsFrozen)
{
    despawnTime -= DT;
}
if (despawnTime <= 0)
{
    instance_destroy(self);
    exit;
}

if (instance_exists(self))
{
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
    
    try
    {
        for (var i = 0; i < array_length(targets); i++)
        {
            if (targets[i] = MOBJ)
            {
                with (targets[i])
                {
                    if (place_meeting(x, y, other) and bool("targetableFlag" in self))
                    {
                        with (other)
                        {
                            ProjHitTarget(other);
                        }
                    }
                }
            }
            else
            {
                with (targets[i])
                {
                    if (place_meeting(x, y, other) and scale != 0)
                    {
                        with (other)
                        {
                            ProjHitTarget(other);
                        }
                    }
                }
            }
        }
    }
    catch (e)
    {
        //Trace("error");
    }
}

#define ProjectileDestroy



#define BulletCreate(_x, _y, _dir, _dmg)

var _o = ProjectileCreate(_x, _y);
with (_o)
{
    subtype = "bullet";
    sprite_index = global.sprBullet;
    mask_index = global.sprBullet;
    direction = _dir;
    damage = _dmg
    baseSpd = 10;
    canMoveInTs = false;
    
    GlowOrderCreate(self, 0.1, c_yellow);
    InstanceAssignMethod(self, "step", ScriptWrap(BulletStep));
}
return _o;

#define BulletStep

image_xscale = max(1, spd);

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

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

var o = ModObjectSpawn(x, y, -1000);
with (o)
{
    type = "timestop";
    owner = other;
    targets = owner.targets;
    global.timeIsFrozen = true;
    resumeSound = global.sndTwTsResume;
    
    radiusGrow = true;
    growthTarget = 0;
    growth = 800;
    maxLength = _length;
    length = 0;
    whiteScreen = 0.1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(TimestopStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(TimestopDraw));
    InstanceAssignMethod(self, "destroy", ScriptWrap(TimestopDestroy));
}
return o;

#define TimestopStep

if (whiteScreen > 0)
{
    whiteScreen -= 1 / room_speed;
}

for (var i = 0; i < array_length(targets); i++)
{
    with (targets[i])
    {
        freeze = 5;
    }
}

if (instance_exists(objArrow))
{
    with (objArrow)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objBallistaArrow))
{
    with (objBallistaArrow)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objIceBolt))
{
    with (objIceBolt)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objDarkBeetProjectile))
{
    with (objDarkBeetProjectile)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objSkeletonBoomerang))
{
    with (objSkeletonBoomerang)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objToxicProjectile))
{
    with (objToxicProjectile)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objFireball))
{
    with (objFireball)
    {
        speed = lerp(speed, 0, 0.1);
    }
}
if (instance_exists(objVenomBolt))
{
    with (objVenomBolt)
    {
        speed = lerp(speed, 0, 0.1);
    }
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

if (instance_exists(objArrow))
{
    with (objArrow)
    {
        speed = 6;
    }
}
if (instance_exists(objBallistaArrow))
{
    with (objBallistaArrow)
    {
        speed = 5;
    }
}
if (instance_exists(objIceBolt))
{
    with (objIceBolt)
    {
        speed = 2;
    }
}
if (instance_exists(objDarkBeetProjectile))
{
    with (objDarkBeetProjectile)
    {
        speed = 3;
    }
}
if (instance_exists(objSkeletonBoomerang))
{
    with (objSkeletonBoomerang)
    {
        speed = 2;
    }
}
if (instance_exists(objToxicProjectile))
{
    with (objToxicProjectile)
    {
        speed = 2;
    }
}
if (instance_exists(objFireball))
{
    with (objFireball)
    {
        speed = 3;
    }
}
if (instance_exists(objVenomBolt))
{
    with (objVenomBolt)
    {
        speed = 2;
    }
}

audio_play_sound(resumeSound, 5, false);
with (MOBJ)
{
    if bool("type" in self)
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
    subtype = "punch";
    sprite_index = global.sprAttackPunch;
    image_blend = other.color;
    damage = _dmg;
    despawnFade = false;
    despawnTime = 0.1;
    canDespawnInTs = true;
    destroyOnImpact = false;
    direction = _dir;
    knockback = _knockback;
}
return _p;

#define StandBarrage(method, skill)

var _dir = owner.attack_direction;

xTo = objPlayer.x + lengthdir_x(GetStandReach(), _dir + random_range(-4, 4));
yTo = objPlayer.y + lengthdir_y(GetStandReach(), _dir + random_range(-4, 4));
image_xscale = mouse_x > objPlayer.x ? 1 : -1;

if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.08)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        PunchSwingCreate(xx, yy, _dir, 45, GetDmg(skill));
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += DT;
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
attackStateTimer += DT;

#define PunchSwingCreate(_x, _y, _dir, _ang, _dmg)

var _p = PunchCreate(_x, _y, _dir, _dmg, 1);
with (_p)
{
    direction += random_range(-_ang, _ang);
    //onHitSound = global.sndPunchHit;
    onHitSoundOverlap = true;
    swingSpd = 10;
    
    InstanceAssignMethod(self, "step", ScriptWrap(PunchSwingStep), true);
}
return _p;

#define PunchSwingStep

var pd = player.attack_direction;
var xx = x;
var yy = y;
if (instance_exists(owner))
{
    xx = owner.x + lengthdir_x(32, pd);
    yy = owner.y + lengthdir_y(32, pd);
}
pd = point_direction(x, y, xx, yy);
var dd = angle_difference(direction, pd);
direction -= min(abs(dd), swingSpd) * sign(dd);

#define StrongPunch(method, skill)

var _dir = 0;
var _xx = x;
var _yy = y;
if (instance_exists(owner))
{
    _dir = owner.attack_direction;
    
    _xx = owner.x + lengthdir_x(GetStandReach(), _dir);
    _yy = owner.y + lengthdir_y(GetStandReach(), _dir);
}
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
        break;
    case 1:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 3);
        _p.onHitSound = global.sndStrongPunch;
        FireCD(skill);
        state = StandState.Idle;
        break;
}
attackStateTimer += DT;

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
    
    if bool("hp" in target)
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
    time += DT;
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
    despawnTime = 20;
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
            var pd = owner.attack_direction;
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

#define GrabCreate(_xoffset, _yoffset)

var _o = ModObjectSpawn(STAND.x + _xoffset, STAND.y + _yoffset, 0);
with (_o)
{
    type = "grab";
    sprite_index = global.sprCoin;
    image_xscale = 2;
    image_yscale = 2;
    visible = false;
    
    xoffset = _xoffset;
    yoffset = _yoffset;
    life = 100;
    
    target = noone;
    grab = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GrabStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(GrabDestroy));
}

#define GrabStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

x = STAND.x + xoffset;
y = STAND.y + yoffset;

var _hit = instance_place(x, y, ENEMY);
if (_hit and !grab)
{
    audio_play_sound(global.sndPunchAir, 0, false);
    target = _hit;
    grab = true;
}

if (grab and instance_exists(target))
{
    target.behaviourEngage = false;
    target.x = x;
    target.y = y;
}

#define GrabDestroy

if (instance_exists(target))
{
    target.behaviourEngage = true;
}

