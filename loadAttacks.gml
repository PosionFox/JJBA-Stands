
#define FireCD(skill)

attackState = 0;
attackStateTimer = 0;
skills[skill, StandSkill.Cooldown] = skills[skill, StandSkill.MaxCooldown];
skills[skill, StandSkill.ExecutionTime] = 0;

#define ResetCD(skill)

FireCD(skill);
skills[skill, StandSkill.Cooldown] = 0;

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



#region Timestop

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

#endregion

#define PunchCreate(_x, _y, _dir, _dmg, _knockback)

var _p = ProjectileCreate(_x, _y);
with (_p)
{
    sprite_index = other.punchSprite;
    damage = _dmg;
    despawnTime = room_speed * 0.1;
    canDespawnInTs = true;
    destroyOnImpact = false;
    direction = _dir;
    knockback = _knockback;
}
return _p;

#define PunchEffectCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    depth = -y;
    sprite_index = global.sprPunchEffect;
    image_index = 0;
    InstanceAssignMethod(self, "step", ScriptWrap(PunchEffectStep), false);
}

#define PunchEffectStep

if (image_index >= image_number - 1)
{
    instance_destroy(self);
}

#define StandBarrage(method, skill)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir + random_range(-4, 4));
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(_xx, _yy) < 2)
{
    if (attackStateTimer >= 0.1)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-8, 8);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-2, 2);
        var _dmg = (skills[skill, StandSkill.Damage] * 0.01) * (owner.level * 0.5);
        var _p = PunchCreate(xx, yy, ddir, _dmg, 0);
        _p.onHitSound = global.sndPunchHit;
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

#define KnifeBarrage(method, skill)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(_xx, _yy) < 2)
{
    if (attackStateTimer >= 0.1)
    {
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-8, 8);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-2, 2);
        var _dmg = (skills[skill, StandSkill.Damage] * 0.02) * (owner.level);
        var _p = ProjectileCreate(xx, yy);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = _dmg;
            direction = _dir
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprKnife;
        }
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

#define GunShot(method, skill)

var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    sprite_index = global.sprBullet;
    despawnTime = room_speed * 5;
    damage = _dmg;
    direction = _dir;
    canMoveInTs = false;
}
FireCD(skill)
state = StandState.Idle;

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

#define TripleKnifeThrow(method, skill)

for (var i = 1; i <= 3; i++)
{
    var _dir = (point_direction(owner.x, owner.y, mouse_x, mouse_y) - 16) + (i * 8);
    var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
    
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnife;
    }
}
FireCD(skill);
state = StandState.Idle;

#define TimestopTw(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
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

#define TimestopTwAu(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwAuTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(5); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define TimestopSp(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
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

#define TimestopSTW(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndStwTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(2); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define StarFinger(method, skill)

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

if (distance_to_point(_xx, _yy) <= 1)
{
    if (!modSubtypeExists("starFinger"))
    {
        var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * (owner.level * 0.5);
        
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            sprite_index = global.sprStarPlatinumFinger;
            damage = _dmg;
            stationary = true;
            canDespawnInTs = true;
            destroyOnImpact = false;
            direction = _dir;
            despawnTime = room_speed * 0.7;
            fingerSize = 0;
            InstanceAssignMethod(self, "draw", ScriptWrap(StarFingerDraw), false);
        }
    }
    else
    {
        with (objModEmpty)
        {
            if ("subtype" in self)
            {
                if (subtype == "starFinger")
                {
                    fingerSize = lerp(fingerSize, 120, 0.1);
                    var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
                    direction = _dir;
                    
                    var x2 = owner.x + lengthdir_x(fingerSize, direction);
                    var y2 = owner.y + lengthdir_y(fingerSize, direction);
                    var _col = collision_line(owner.x, owner.y, x2, y2, parEnemy, false, true);
                    var _colTs = collision_line(owner.x, owner.y, x2, y2, objModEmpty, false, true);
                    
                    if (_col)
                    {
                        with (_col)
                        {
                            if (array_find_index(other.instancesHit, id) == -1)
                            {
                                var _dir = point_direction(x, y, other.x, other.y) - 180;
                                h -= lengthdir_x(other.knockback, _dir);
                                v -= lengthdir_y(other.knockback, _dir);
                                hp -= other.damage;
                                array_push(other.instancesHit, id);
                                if (other.destroyOnImpact)
                                {
                                    instance_destroy(other);
                                }
                            }
                        }
                    }
                    if (_colTs)
                    {
                        with (_colTs)
                        {
                            if ("type" in self)
                            {
                                if (type == "TsEnemy")
                                {
                                    damageStack += 0.1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

#define StarFingerDraw

//draw_set_color(c_purple);
var ox = owner.myStand.x;
var oy = owner.myStand.y;
var w = fingerSize / sprite_get_width(sprite_index);

var xx = ox + lengthdir_x(w, direction);
var yy = oy + lengthdir_y(w, direction);
draw_sprite_ext(sprite_index, 0, xx, yy, w, 1, image_angle, image_blend, image_alpha);
//draw_line_width(x, y, owner.myStand.x, owner.myStand.y, 2);
//draw_set_color(image_blend);

#define LoveTrain(method, skill)

if (!modTypeExists("loveTrain"))
{
    LoveTrainCreate(15);
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill)
    state = StandState.Idle;
}

#define LoveTrainCreate(_length)

audio_play_sound(global.sndLtStart, 5, false);
var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, 0)
with (_o)
{
    depth = -1000;
    type = "loveTrain";
    size = 1;
    length = _length;
    rotSpeed = 0;
    range = 500;
    circRange = 500;
    InstanceAssignMethod(self, "step", ScriptWrap(LoveTrainStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(LoveTrainDraw), false);
    
    for (var i = 0; i < 8; i++)
    {
        rays[i] = ModObjectSpawn(x, y, 0);
        rays[i].width = 1;
        rays[i].height = 1;
        InstanceAssignMethod(rays[i], "step", ScriptWrap(LoveTrainRayStep), false);
        InstanceAssignMethod(rays[i], "draw", ScriptWrap(LoveTrainRayDraw), false);
    }
}

#define LoveTrainStep

if (!audio_is_playing(global.sndLtStart) and !audio_is_playing(global.sndLtLoop))
{
    audio_play_sound(global.sndLtLoop, 5, true);
}

size *= 1.1;
size = clamp(size, 0, 1000);
rotSpeed = lerp(rotSpeed, 100, 0.05);
range = lerp(range, 16, 0.08);
circRange = lerp(circRange, 0, 0.2);

if (instance_exists(objPlayer))
{
    x = objPlayer.x;
    y = objPlayer.y;
    for (var i = 0; i < 8; i++)
    {
        rays[i].x = x + lengthdir_x(range, (i * 45) + current_time / rotSpeed);
        rays[i].y = y + lengthdir_y(range, (i * 45) + current_time / rotSpeed);
    }
}

length -= 1 / room_speed;
if (length <= 0)
{
    audio_stop_sound(global.sndLtLoop);
    audio_play_sound(global.sndLtEnd, 5, false);
    instance_destroy(self);
}

#define LoveTrainDraw

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_set_color(c_teal);
draw_circle(x, y, circRange, false);
draw_set_color(image_blend);
gpu_set_blendmode(bm_normal);

#define LoveTrainRayStep

depth = -y;

if (modTypeExists("loveTrain"))
{
    height *= 1.1;
    height = clamp(height, 0, 1000);
    width = cos(current_time / 1000) * 2;
}
else
{
    height *= 0.9;
    if (height <= 0)
    {
        instance_destroy(self);
    }
}

#define LoveTrainRayDraw

gpu_set_blendmode(bm_add);
draw_set_alpha(0.5);
draw_set_color(c_yellow);
draw_line_width(x, y, x, y - height, width);
draw_set_color(image_blend);
draw_set_alpha(image_alpha);
gpu_set_blendmode(bm_normal);

#define BulletVolley(method, skill)

var _dmg = (stats[StandStat.AttackDamage] * 0.1) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir - 180);
yTo = owner.y + lengthdir_y(8, _dir - 180);

if (attackStateTimer == 0)
{
    var _snd = audio_play_sound(global.sndGunShot, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    audio_sound_gain(_snd, 0.5, 0);
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        sprite_index = global.sprBullet;
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        onHitEvent = VolleyRefund;
    }
}
attackStateTimer += 1 / room_speed;
if (attackStateTimer >= 0.15)
{
    attackStateTimer = 0;
    attackState++;
}
if (attackState >= 3)
{
    FireCD(skill);
    state = StandState.Idle;
}

#define VolleyRefund

var _skill = StandState.SkillC;
owner.myStand.skills[_skill, StandSkill.Cooldown] -= 1.5;
owner.myStand.skills[_skill, StandSkill.Cooldown] = clamp(
    owner.myStand.skills[_skill, StandSkill.Cooldown],
    0,
    owner.myStand.skills[_skill, StandSkill.MaxCooldown]
);

#define ComboDash(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.05) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        owner.h += lengthdir_x(4, _dir);
        owner.v += lengthdir_y(4, _dir);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchCreate(x, y, _dir, _dmg, 0);
        with (_p)
        {
            onHitEvent = KnifeCoffin;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define BackDashKnife(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.15) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

owner.h -= lengthdir_x(4, _dir);
owner.v -= lengthdir_y(4, _dir);
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    despawnTime = room_speed * 5;
    damage = _dmg;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = global.sprKnifeStw;
}
skills[skill, StandSkill.MaxCooldown] = 1;
skills[skill, StandSkill.Icon] = global.sprSkillRadialKnife;
FireCD(skill);
skills[skill, StandSkill.Skill] = RadialKnife;
state = StandState.Idle;

#define RadialKnife(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var _k = 8;
for (var i = 0; i <= _k; i++)
{
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir + (i * (360 / _k));
        canMoveInTs = false;
        sprite_index = global.sprKnifeStw;
    }
}
skills[skill, StandSkill.MaxCooldown] = 3;
skills[skill, StandSkill.Icon] = global.sprSkillBackDashKnife;
FireCD(skill);
skills[skill, StandSkill.Skill] = BackDashKnife;
state = StandState.Idle;

#define KnifeCoffin(_x, _y)
var _dmg = (owner.myStand.stats[StandStat.AttackDamage] * 0.02) * owner.level;
//var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _target = owner;
if (instance_exists(parEnemy))
{
    _target = instance_nearest(x, y, parEnemy);
}

var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var _k = 8;
for (var i = 0; i <= _k; i++)
{
    var _xx = _target.x + lengthdir_x(64, i * (360 / _k));
    var _yy = _target.y + lengthdir_y(64, i * (360 / _k));
    var _p = ProjectileCreate(_xx, _yy);
    with (_p)
    {
        var _dir = (i * (360 / _k)) - 180;
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnifeStw;
    }
}

#define TripleCombo(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        owner.h += lengthdir_x(2, _dir);
        owner.v += lengthdir_y(2, _dir);
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = _dmg;
            direction = _dir;
            canMoveInTs = false;
            sprite_index = global.sprKnifeStw;
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        owner.h += lengthdir_x(1, _dir);
        owner.v += lengthdir_y(1, _dir);
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchCreate(x, y, _dir + random_range(-8, 8), _dmg, 0);
        PunchCreate(x, y, _dir + random_range(-8, 8), _dmg, 0);
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 4:
        owner.h -= lengthdir_x(3, _dir);
        owner.v -= lengthdir_y(3, _dir);
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = _dmg;
            direction = _dir;
            canMoveInTs = false;
            sprite_index = global.sprKnifeStw;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define CloneSummon(method, skill)
var _dmg = (stats[StandStat.AttackDamage] * 0.02) * owner.level;
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

attackStateTimer += 1 / room_speed;
switch (attackState)
{
    case 0:
        audio_play_sound(global.sndCloneSummon, 1, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        var _xx = x + lengthdir_x(8, _dir);
        var _yy = y + lengthdir_y(8, _dir);
        var _o = CloneCreate(_xx, _yy);
        _o.damage = _dmg
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define CloneCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    owner = other;
    sprite_index = objPlayer.sprIdle;
    image_speed = objPlayer.image_speed;
    var _c = irandom(1);
    var _xs = [-1, 1];
    image_xscale = _xs[_c];
    image_yscale = 0;
    yscale = 1;
    sprHatIdle = objPlayer.sprHatIdle;
    sprBackIdle = objPlayer.sprBackIdle;
    depth = -y;
    
    damage = 1;
    life = 15;
    gunMaxCD = 1;
    gunCD = gunMaxCD;
    spawnRad = 16;
    
    InstanceAssignMethod(self, "step", ScriptWrap(CloneStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(CloneDraw), false);
}
return _o;

#define CloneStep

image_yscale = lerp(image_yscale, yscale, 0.3);
spawnRad = lerp(spawnRad, 0, 0.1);

gunCD -= 1 / room_speed;
if (instance_exists(parEnemy))
{
    var _t = instance_nearest(x, y, parEnemy);
    image_xscale = _t.x > x ? 1 : -1;
    
    if (gunCD <= 0)
    {
        var _dir = point_direction(x, y, _t.x, _t.y);
        var _snd = audio_play_sound(global.sndGunShot, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        audio_sound_gain(_snd, 0.3, 0);
        var _o = ProjectileCreate(x, y);
        with (_o)
        {
            owner = other.owner;
            direction = _dir;
            damage = other.damage;
        }
        gunCD = gunMaxCD;
    }
}
life -= 1 / room_speed;
if (life <= 0)
{
    yscale = 0;
}
if (image_yscale <= 0)
{
    instance_destroy(self);
}

#define CloneDraw

if (sprBackIdle != noone)
{
    draw_sprite_ext(sprBackIdle, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
draw_self();
if (sprHatIdle != noone)
{
    draw_sprite_ext(sprHatIdle, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_set_color(c_teal);
draw_circle(x, y, spawnRad, false);
gpu_set_blendmode(bm_normal);

#define HorizontalSlash(method, skill)

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    sprite_index = global.sprHorizontalSlash;
    despawnTime = room_speed * 0.1;
    distance = 16;
    direction = _dir;
    stationary = true;
    destroyOnImpact = false;
}
FireCD(skill);
state = StandState.Idle;

