
#define FireCD(skill)

attackState = 0;
if (max_energy > 0)
{
    if (altAttack)
    {
        skills[skill, StandSkill.CooldownAlt] = 0.1;
    }
    else
    {
        skills[skill, StandSkill.Cooldown] = 0.1;
    }
}
else
{
    if (altAttack)
    {
        skills[skill, StandSkill.CooldownAlt] = skills[skill, StandSkill.MaxCooldownAlt] / GetStandStamina(self);
    }
    else
    {
        skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown] / GetStandStamina(self);
    }
}
attackStateTimer = 0;
altAttack = false;
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

var _was_alt = altAttack;
FireCD(skill);
if (_was_alt)
{
    skills[skill, StandSkill.CooldownAlt] = 0;
}
else
{
    skills[skill, StandSkill.Cooldown] = 0;
}
if (max_energy > 0)
{
    energy += skills[skill, StandSkill.EnergyCost];
}

#define EndAtk(skill)

angleTarget = 0;
angleTargetSpd = 0.1;
scaleX = 1;
scaleY = 1;
scaleXSpd = 0.1;
scaleYSpd = 0.1;
height_speed = 0.2;
height_target = 0;
velocity = 0.5;

attackStateTimer = 0;
FireCD(skill);
state = StandState.Idle;

#define ResetAtk(skill)

angleTarget = 0;
angleTargetSpd = 0.1;
ResetCD(skill);
state = StandState.Idle;

#define AttackHandler(method, skill)

//ResetCD(skill);
state = StandState.Idle;

#define GetDmg(skill)

var _skillDamage = StandSkill.Damage;
var _skillDamageScale = StandSkill.DamageScale;
var _skillDamagePlayerStat = StandSkill.DamagePlayerStat;
if (altAttack)
{
    _skillDamage = StandSkill.DamageAlt;
    _skillDamageScale = StandSkill.DamageScaleAlt;
    _skillDamagePlayerStat = StandSkill.DamagePlayerStatAlt;
}

var _damage = 0;
_damage += skills[skill, _skillDamage] + ((level + owner.level) * skills[skill, _skillDamageScale]);
if (skills[skill, _skillDamagePlayerStat])
{
    _damage += owner.dmg;
}
var _final_damage = _damage * (powerMultiplier * GetStandDestructivePower(self)) * GetRunesDamage(self) * (1 + trait.damage) * (1 + (owner.myStand.combo / 100));

return _final_damage;

#define SetSkillVar(_skill, _name, _value)

var _var_type = StandSkill.Vars;
if (altAttack) _var_type = StandSkill.VarsAlt;
if (skills[_skill, _var_type] == undefined) skills[_skill, _var_type] = {};
variable_instance_set(skills[_skill, _var_type], _name, _value);

#define GetSkillVars(_skill, _name)

var _var_type = StandSkill.Vars;
if (altAttack) _var_type = StandSkill.VarsAlt;
var _vars = variable_instance_get(skills[_skill, _var_type], _name, undefined);
return _vars;

#define AttackCollisionDetect

if (col_cd <= 0)
{
    for (var i = array_length(targets) - 1; i >= 0; i--)
    {
        var obj = targets[i];
        var _hits = ds_list_create();
        collision_circle_list(x, y, col_size * scale, obj, false, true, _hits, false);
        
        var _hlen = ds_list_size(_hits);
        for (var j = _hlen - 1; j >= 0; j--)
        {
            var hit = _hits[| j];
            if (hit != noone)
            {
                var valid = (obj == MOBJ) ? ("targetableFlag" in hit) : (hit.scale != 0);
                if (valid)
                {
                    ProjHitTarget(hit);
                }
            }
        }
        ds_list_destroy(_hits);
    }
    col_cd = col_cd_max + (global.timeIsFrozen * 0.05);
}
col_cd -= DT;

#define ProjHitTarget(_target)

last_instance_hit = _target;
if (array_find_index(instancesHit, _target.id) == -1)
{
    if (onHitSound != noone)
    {
        if (is_array(onHitSound))
        {
            var _i = irandom(array_length(onHitSound) - 1);
            var _s = jj_play_audio(onHitSound[_i], 0, false);
            audio_sound_pitch(_s, random_range(0.9, 1.1));
        }
        else
        {
            if (audio_is_playing(onHitSound) and onHitSoundOverlap == false)
            {
                audio_stop_sound(onHitSound);
            }
            var _s = jj_play_audio(onHitSound, 0, false);
            audio_sound_pitch(_s, random_range(0.9, 1.1));
        }
    }
    if (onHitEvent != noone)
    {
        script_execute(onHitEvent, onHitEventArg, _target, undefined);
    }
    var _hx = random_range(_target.bbox_left, _target.bbox_right);
    var _hy = random_range(_target.bbox_top, _target.bbox_bottom);
    var _e = PunchEffectCreate(_hx, _hy);
    _e.depth = _target.depth - 1;
    if (crit_damage > 1)
    {
        _e.image_blend = c_red;
        _e.image_xscale = crit_damage;
        _e.image_yscale = crit_damage;
        var _sn = jj_play_audio(global.sndCritHit, 0, false);
        audio_sound_gain(_sn, global.jjSettAudioVolume * 0.5, 0);
    }
    DustEntityAdd(x, y);
    with (owner)
    {
        AddCombo();
    }
    var _dir = point_direction(x, y, _target.x, _target.y) - 180;
    // if (other.knockback > 0)
    // {
    //     KnockbackCreate(self, other.knockback, other.direction, other.knockbackDuration);
    // }
    _target.h = lengthdir_x(knockback, direction);
    _target.v = lengthdir_y(knockback, direction);
    if (_target.object_index == player)
    {
        DmgPlayer((damage / 10) * crit_damage, true);
    }
    else
    {
        _target.hp -= damage * crit_damage;
    }
    if (!multihit)
    {
        array_push(instancesHit, _target.id);
    }
    if (destroyOnImpact)
    {
        instance_destroy(self);
    }
}

#define RollCrit

var _cc = random(1);
if (_cc <= ((crit_chance + GetRunesCritChance(owner)) * GetStandPrecision(owner)))
{
    crit_damage = 2;
}

#define ProjectileCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprBullet;
    show_projectile = true;
    mask_index = global.sprHitbox16x16;
    col_size = 8;
    col_cd_max = 0.03;
    col_cd = 0;
    baseAnimSpd = 1;
    image_speed = baseAnimSpd;
    visible = false;
    depth_sort = true;
    type = "projectile";
    subtype = "projectile";
    owner = other;
    targets = other.targets;
    z = 5;
    z_grav = 0;
    rotation = 0;
    rotation_amount = 0;
    shadow_enabled = true;
    scale = 1;
    despawnFade = true;
    despawnTime = 5;
    baseSpd = 5;
    velocity = baseSpd;
    scale_with_velocity = false;
    spd_decay = 1;
    lerping_speed = 1;
    baseDamage = 0;
    damage = baseDamage;
    destroyOnImpact = true;
    destroy_in_water = true;
    last_instance_hit = undefined;
    instancesHit = [];
    multihit = false;
    stationary = false;
    distance = 0;
    rotate_with_direction = true;
    canMoveInTs = true;
    canDespawnInTs = false;
    knockback = 0;
    knockbackDuration = 0.5;
    onHitSound = sndHitMeat;
    onHitSoundOverlap = false;
    onHitEvent = noone;
    onHitEventArg = undefined;
    
    crit_chance = 0.02;
    crit_damage = 1;
    if (owner.type == "stand") RollCrit();
    
    InstanceAssignMethod(self, "step", ScriptWrap(ProjectileStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(ProjectileDraw), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(ProjectileDestroy), false);
}
return _o;

#define ProjectileStep

if (!visible) { visible = true; }
if (depth_sort) depth = -y;

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
if (x < -128 or x > room_width + 128 or y < -128 or y > room_height + 128)
{
    instance_destroy(self);
    exit;
}

if (instance_exists(self))
{
    if (rotate_with_direction) image_angle = direction;
    image_yscale = sign(dcos(image_angle));
    
    if (stationary and instance_exists(owner))
    {
        x = owner.x + lengthdir_x(distance, direction);
        y = owner.y + lengthdir_y(distance, direction);
    }
    else
    {
        if (!global.timeIsFrozen)
        {
            velocity = baseSpd;
            image_speed = baseAnimSpd;
            x = lerp(x, x + lengthdir_x(velocity, direction), lerping_speed);
            y = lerp(y, y + lengthdir_y(velocity, direction), lerping_speed);
            z -= z_grav;
            baseSpd *= spd_decay;
        }
        else if (global.timeIsFrozen and canMoveInTs)
        {
            velocity = baseSpd;
            image_speed = baseAnimSpd;
            x = lerp(x, x + lengthdir_x(velocity, direction), lerping_speed);
            y = lerp(y, y + lengthdir_y(velocity, direction), lerping_speed);
            z -= z_grav;
            baseSpd *= spd_decay;
        }
        else if (global.timeIsFrozen and !canMoveInTs)
        {
            velocity = lerp(velocity, 0, 0.15);
            image_speed = lerp(image_speed, 0, 0.1);
            x = lerp(x, x + lengthdir_x(velocity, direction), lerping_speed);
            y = lerp(y, y + lengthdir_y(velocity, direction), lerping_speed);
        }
    }
    z = clamp(z, 0, 99999);
    
    rotation += rotation_amount;
    
    if (scale_with_velocity)
    {
        image_xscale = max(1, velocity);
    }
    
    if (destroy_in_water and z <= 0 and WaterCollision(x, y))
    {
        despawnTime = 0;
    }
    
    try
    {
        // collision detection v3
        AttackCollisionDetect();
        
        // collision detection v2
        // for (var i = array_length(targets) - 1; i >= 0; i--)
        // {
        //     var obj = targets[i];
        //     var hit = instance_place(x, y, obj);
        //
        //     if (hit != noone)
        //     {
        //         var valid = (obj == MOBJ) ? ("targetableFlag" in hit) : (hit.scale != 0);
        //         if (valid)
        //         {
        //             ProjHitTarget(hit);
        //         }
        //     }
        // }
        
        // collision detection v1
        // for (var i = 0; i < array_length(targets); i++)
        // {
        //     if (targets[i] == MOBJ)
        //     {
        //         with (targets[i])
        //         {
        //             if (place_meeting(x, y, other) and bool("targetableFlag" in self))
        //             {
        //                 with (other)
        //                 {
        //                     ProjHitTarget(other);
        //                 }
        //             }
        //         }
        //     }
        //     else
        //     {
        //         with (targets[i])
        //         {
        //             if (place_meeting(x, y, other) and scale != 0)
        //             {
        //                 with (other)
        //                 {
        //                     ProjHitTarget(other);
        //                 }
        //             }
        //         }
        //     }
        // }
    }
    catch (e)
    {
        //Trace(e);
    }
}

#define ProjectileDraw

if (global.jjSettProjShadows and shadow_enabled)
{
    draw_sprite_ext(
        sprShadow,
        0,
        x,
        y,
        (sprite_width / sprite_get_width(sprShadow)) * scale,
        (sprite_height / sprite_get_height(sprShadow)) * scale,
        image_angle,
        c_white,
        image_alpha * 0.5
    );
}

if (show_projectile)
{
    draw_sprite_ext(
        sprite_index,
        image_index,
        x,
        y - z,
        image_xscale * scale,
        image_yscale * scale,
        image_angle + rotation,
        image_blend,
        image_alpha
    );
}

if (global.jjSettProjCollisions)
{
    
    draw_circle_color(x, y, col_size * scale, c_red, c_red, true);
    //draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, true);
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
    scale_with_velocity = true;
    
    GlowOrderCreate(self, 0.1, c_yellow);
}
return _o;

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

jj_play_audio(resumeSound, 5, false);
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

#define StandBarrage(m, s)

var _ext = GetStandExtension(self);
var _dir = owner.attack_direction + random_range(-32 * (1 / _ext), 32 * (1 / _ext));
xTo = owner.x + lengthdir_x(_ext, _dir);
yTo = owner.y + lengthdir_y(_ext, _dir);
image_xscale = look_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if barrageData.sound != noone jj_play_audio(barrageData.sound, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= (0.08 / GetStandSpeed(self)))
            {
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, owner.attack_direction, 45, GetDmg(s));
                with (_p)
                {
                    if other.barrageData.hitSound != noone onHitSound = other.barrageData.hitSound;
                    if other.barrageData.hitEvent != noone onHitEvent = other.barrageData.hitEvent;
                    if other.barrageData.hitEventArgs != noone onHitEventArg = other.barrageData.hitEventArgs;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])) or (stand_mode and gamepad_button_check_pressed(0, skills[s, StandSkill.GpBtn])))
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
        }
    break;
}
attackStateTimer += DT;

#define StandBarrageVars(m, s)

var _ext = GetStandExtension(self);
var _dir = owner.attack_direction + random_range(-32 * (1 / _ext), 32 * (1 / _ext));
xTo = owner.x + lengthdir_x(_ext, _dir);
yTo = owner.y + lengthdir_y(_ext, _dir);
image_xscale = look_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if GetSkillVars(s, "sound") != undefined jj_play_audio(GetSkillVars(s, "sound"), 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= (0.08 / GetStandSpeed(self)))
            {
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, owner.attack_direction, 45, GetDmg(s));
                var _hs = GetSkillVars(s, "hitSound");
                var _he = GetSkillVars(s, "hitEvent");
                var _hea = GetSkillVars(s, "hitEventArgs");
                with (_p)
                {
                    if _hs != undefined onHitSound = _hs;
                    if _he != undefined onHitEvent = _he;
                    if _hea != undefined onHitEventArg = _hea;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])) or (stand_mode and gamepad_button_check_pressed(0, skills[s, StandSkill.GpBtn])))
        {
            if GetSkillVars(s, "sound") != undefined audio_stop_sound(GetSkillVars(s, "sound"));
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            if GetSkillVars(s, "sound") != undefined audio_stop_sound(GetSkillVars(s, "sound"));
        }
    break;
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

var pd = direction;
var xx = x;
var yy = y;
if (instance_exists(owner))
{
    pd = owner.owner.attack_direction;
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
    
    _xx = owner.x + lengthdir_x(GetStandExtension(self), _dir);
    _yy = owner.y + lengthdir_y(GetStandExtension(self), _dir);
}
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        var _sc = GetSkillVars(skill, "cry_sound");
        if (_sc != undefined) jj_play_audio(_sc, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _hs = GetSkillVars(skill, "hit_sound");
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchSwingCreate(x, y, _dir, 45, GetDmg(skill));
        with (_p)
        {
            crit_change = 0.2;
            RollCrit();
            onHitSound = global.sndStrongPunch;
            if (_hs != undefined) onHitSound = _hs;
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.05) EndAtk(skill);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

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

#define BurnDamageCreate(_target, _dmg, _time, _percentageDamage)

var _o = ModObjectSpawn(_target.x, _target.y, _target.depth);
with (_o)
{
    target = _target;
    damage = _dmg;
    timeMax = _time;
    time = 0;
    percentageDamage = _percentageDamage;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BurnDamageStep), false);
}
return _o;

#define BurnDamageStep

if (instance_exists(target))
{
    x = target.x;
    y = target.y;
    FireEffect(c_red, c_yellow);
    
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

var _o = ModObjectSpawn(_x, _y, 0)
with (_o)
{
    type = "steelBall";
    sprite_index = global.sprSteelBallProj;
    direction = _dir;
    speed = 5;
    damage = _dmg;
    life = 5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(SteelBallStep))
}
return _o;

#define SteelBallStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

var _e = instance_place(x, y, ENEMY);
if (_e)
{
    _e.hp -= damage;
    EffectCircleCreate(x, y, 4, 2);
    jj_play_audio(global.sndPunchHit, 5, false);
    instance_destroy(self);
    exit;
}
var _r = instance_place(x, y, NATURAL);
if (_r)
{
    _r.hp -= damage;
    EffectCircleCreate(x, y, 4, 2);
    jj_play_audio(global.sndPunchHit, 5, false);
    instance_destroy(self);
    exit;
}

FireEffect(c_white, c_lime);
image_angle += speed * 5;

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
    life = 300;
    
    target = noone;
    grab = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GrabStep));
    InstanceAssignMethod(self, "destroy", ScriptWrap(GrabDestroy));
}
return _o;

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
    jj_play_audio(global.sndPunchAir, 0, false);
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

