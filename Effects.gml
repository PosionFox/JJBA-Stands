
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

#define BombEffect(_x, _y)

audio_play_sound(global.sndBomb, 0, false);
var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    depth = -y - 2;
    sprite_index = global.sprBombEffect;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BombEffectStep), false);
}

#define BombEffectStep

image_alpha -= 0.1;
if (image_alpha <= 0)
{
    instance_destroy(self);
}

#define ExplosionEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    life = 0.2;
    reachTarget = 32;
    reach = 0;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ExplosionEffectStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(ExplosionEffectDraw), false);
    
    repeat (8)
    {
        var xx, yy;
        xx = x + random_range(-reachTarget, reachTarget);
        yy = y + random_range(-reachTarget, reachTarget);
        ExplosionSmokeEffect(xx, yy);
    }
}

#define ExplosionEffectStep

reach = lerp(reach, reachTarget, 0.3);
image_alpha -= 0.1;

life -= 1 / room_speed;
if (life <= 0)
{
    instance_destroy(self);
}

#define ExplosionEffectDraw

gpu_set_blendmode(bm_add);
draw_set_alpha(image_alpha);
draw_set_color(c_red);
draw_circle(x, y, reach, false);
draw_set_color(c_yellow);
draw_circle(x, y, reach * 0.5, false);
draw_set_color(c_white);
draw_circle(x, y, reach * 0.25, false);
draw_set_color(image_blend);
gpu_set_blendmode(bm_normal);

#define ExplosionSmokeEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, -1);
with (_o)
{
    spd = random_range(0.3, 0.6);
    size = random(1);
    
    InstanceAssignMethod(self, "step", ScriptWrap(ExplosionSmokeStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(ExplosionSmokeDraw), false);
}

#define ExplosionSmokeStep

depth = -y;
size += 0.2;
y -= spd;
image_alpha -= 0.01;

if (image_alpha <= 0)
{
    instance_destroy(self);
}

#define ExplosionSmokeDraw

gpu_set_blendmode(bm_add);
draw_set_alpha(image_alpha);
draw_set_color(c_dkgray);
draw_circle(x, y, size, false);
draw_set_color(image_blend);
gpu_set_blendmode(bm_normal);

#define EffectCircleLerpCreate(_x, _y, _r, _t)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    radius = 0;
    radiusMax = _r;
    thickness = _t;
    growingSpd = 0.1;
    color = c_white;
    life = 1;
    lifeMulti = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectCircleLerpStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(EffectCircleLerpDraw), false);
}
return _o;

#define EffectCircleLerpStep

depth = -y;
radius = lerp(radius, radiusMax, growingSpd);
image_alpha = min(1, life);
life -= DT * lifeMulti;
if (life <= 0)
{
    instance_destroy(self);
}

#define EffectCircleLerpDraw

draw_set_alpha(image_alpha);
draw_set_color(color);
if (thickness == 0)
{
    draw_circle(x, y, radius, false);
}
else
{
    draw_circle_thick(x, y, radius, thickness);
}
gpu_set_blendmode(bm_normal);
draw_set_color(image_blend);

#define EffectCircleCreate(_x, _y, _r, _t)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    radius = 0;
    thickness = _t;
    growingSpd = 1;
    color = c_white;
    life = 1;
    lifeMulti = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectCircleStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(EffectCircleDraw), false);
}
return _o;

#define EffectCircleStep

depth = -y;
radius += growingSpd;
image_alpha = min(1, life);
life -= DT * lifeMulti;
if (life <= 0)
{
    instance_destroy(self);
}

#define EffectCircleDraw

draw_set_alpha(image_alpha);
draw_set_color(color);
if (thickness == 0)
{
    draw_circle(x, y, radius, false);
}
else
{
    draw_circle_thick(x, y, radius, 4);
}
gpu_set_blendmode(bm_normal);
draw_set_color(image_blend);

#define ShrinkingCircleEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    radius = 32;
    color = c_white;
    lerped = true;
    depth = -y - 10;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ShrinkingCircleStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(ShrinkingCircleDraw), false);
}
return _o;

#define ShrinkingCircleStep

if (radius <= 0)
{
    instance_destroy(self);
    exit;
}

if (lerped)
{
    radius = lerp(radius, 0, 0.1);
}
else
{
    radius -= 0.1 + (radius * 0.1);
}

#define ShrinkingCircleDraw

draw_set_color(color);
draw_circle(x, y, radius, false);
draw_set_color(image_blend);

#define LineEffect(_x1, _y1, _x2, _y2)

var _o = ModObjectSpawn(_x1, _y1, 0);
with (_o)
{
    x2 = _x2;
    y2 = _y2;
    color = c_white;
    width = 2;
    fadeRate = 0.1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(LineEffectStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(LineEffectDraw), false);
}
return _o;

#define LineEffectStep

if (image_alpha <= 0)
{
    instance_destroy(self);
    exit;
}
image_alpha -= fadeRate;

#define LineEffectDraw

draw_set_alpha(image_alpha);
draw_set_color(color);
draw_line_width(x, y, x2, y2, width);
draw_set_color(image_blend);

#define DimensionalHopEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    x1 = 0;
    x2 = display_get_gui_width()
    y1 = display_get_gui_height();
    y2 = y1;
    
    phase2 = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(DimensionalHopEffectStep), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(DimensionalHopEffectDrawGUI), false);
}
return _o;

#define DimensionalHopEffectStep

if (phase2)
{
    y2 = lerp(y2, 0, 0.4);
    if (y2 <= 0)
    {
        instance_destroy(self);
        exit;
    }
}
else
{
    y1 = lerp(y1, 0, 0.4);
    if (y1 <= 0)
    {
        phase2 = true;
    }
}

#define DimensionalHopEffectDrawGUI

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_set_color(c_teal);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);

#define LTPunishEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    depth = -y;
    
    width = 8;
    
    InstanceAssignMethod(self, "draw", ScriptWrap(LTPunishDraw), false);
}

#define LTPunishDraw

if (width <= 0)
{
    instance_destroy(self);
    exit;
}
width -= 0.5;

draw_line_width_color(x, y, x, y - 256, width, c_red, c_yellow);

#define EffectStandAuraCreate(_x, _y, _color)

var o = ModObjectSpawn(_x, _y, 0);
with (o)
{
    sprite_index = global.sprStandParticle;
    image_blend = _color;
    life = 20;
    x += random_range(-6, 6);
    y += random_range(-10, 2);
    hspd = random_range(-0.3, 0.3);
    vspd = -random(0.5);
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectStandAuraStep), false);
}
return o;

#define EffectStandAuraStep

x += hspd;
y += vspd;
image_alpha = life / 20;

if (life > 0)
{
    life--;
}
else
{
    instance_destroy(self);
}

#define EffectTimeSkipCreate

var o = ModObjectSpawn(0, 0, 0);
with (o)
{
    lineX = 0;
    lineW = 128;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectTimeSkipStep), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(EffectTimeSkipDrawGUI), false);
}
return o;

#define EffectTimeSkipStep

lineX += 128;
if (lineX - lineW * 4 > display_get_gui_width())
{
    instance_destroy(self);
}

#define EffectTimeSkipDrawGUI

draw_line_width_color(lineX, 0 - 32, lineX - 128, display_get_gui_height() + 32, lineW, c_fuchsia, c_red);
draw_set_alpha(0.75);
draw_line_width_color(lineX - lineW * 1, 0 - 32, (lineX - 128) - lineW * 1, display_get_gui_height() + 32, lineW, c_fuchsia, c_red);
draw_set_alpha(0.5);
draw_line_width_color(lineX - lineW * 2, 0 - 32, (lineX - 128) - lineW * 2, display_get_gui_height() + 32, lineW, c_fuchsia, c_red);
draw_set_alpha(0.25);
draw_line_width_color(lineX - lineW * 3, 0 - 32, (lineX - 128) - lineW * 3, display_get_gui_height() + 32, lineW, c_fuchsia, c_red);
draw_set_alpha(1);

#define EffectPlayerAfterimageCreate(_x, _y)

var o = ModObjectSpawn(_x, _y, 0);
with (o)
{
    sprIdle = objPlayer.sprIdle;
    sprWalk = objPlayer.sprWalk;
    sprHatIdle = objPlayer.sprHatIdle;
    sprBackIdle = objPlayer.sprBackIdle;
    sprWingsIdle = objPlayer.sprWingsIdle;
    sprHatWalk = objPlayer.sprHatWalk;
    sprBackWalk = objPlayer.sprBackWalk;
    sprWingsWalk = objPlayer.sprWingsWalk;
    sprite_index = player.sprite_index;
    image_index = player.image_index;
    image_speed = 0;
    image_blend = c_fuchsia;
    image_angle = player.angle;
    image_xscale = player.facing;
    image_yscale = player.yscale;
    life = 2;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectPlayerAfterimageStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(EffectPlayerAfterimageDraw), false);
}
return o;

#define EffectPlayerAfterimageStep(_x, _y)

image_alpha = min(0.5, life);
life -= DT;
if (life <= 0)
{
    instance_destroy(self);
}

#define EffectPlayerAfterimageDraw(_x, _y)

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

#define EffectArmChopCreate(_x, _y)

var o = ModObjectSpawn(_x, _y, 0);
with (o)
{
    sprite_index = global.sprStandParticle;
    image_blend = c_red;
    speed = random_range(1, 2);
    direction = random(360);
    life = 1;
    lifeMulti = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(EffectArmChopStep), false);
}
return o;

#define EffectArmChopStep

life -= DT * lifeMulti;
image_alpha = min(1, life);
if (life < 0)
{
    instance_destroy(self);
}


