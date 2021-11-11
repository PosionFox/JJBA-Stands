
#define TrickShot(method, skill)
var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * objPlayer.level;
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    type = "bulletTime";
    prevSkill = skill;
    audio_play_sound(global.sndGunShot, 0, false);
    sprite_index = global.sprBullet;
    despawnTime = room_speed * 5;
    damage = _dmg;
    direction = _dir;
    canMoveInTs = false;
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(TrickShotDestroy), true);
}
skills[skill, StandSkill.Skill] = BulletTime;
skills[skill, StandSkill.MaxCooldown] = 0.5;
skills[skill, StandSkill.Icon] = global.sprSkillPunishment;
FireCD(skill)
state = StandState.Idle;

#define BulletTime(method, skill)

var _o = modTypeFind("bulletTime");
if (_o)
{
    if (instance_exists(parEnemy))
    {
        var _near = instance_nearest(_o.x, _o.y, parEnemy);
        _o.direction = point_direction(_o.x, _o.y, _near.x, _near.y);
    }
}
skills[skill, StandSkill.Skill] = TrickShot;
skills[skill, StandSkill.MaxCooldown] = 5;
skills[skill, StandSkill.Icon] = global.sprSkillGunShot;
FireCD(skill)
state = StandState.Idle;

#define BulletVolley(method, skill) //attacks

var _dmg = (stats[StandStat.AttackDamage] * 0.1) * objPlayer.level;
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir - 180);
yTo = objPlayer.y + lengthdir_y(8, _dir - 180);

if (attackStateTimer == 0)
{
    var _snd = audio_play_sound(global.sndGunShot, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    audio_sound_gain(_snd, 0.5, 0);
    var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
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
var _dmg = (stats[StandStat.AttackDamage] * 0.02) * objPlayer.level;
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

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

#define DimensionalHop(method, skill)

DimensionalHopCreate(x, y)
ResetCD(skill);
state = StandState.Idle;

#define VolleyRefund //attack properties

var _skill = StandState.SkillC;
objPlayer.myStand.skills[_skill, StandSkill.Cooldown] -= 1.5;
objPlayer.myStand.skills[_skill, StandSkill.Cooldown] = clamp(
    objPlayer.myStand.skills[_skill, StandSkill.Cooldown],
    0,
    objPlayer.myStand.skills[_skill, StandSkill.MaxCooldown]
);

#define TrickShotDestroy

if (instance_exists(objPlayer))
{
    if (objPlayer.myStand.skills[prevSkill, StandSkill.Skill] == BulletTime)
    {
        objPlayer.myStand.skills[prevSkill, StandSkill.Skill] = TrickShot;
        objPlayer.myStand.skills[prevSkill, StandSkill.MaxCooldown] = 5;
        with (objPlayer.myStand)
        {
            FireCD(other.prevSkill);
        }
    }
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
            owner = objPlayer;
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

#define DimensionalHopCreate(_x, _y)

DimensionalHopEffect(_x, _y);

#define GiveD4C //stand

var _name = "D4C";
var _sprite = global.sprD4C;
var _color = 0xe4cd5f;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.4;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = TrickShot;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 0.5;
_skills[sk, StandSkill.SkillAlt] = BulletVolley;
_skills[sk, StandSkill.MaxCooldownAlt] = 5;
_skills[sk, StandSkill.IconAlt] = global.sprSkillBulletVolley;

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
_skills[sk, StandSkill.Skill] = DimensionalHop;
_skills[sk, StandSkill.Icon] = global.sprSkillLoveTrain;
_skills[sk, StandSkill.MaxCooldown] = 45;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndD4CSummon;

objPlayer.myStand.saveKey = "jjbamD4c";
objPlayer.myStand.discType = global.jjbamDiscD4c;
