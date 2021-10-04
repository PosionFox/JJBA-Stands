
#define FireCD(skill)

altAttack = false;
attackState = 0;
attackStateTimer = 0;
skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown];
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

FireCD(skill);
skills[skill, StandSkill.Cooldown] = 0;

#define AttackHandler(method, skill)

ResetCD(skill);
state = StandState.Idle;

#define ProjectileCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprBullet;
    visible = false;
    type = "projectile";
    subtype = "projectile";
    owner = other.owner;
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
    onHitSound = global.sndPunchHit;
    onHitEvent = noone;
    
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
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
        else if (global.timeIsFrozen and canMoveInTs)
        {
            spd = baseSpd;
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
        else if (global.timeIsFrozen and !canMoveInTs)
        {
            spd = lerp(spd, 0, 0.15);
            x += lengthdir_x(spd, direction);
            y += lengthdir_y(spd, direction);
        }
    }
    
    with (parEnemy)
    {
        if (place_meeting(x, y, other))
        {
            if (array_find_index(other.instancesHit, id) == -1)
            {
                if (other.onHitSound != noone)
                {
                    var _s = audio_play_sound(other.onHitSound, 0, false);
                    audio_sound_pitch(_s, random_range(0.9, 1.1));
                }
                if (other.onHitEvent != noone)
                {
                    with (other)
                    {
                        script_execute(onHitEvent);
                    }
                }
                PunchEffectCreate(other.x, other.y);
                DustEntityAdd(other.x, other.y);
                var _dir = point_direction(x, y, other.x, other.y) - 180;
                h = lengthdir_x(other.knockback, _dir);
                v = lengthdir_y(other.knockback, _dir);
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
    var _o = ModObjectSpawn(x, y, depth);
    _o.type = "TsEnemy";
    _o.target = self;
    _o.sprite_index = sprite_index;
    _o.image_speed = 0;
    _o.image_index = image_index;
    _o.image_xscale = -image_xscale;
    _o.image_yscale = image_yscale;
    //_o.maxHp = maxHp;
    //_o.hp = hp;
    _o.damageStack = 0;
    InstanceAssignMethod(_o, "step", ScriptWrap(TsEnemyStep), false);
    InstanceAssignMethod(_o, "destroy", ScriptWrap(TsEnemyDestroy), false);
    instance_deactivate_object(self);
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
instance_activate_object(parEnemy);
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
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _dmg = 2 * (owner.level * 0.05);

xTo = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

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
        var _p = PunchCreate(xx, yy, ddir, _dmg, 0);
        _p.onHitSound = global.sndPunchHit;
        InstanceAssignMethod(_p, "step", ScriptWrap(StandBarrageStep), true);
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

if (keyboard_check_released(ord(skills[skill, StandSkill.Key])))
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
var xx = owner.x + lengthdir_x(32, pd);
var yy = owner.y + lengthdir_y(32, pd);
pd = point_direction(x, y, xx, yy);
var dd = angle_difference(direction, pd);
direction -= min(abs(dd), 10) * sign(dd);

#define StrongPunch(method, skill)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y)

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
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
        var _dmg = (skills[skill, StandSkill.Damage] * 0.2) * owner.level;
        var _p = PunchCreate(x, y, _dir, _dmg, 3);
        _p.onHitSound = global.sndStrongPunch;
        FireCD(skill);
        state = StandState.Idle;
        break;
}
attackStateTimer += 1 / room_speed;
