
#define BulletVolley(method, skill) //attacks

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

#define VolleyRefund //attack properties

var _skill = StandState.SkillC;
owner.myStand.skills[_skill, StandSkill.Cooldown] -= 1.5;
owner.myStand.skills[_skill, StandSkill.Cooldown] = clamp(
    owner.myStand.skills[_skill, StandSkill.Cooldown],
    0,
    owner.myStand.skills[_skill, StandSkill.MaxCooldown]
);

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
    amountRays = 12;
    InstanceAssignMethod(self, "step", ScriptWrap(LoveTrainStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(LoveTrainDraw), false);
    
    for (var i = 0; i < amountRays; i++)
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
range = lerp(range, 24, 0.08);
circRange = lerp(circRange, 0, 0.2);

if (instance_exists(objPlayer))
{
    x = objPlayer.x;
    y = objPlayer.y;
    for (var i = 0; i < amountRays; i++)
    {
        rays[i].x = x + lengthdir_x(range, (i * (360 / amountRays)) + current_time / rotSpeed);
        rays[i].y = y + lengthdir_y(range - 8, (i * (360 / amountRays)) + current_time / rotSpeed);
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

#define GiveD4CLT //stand

var _name = "D4C: Love Train";
var _sprite = global.sprD4C;
var _color = 0xe4cd5f;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.4;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CloneSummon;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneSummon;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = LoveTrain;
_skills[sk, StandSkill.Icon] = global.sprSkillLoveTrain;
_skills[sk, StandSkill.MaxCooldown] = 45;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndD4CSummon;

objPlayer.myStand.saveKey = "jjbamD4clt";
objPlayer.myStand.discType = global.jjbamDiscD4clt;
