

#define ActorCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "Actor";
    sprite_index = sprPlayerIdle;
    
    level = 1;
    maxSpd = 1;
    dmg = 1;
    hpMax = 100;
    hp = hpMax;
    velocity = 0;
    h = 0;
    v = 0;
    scale = 1;
    facing = 1;
    freeze = 0;
    targets = [ENEMY, MOBJ];
    
    attackCD = 0;
    life = 60;
    state = "idle";
    canCollide = true;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ActorStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(ActorDraw), false);
}
return _o;

#define ActorStep

if (life <= 0)
{
    state = "destroy";
}
if (life > 0)
{
    life -= 1 / room_speed;
}
if (attackCD > 0)
{
    attackCD -= 1 / room_speed;
}

if (freeze > 0)
{
    freeze -= 1;
}

if (canCollide)
{
    // solid h
    if (place_meeting(x + h, y, parSolid))
    {
        while !(place_meeting(x + sign(h), y, parSolid))
        {
            x += sign(h);
        }
        h = 0;
    }
    // water h
    //var hSize = bbox_right - bbox_left;
    if (WaterCollision(x + h, y))
    {
        while !(WaterCollision(x + sign(h), y))
        {
            x += sign(h);
        }
        h = 0;
    }
    x += h;

    // solid v
    if (place_meeting(x, y + v, parSolid))
    {
        while !(place_meeting(x, y + sign(v), parSolid))
        {
            y += sign(v);
        }
        v = 0;
    }
    //var vSize = bbox_bottom - bbox_top;
    // water v
    if (WaterCollision(x, y + v))
    {
        while !(WaterCollision(x, y + sign(v)))
        {
            y += sign(v);
        }
        v = 0;
    }
    y += v;
}

var _a = instance_place(x, y, MOBJ);
if (instance_exists(_a) and "type" in _a)
{
    if (_a.type == "Actor" and id < _a.id)
    {
        var _dir = point_direction(x, y, _a.x, _a.y);
        h = lengthdir_x(-1, _dir);
        v = lengthdir_y(-1, _dir);
    }
}

depth = -y;

#define ActorDraw

draw_sprite_ext(sprShadow, 0, x, y + 3, image_xscale, image_yscale, 0, c_white, 0.5);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

#define ShaCreate(_x, _y)

jj_play_audio(global.sndSHA, 1, false);
var _o = ActorCreate(_x, _y);
with (_o)
{
    subtype = "SHA";
    sprite_index = global.sprSHA;
    image_xscale = 0.5;
    image_yscale = 0.5;
    maxSpd = 2;
    life = 20;

    InstanceAssignMethod(self, "step", ScriptWrap(ShaStep), true);
}

#define ShaStep

switch (state)
{
    case "idle":
        h = lengthdir_x(velocity, 0);
        v = lengthdir_y(velocity, 0);
        velocity = lerp(velocity, 0, 0.1);
        if (instance_exists(objPlayer))
        {
            var _dis = distance_to_point(objPlayer.x, objPlayer.y);
            if (_dis > 40)
            {
                state = "follow";
            }
        }
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            if (_dis < 128)
            {
                state = "chase";
            }
        }
    break;
    case "follow":
        if (instance_exists(objPlayer))
        {
            var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
            var _dis = distance_to_point(objPlayer.x, objPlayer.y);
            
            image_xscale = sign(dcos(_dir)) * 0.5;
            velocity = lerp(velocity, maxSpd, 0.1);
            mp_potential_step_object(player.x, player.y, velocity, parSolid);
            
            if (_dis < 16)
            {
                state = "idle";
            }
            if (_dis > 100)
            {
                state = "followSuper";
            }
        }
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            if (distance_to_object(_near) < 128)
            {
                state = "attack";
            }
        }
    break;
    case "chase":
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            if (_dis > 8)
            {
                image_xscale = sign(dcos(_dir)) * 0.5;
                velocity = lerp(velocity, maxSpd, 0.1);
                mp_potential_step_object(_near.x, _near.y, velocity, parSolid);
            }
            else if (_dis < 8)
            {
                state = "attack";
            }
        }
        else
        {
            state = "idle";
        }
    break;
    case "attack":
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_object(_near);
            
            velocity = lerp(velocity, 0, 0.1);
            
            if (attackCD <= 0)
            {
                ExplosionCreate(x, y, 32, false);
                attackCD = 2;
            }
            if (_dis > 10)
            {
                state = "chase";
            }
        }
        else
        {
            state = "idle";
        }
        if (instance_exists(objPlayer))
        {
            if (distance_to_object(objPlayer) > 200)
            {
                canCollide = false;
                state = "followSuper";
            }
        }
    break;
    case "followSuper":
        if (instance_exists(objPlayer))
        {
            canCollide = false;
            if (distance_to_object(objPlayer) > 16)
            {
                FireEffect(c_white, c_fuchsia);
                var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
                x += lengthdir_x(5, _dir);
                y += lengthdir_y(5, _dir);
            }
            else
            {
                canCollide = true;
                state = "idle";
            }
        }
    break;
    case "destroy":
        if (instance_exists(objPlayer))
        {
            image_xscale = 0.1;
            image_yscale = 0.1;
            FireEffect(c_white, c_fuchsia);
            canCollide = false;
            var _dir = point_direction(x, y, objPlayer.myStand.x, objPlayer.myStand.y);
            x += lengthdir_x(5, _dir);
            y += lengthdir_y(5, _dir);
            
            if (place_meeting(x, y, objPlayer.myStand))
            {
                instance_destroy(self);
            }
        }
    break;
}

#define ScorpionCreate(_x, _y)

var _o = ActorCreate(_x, _y);
with (_o)
{
    subtype = "scorpion";
    sprite_index = global.sprGeScorpion;
    image_speed = 0.05;
    maxSpd = 2;
    life = 20;

    InstanceAssignMethod(self, "step", ScriptWrap(ScorpionStep), true);
}

#define ScorpionStep

switch (state)
{
    case "idle":
        h = lengthdir_x(velocity, 0);
        v = lengthdir_y(velocity, 0);
        velocity = lerp(velocity, 0, 0.1);
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            if (_dis < 64)
            {
                state = "chase";
            }
        }
    break;
    case "chase":
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            image_xscale = sign(dcos(_dir));
            h = lengthdir_x(velocity, _dir);
            v = lengthdir_y(velocity, _dir);
            velocity = lerp(velocity, maxSpd, 0.1);
            if (_dis < 16)
            {
                state = "attack";
            }
        }
        else
        {
            state = "idle";
        }
    break;
    case "attack":
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            image_xscale = sign(dcos(_dir));
            h = lengthdir_x(velocity, _dir);
            v = lengthdir_y(velocity, _dir);
            velocity = lerp(velocity, 0, 0.1);
            if (attackCD <= 0)
            {
                var _p = ProjectileCreate(x, y);
                with (_p)
                {
                    owner = objPlayer;
                    sprite_index = global.sprAttackPunch;
                    image_alpha = 0;
                    direction = _dir;
                    damage = 2 + (objPlayer.level * 0.1) + (objPlayer.dmg);
                }
                attackCD = 1.25;
            }
            if (_dis > 32)
            {
                state = "chase";
            }
        }
        else
        {
            state = "idle";
        }
    break;
    case "destroy":
        image_alpha -= 0.05;
        image_xscale += 0.05;
        image_yscale -= 0.05;
        if (image_yscale <= 0)
        {
            instance_destroy(self);
        }
    break;
}

#define FrogCreate(_x, _y)

var _o = ActorCreate(_x, _y);
with (_o)
{
    subtype = "geFrog";
    sprite_index = global.sprGeFrog;
    life = 10;
    canCollide = false;
    state = "guard";

    InstanceAssignMethod(self, "step", ScriptWrap(FrogStep), true);
}

#define FrogStep

if (life <= 0)
{
    image_alpha -= 0.1;
    if (image_alpha <= 0)
    {
        instance_destroy(self);
        exit;
    }
}



switch (state)
{
    case "guard":
        var _xs = mouse_x > objPlayer.x ? 1 : -1;
        x = objPlayer.x + (_xs * 2);
        y = objPlayer.y;
        depth = objPlayer.depth - 1;
        image_yscale = -_xs;
        image_angle = 90;
        if (life <= 5)
        {
            state = "roam";
            y += 4;
        }
    break;
    case "roam":
        image_angle = lerp(image_angle, 0, 0.1);
    break;
}

#define CloneCreate(_x, _y)

var _o = ActorCreate(_x, _y);
with (_o)
{
    subtype = "clone";
    owner = other;
    state = "idle";
    color = c_white;
    target = noone;
    sprIdle = objPlayer.sprIdle;
    sprWalk = objPlayer.sprWalk;
    sprite_index = sprIdle;
    image_speed = objPlayer.image_speed;
    var _c = irandom(1);
    var _xs = [-1, 1];
    image_xscale = _xs[_c];
    image_yscale = 0;
    yscale = 1;
    sprHatIdle = objPlayer.sprHatIdle;
    sprBackIdle = objPlayer.sprBackIdle;
    sprWingsIdle = objPlayer.sprWingsIdle;
    sprHatWalk = objPlayer.sprHatWalk;
    sprBackWalk = objPlayer.sprBackWalk;
    sprWingsWalk = objPlayer.sprWingsWalk;
    
    hpMax = objPlayer.hpMax;
    hp = hpMax;
    damage = 1;
    life = 15;
    spawnRad = 16;
    
    var _cloneTypes = [
        CloneThugStep,
        CloneGunslingerStep
    ];
    var _type = irandom(array_length(_cloneTypes) - 1);
    
    InstanceAssignMethod(self, "step", ScriptWrap(_cloneTypes[_type]), true);
    InstanceAssignMethod(self, "draw", ScriptWrap(CloneDraw), false);
}
return _o;

#define CloneThugStep

image_yscale = lerp(image_yscale, yscale, 0.3);
spawnRad = lerp(spawnRad, 0, 0.1);
if (hp <= 0)
{
    state = "destroy";
}

if (instance_exists(objPlayer))
{
    if (place_meeting(x, y, objPlayer))
    {
        var _pdir = point_direction(x, y, objPlayer.x, objPlayer.y);
        h = lengthdir_x(-1, _pdir);
        v = lengthdir_y(-1, _pdir);
    }
}

switch (state)
{
    case "idle":
        h = lerp(h, 0, 0.1);
        v = lerp(v, 0, 0.1);
        
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            if (distance_to_object(_near) < 200 and _near.scale != 0)
            {
                target = _near;
                sprite_index = sprWalk;
                state = "chase";
            }
        }
    break;
    case "chase":
        if (instance_exists(target))
        {
            if (target.scale == 0) { state = "idle"; }
            if (distance_to_object(target) > 24)
            {
                image_xscale = target.x > x ? 1 : -1;
                var _dir = point_direction(x, y, target.x, target.y);
                velocity = lerp(velocity, maxSpd, 0.1);
                mp_potential_step_object(target.x, target.y, velocity, parSolid);
            }
            else
            {
                sprite_index = sprIdle;
                state = "attack";
            }
        }
        else
        {
            target = noone;
            state = "idle";
        }
    break;
    case "attack":
        h = lerp(h, 0, 0.1);
        v = lerp(v, 0, 0.1);
        if (instance_exists(target))
        {
            if (target.scale == 0) { state = "idle"; }
            if (distance_to_object(target) > 24)
            {
                sprite_index = sprWalk;
                state = "chase";
            }
            image_xscale = target.x > x ? 1 : -1;
            
            if (attackCD <= 0)
            {
                var _dir = point_direction(x, y, target.x, target.y);
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                audio_sound_gain(_snd, 0.3, 0);
                var _o = PunchCreate(x, y, _dir, damage, 0);
                with (_o)
                {
                    owner = objPlayer;
                    canMoveInTs = false;
                    destroyOnImpact = true;
                }
                attackCD = random_range(0.3, 0.6);
            }
        }
        else
        {
            target = noone;
            state = "idle";
        }
    break;
    case "destroy":
        FireEffect(c_white, c_aqua);
        yscale = 0;
        if (image_yscale <= 0)
        {
            instance_destroy(self);
        }
    break;
}

#define CloneGunslingerStep

image_yscale = lerp(image_yscale, yscale, 0.3);
spawnRad = lerp(spawnRad, 0, 0.1);

if (instance_exists(objPlayer))
{
    if (place_meeting(x, y, objPlayer))
    {
        var _pdir = point_direction(x, y, objPlayer.x, objPlayer.y);
        h = lengthdir_x(-1, _pdir);
        v = lengthdir_y(-1, _pdir);
    }
}

switch (state)
{
    case "idle":
        h = lerp(h, 0, 0.1);
        v = lerp(v, 0, 0.1);
        
        if (enemy_instance_exists())
        {
            var _near = get_nearest_enemy(x, y);
            if (distance_to_object(_near) < 256)
            {
                target = _near;
                state = "attack";
            }
        }
    break;
    case "attack":
        h = lerp(h, 0, 0.1);
        v = lerp(v, 0, 0.1);
        if (instance_exists(target))
        {
            if (target.scale == 0) { state = "idle"; }
            image_xscale = target.x > x ? 1 : -1;
            
            if (attackCD <= 0)
            {
                var _dir = point_direction(x, y, target.x, target.y);
                var _snd = jj_play_audio(global.sndGunShot, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                audio_sound_gain(_snd, 0.3, 0);
                var _o = ProjectileCreate(x, y);
                with (_o)
                {
                    owner = objPlayer;
                    direction = _dir;
                    baseSpd = 10;
                    sprite_index = global.sprBtdVoidTrace;
                    image_blend = c_yellow;
                    mask_index = global.sprKnife;
                    damage = other.damage;
                    canMoveInTs = false;
                    GlowOrderCreate(self, 0.1, c_yellow);
                }
                attackCD = 1;
            }
        }
        else
        {
            target = noone;
            state = "idle";
        }
    break;
    case "destroy":
        FireEffect(c_white, c_aqua);
        yscale = 0;
        if (image_yscale <= 0)
        {
            instance_destroy(self);
        }
    break;
}

#define CloneDraw

if (sprWingsIdle != noone)
{
    draw_sprite_ext(sprWingsIdle, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
if (sprBackIdle != noone)
{
    draw_sprite_ext(sprBackIdle, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (sprHatIdle != noone)
{
    draw_sprite_ext(sprHatIdle, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_set_color(c_teal);
draw_circle(x, y, spawnRad, false);
gpu_set_blendmode(bm_normal);

#define CloneBombCreate(_x, _y, _target)

if (!instance_exists(_target))
{
    exit;
}

var _a = ActorCreate(_x, _y);
with (_a)
{
    type = "cloneBomb";
    target = _target;
    sprIdle = target.sprIdle;
    sprWalk = target.sprWalk;
    sprite_index = target.sprite_index;
    
    life = 10;
    
    GlowOrderCreate(self, 0.1, c_yellow);
    InstanceAssignMethod(self, "step", ScriptWrap(CloneBombStep), true);
}
return _a;

#define CloneBombStep

switch (state)
{
    case "idle":
        if (instance_exists(target))
        {
            if (distance_to_object(target) < 256 and target.scale != 0)
            {
                if (sprWalk != -1)
                {
                    sprite_index = sprWalk;
                }
                state = "chase";
            }
        }
        else
        {
            state = "destroy";
        }
    break;
    case "chase":
        if (instance_exists(target))
        {
            if (target.scale == 0)
            {
                state = "idle";
            }
            var _dir = point_direction(x, y, target.x, target.y);
            h = lengthdir_x(1.5, _dir);
            v = lengthdir_y(1.5, _dir);
            image_xscale = sign(dcos(_dir));
            
            if (distance_to_object(target) < 8)
            {
                state = "destroy";
            }
        }
        else
        {
            state = "destroy";
        }
    break;
    case "destroy":
        ExplosionCreate(x, y, 32, true);
        instance_destroy(self);
    break;
}






