
#define FireCD(skill)

skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown];
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

skills[skill, StandSkill.Cooldown] = 0;

#define ProjectileCreate(_spd, _dmg)

label = "projectile";
owner = other.owner;
baseSpd = _spd;
spd = baseSpd;
damage = _dmg;
destroyOnImpact = true;
instancesHit = [];
stationary = false;
distance = 0;
canMoveInTs = true;

#define ProjectileStep

depth = -y;

if (!global.timeIsFrozen)
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
    
    with (parEnemy) {
        if (place_meeting(x, y, other)) {
            if (array_find_index(other.instancesHit, id) == -1) {
                hp -= other.damage;
                array_push(other.instancesHit, id);
                if (other.destroyOnImpact) {
                    instance_destroy(other);
                }
            }
        }
    }
}

#define ProjectileDestroy



#region Timestop

#define TimestopCreate

audio_play_sound(global.sndTwTs, 5, false);
type = "timestop";
global.timeIsFrozen = true;
radiusGrow = true;
growthTarget = 800;
growth = 0;
maxLength = 9;
length = 0;
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
}
instance_deactivate_object(parEnemy);

#define TimestopStep

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
growth = lerp(growth, growthTarget, 0.1);
with (objModEnemy)
{
    var _col = instance_place(x, y, objEmpty);
    if ("projectile" in _col)
    {
        //damageStack += _col.damage;
    }
}
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
        if (_col.type == "knife")
        {
            damageStack += _col.damage;
        }
    }
}

#define TsEnemyDestroy

target.hp -= damageStack;

#endregion

#define ThrowPunch(_x, _y, dir, dmg)

var _punch = ModObjectSpawn(_x, _y, 0);
_punch.sprite_index = global.sprTheWorldPunch;
_punch.despawnTime = room_speed * 0.1;

with (_punch) { ProjectileCreate(5, dmg); }
_punch.destroyOnImpact = false;
_punch.direction = dir;
InstanceAssignMethod(_punch, "step", ScriptWrap(ProjectileStep), false);
InstanceAssignMethod(_punch, "destroy", ScriptWrap(ProjectileDestroy), false);

#define StandBarrage(method, skill)

if (instance_exists(parEnemy))
{
    var _t = instance_nearest(mouse_x, mouse_y, parEnemy);
    var _dis = point_distance(owner.x, owner.y, _t.x, _t.y);
    var _dir = point_direction(owner.x, owner.y, _t.x, _t.y);
    
    if (_dis < stats[StandStat.Range])
    {
        target = _t;
        spd = 0.1;
        xTo = owner.x + lengthdir_x(_dis - 16, _dir);
        yTo = owner.y + lengthdir_y(_dis - 16, _dir);
        if (distance_to_object(target) < stats[StandStat.AttackRange])
        {
            var xx = x + random_range(-8, 8);
            var yy = y + random_range(-8, 8);
            var ddir = _dir + random_range(-2, 2);
            var _dmg = (skills[skill, StandSkill.Damage] * 0.01) * (owner.level * 0.5);
            ThrowPunch(xx, yy, ddir, _dmg);
            skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
        }
    }
    else
    {
        target = noone;
        spd = stats[StandStat.BaseSpd];
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
    if (keyboard_check_released(ord(skills[skill, StandSkill.Key])))
    {
        target = noone;
        spd = stats[StandStat.BaseSpd];
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
}
else
{
    target = noone;
    spd = stats[StandStat.BaseSpd];
    ResetCD(skill);
    state = StandState.Idle;
}

#define StrongPunch(method, skill)

if (instance_exists(parEnemy)) {
    var _t = instance_nearest(mouse_x, mouse_y, parEnemy);
    var _dis = point_distance(owner.x, owner.y, _t.x, _t.y);
    if (_dis < stats[StandStat.Range]) {
        target = _t;
        spd = 0.1;
        xTo = target.x;
        yTo = target.y;
        if (distance_to_object(target) < stats[StandStat.AttackRange]) {
            var _dmg = (skills[skill, StandSkill.Damage] * 0.2) * owner.level;
            target.hp -= _dmg;
            var _dir = point_direction(owner.x, owner.y, target.x, target.y);
            target.h = lengthdir_x(3, _dir);
            target.v = lengthdir_y(3, _dir);
            target = noone;
            spd = stats[StandStat.BaseSpd];
            FireCD(skill);
            state = StandState.Idle;
        }
    } else {
        ResetCD(skill);
        state = StandState.Idle;
    }
} else {
    ResetCD(skill);
    state = StandState.Idle;
}

#define TripleKnifeThrow(method, skill)

for (var i = 1; i <= 3; i++)
{
    var _knife = ModObjectSpawn(owner.x, owner.y, 0);
    _knife.sprite_index = global.sprKnife;
    var _dir = (point_direction(owner.x, owner.y, mouse_x, mouse_y) - 16) + (i * 8);
    _knife.despawnTime = room_speed * 5;
    _knife.type = "knife";
    
    var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
    with (_knife) { ProjectileCreate(5, _dmg); }
    _knife.direction = _dir;
    _knife.canMoveInTs = false;
    InstanceAssignMethod(_knife, "step", ScriptWrap(ProjectileStep), false);
    InstanceAssignMethod(_knife, "destroy", ScriptWrap(ProjectileDestroy), false);
}
FireCD(skill);
state = StandState.Idle;

#define Timestop(method, skill)

var _tsExists = false;
with (objModEmpty)
{
    if ("type" in self)
    {
        if (type == "timestop")
        {
            _tsExists = true;
            instance_destroy(self);
        }
    }
}

if (!_tsExists)
{
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(); }
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

