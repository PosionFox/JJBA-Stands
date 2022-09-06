
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

#define GrowingCircleEffect(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    radius = 0;
    color = c_white;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GrowingCircleStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(GrowingCircleDraw), false);
}

#define GrowingCircleStep

depth = -y;
radius = lerp(radius, 32, 0.1);
image_alpha -= 0.02;
if (image_alpha <= 0)
{
    instance_destroy(self);
}

#define GrowingCircleDraw

draw_set_alpha(image_alpha);
draw_set_color(color);
draw_circle(x, y, radius, false);
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






