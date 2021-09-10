
#define FireCD(skill)

skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown];
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

skills[skill, StandSkill.Cooldown] = 0;
skills[skill, StandSkill.ExecutionTime] = 0;

#define ProjectileCreate(_spd, _dmg)

visible = false;
type = "projectile";
subtype = "projectile";
owner = other.owner;
baseSpd = _spd;
spd = baseSpd;
damage = _dmg;
destroyOnImpact = true;
instancesHit = [];
stationary = false;
distance = 0;
canMoveInTs = true;
canDespawnInTs = false;
knockback = 0;

if (owner.myStand.punchSprite != noone)
{
    sprite_index = owner.myStand.punchSprite;
}

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



#region Timestop

#define TimestopCreate(_length)

type = "timestop";
global.timeIsFrozen = true;
radiusGrow = true;
growthTarget = 800;
growth = 0;
maxLength = _length;
length = 0;

#define TimestopStep

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

if (growth > 790)
{
    radiusGrow = false;
}
//growth = clamp(growth, 0, 500);
if (radiusGrow)
{
    growthTarget = 800;
}
else
{
    growthTarget = 0;
}
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

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_circle(x, y, growth, false);
gpu_set_blendmode(bm_normal);

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

#endregion

#define ThrowPunch(_x, _y, _dir, _dmg, _knockback)

var _punch = ModObjectSpawn(_x, _y, 0);
_punch.sprite_index = global.sprTheWorldPunch;
_punch.despawnTime = room_speed * 0.1;

with (_punch) { ProjectileCreate(5, _dmg); }
_punch.canDespawnInTs = true;
_punch.destroyOnImpact = false;
_punch.direction = _dir;
_punch.knockback = _knockback;
InstanceAssignMethod(_punch, "step", ScriptWrap(ProjectileStep), false);
InstanceAssignMethod(_punch, "destroy", ScriptWrap(ProjectileDestroy), false);

#define StandBarrage(method, skill)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

image_xscale = mouse_x > owner.x ? 1 : -1;
if (distance_to_point(_xx, _yy) < 2)
{
    var xx = x + random_range(-8, 8);
    var yy = y + random_range(-8, 8);
    var ddir = _dir + random_range(-2, 2);
    var _dmg = (skills[skill, StandSkill.Damage] * 0.01) * (owner.level * 0.5);
    ThrowPunch(xx, yy, ddir, _dmg, 0);
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



#define StrongPunch(method, skill)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y)

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;
spd = 0.1;

if (distance_to_point(_xx, _yy) == 0)
{
    var _dmg = (skills[skill, StandSkill.Damage] * 0.2) * owner.level;
    ThrowPunch(x, y, _dir, _dmg, 3);
    FireCD(skill);
    spd = stats[StandStat.BaseSpd];
    state = StandState.Idle;
}

#define TripleKnifeThrow(method, skill)

for (var i = 1; i <= 3; i++)
{
    var _knife = ModObjectSpawn(owner.x, owner.y, 0);
    var _dir = (point_direction(owner.x, owner.y, mouse_x, mouse_y) - 16) + (i * 8);
    _knife.despawnTime = room_speed * 5;
    
    var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
    with (_knife) { ProjectileCreate(5, _dmg); }
    _knife.direction = _dir;
    _knife.canMoveInTs = false;
    _knife.sprite_index = global.sprKnife;
    InstanceAssignMethod(_knife, "step", ScriptWrap(ProjectileStep), false);
    InstanceAssignMethod(_knife, "destroy", ScriptWrap(ProjectileDestroy), false);
}
FireCD(skill);
state = StandState.Idle;

#define TimestopTw(method, skill)

var _tsExists = modInstanceExists("timestop");

if (_tsExists)
{
    instance_destroy(self);
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(9); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define TimestopSp(method, skill)

var _tsExists = modInstanceExists("timestop");

if (_tsExists)
{
    instance_destroy(self);
}

if (!_tsExists)
{
    audio_play_sound(global.sndSpTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(5); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define HorizontalSlash(method, skill)

FireCD(skill);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _slash = ModObjectSpawn(owner.x, owner.y, 0);
_slash.sprite_index = global.sprHorizontalSlash;
_slash.despawnTime = room_speed * 0.1;

with (_slash) { ProjectileCreate(0, 1); }
_slash.distance = 16;
_slash.direction = _dir;
_slash.stationary = true;
_slash.destroyOnImpact = false;
InstanceAssignMethod(_slash, "step", ScriptWrap(ProjectileStep), false);
InstanceAssignMethod(_slash, "destroy", ScriptWrap(ProjectileDestroy), false);
state = StandState.Idle;

