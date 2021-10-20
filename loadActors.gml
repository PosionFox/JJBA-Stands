

#define ActorCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "Actor";
    sprite_index = sprPlayerIdle;
    
    maxSpd = 1;
    spd = 0;
    h = 0;
    v = 0;
    
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

depth = -y;

#define ActorDraw

draw_sprite_ext(sprShadow, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.5);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

#define ShaCreate(_x, _y)

audio_play_sound(global.sndSHA, 1, false);
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
        h = lengthdir_x(spd, 0);
        v = lengthdir_y(spd, 0);
        spd = lerp(spd, 0, 0.1);
        if (instance_exists(objPlayer))
        {
            var _dis = distance_to_point(objPlayer.x, objPlayer.y);
            if (_dis > 40)
            {
                state = "follow";
            }
        }
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
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
            h = lengthdir_x(spd, _dir);
            v = lengthdir_y(spd, _dir);
            spd = lerp(spd, maxSpd, 0.1);
            
            if (_dis < 16)
            {
                state = "idle";
            }
            if (_dis > 100)
            {
                state = "followSuper";
            }
        }
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            if (distance_to_object(_near) < 128)
            {
                state = "attack";
            }
        }
    break;
    case "chase":
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            if (_dis > 8)
            {
                image_xscale = sign(dcos(_dir)) * 0.5;
                h = lengthdir_x(spd, _dir);
                v = lengthdir_y(spd, _dir);
                spd = lerp(spd, maxSpd, 0.1);
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
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_object(_near);
            
            h = lengthdir_x(spd, _dir);
            v = lengthdir_y(spd, _dir);
            spd = lerp(spd, 0, 0.1);
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
        h = lengthdir_x(spd, 0);
        v = lengthdir_y(spd, 0);
        spd = lerp(spd, 0, 0.1);
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dis = distance_to_point(_near.x, _near.y);
            
            if (_dis < 64)
            {
                state = "chase";
            }
        }
    break;
    case "chase":
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            image_xscale = sign(dcos(_dir));
            h = lengthdir_x(spd, _dir);
            v = lengthdir_y(spd, _dir);
            spd = lerp(spd, maxSpd, 0.1);
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
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_point(_near.x, _near.y);
            
            image_xscale = sign(dcos(_dir));
            h = lengthdir_x(spd, _dir);
            v = lengthdir_y(spd, _dir);
            spd = lerp(spd, 0, 0.1);
            if (attackCD <= 0)
            {
                var _p = ProjectileCreate(x, y);
                with (_p)
                {
                    owner = objPlayer;
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
    life = 5;
    canCollide = false;

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

var _xs = mouse_x > objPlayer.x ? 1 : -1;
x = objPlayer.x + (_xs * 2);
y = objPlayer.y;
depth = objPlayer.depth - 1;
image_yscale = -_xs;
image_angle = 90;



