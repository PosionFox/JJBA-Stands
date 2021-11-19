
#define TrickShot(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    type = "bulletTime";
    prevSkill = skill;
    knockback = 2;
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_yellow;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    damage = other.skills[skill, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    GlowOrderCreate(self, 0.1, c_yellow);
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(TrickShotDestroy), true);
}
skills[skill, StandSkill.Skill] = BulletTime;
skills[skill, StandSkill.MaxCooldown] = 0.5;
skills[skill, StandSkill.Icon] = global.sprSkillBulletTime;
FireCD(skill);
state = StandState.Idle;

#define BulletTime(method, skill)

var _o = modTypeFind("bulletTime");
if (_o)
{
    if (instance_exists(parEnemy))
    {
        var _e = ShrinkingCircleEffect(_o.x, _o.y);
        _e.color = c_aqua;
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
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
StandDefaultPos();

if (attackStateTimer >= 0.15)
{
    var _snd = audio_play_sound(global.sndGunShot, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    audio_sound_gain(_snd, 0.5, 0);
    var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
    with (_p)
    {
        baseSpd = 10;
        sprite_index = global.sprBtdVoidTrace;
        image_blend = c_yellow;
        mask_index = global.sprKnife;
        despawnTime = room_speed * 5;
        damage = other.skills[skill, StandSkill.Damage];
        direction = _dir;
        canMoveInTs = false;
        GlowOrderCreate(self, 0.1, c_yellow);
    }
    attackStateTimer = 0;
    attackState++;
}
attackStateTimer += 1 / room_speed;
if (attackState >= 3)
{
    FireCD(skill);
    state = StandState.Idle;
}

#define DoubleSlap(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dis = 16;

switch (attackState)
{
    case 0:
        if (attackStateTimer > 0.5)
        {
            audio_play_sound(global.sndPunchAir, 0, false);
            PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 1);
            attackState++;
        }
    break;
    case 1:
        _dis = 24;
        if (attackStateTimer > 1)
        {
            audio_play_sound(global.sndPunchAir, 0, false);
            PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage] * 1.5, 2);
            attackState++;
        }
    break;
    case 2:
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;
xTo = objPlayer.x + lengthdir_x(_dis, _dir);
yTo = objPlayer.y + lengthdir_y(_dis, _dir);


#define CloneSwap(method, skill)

if (modTypeExists("clone"))
{
    var _near = modTypeFindNearest(mouse_x, mouse_y, "clone");
    var prevX = objPlayer.x;
    var prevY = objPlayer.y;
    objPlayer.x = _near.x;
    objPlayer.y = _near.y;
    _near.x = prevX;
    _near.y = prevY;
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define CloneBomb(method, skill)
if (!instance_exists(parEnemy))
{
    USAflag.visible = false;
    if (audio_is_playing(global.sndCloneSummon))
    {
        audio_stop_sound(global.sndCloneSummon);
    }
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);
image_xscale = sign(dcos(_dir));

attackStateTimer += 1 / room_speed;
switch (attackState)
{
    case 0:
        USAflag.visible = true;
        USAflag.x = x;
        USAflag.y = y;
        USAflag.image_xscale = 0;
        USAflag.image_angle = 180;
        audio_play_sound(global.sndCloneSummon, 1, false);
        attackState++;
    break;
    case 1:
        var _ang = _dir;
        _ang -= cos(current_time / 100) * 2;
        USAflag.x = x + lengthdir_x(18, _ang);
        USAflag.y = y + lengthdir_y(18, _ang);
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle = _ang;
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.visible = false;
        var _xx = x + lengthdir_x(8, _dir);
        var _yy = y + lengthdir_y(8, _dir);
        var _ins = noone;
        if (instance_exists(parEnemy))
        {
            _ins = instance_nearest(mouse_x, mouse_y, parEnemy);
        }
        var _o = CloneBombCreate(_xx, _yy, _ins);
        _o.damage = skills[skill, StandSkill.Damage];
        FireCD(skill);
        state = StandState.Idle;
    break;
}


#define CloneSummon(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);
image_xscale = sign(dcos(_dir));

attackStateTimer += 1 / room_speed;
switch (attackState)
{
    case 0:
        USAflag.visible = true;
        USAflag.x = x;
        USAflag.y = y;
        USAflag.image_xscale = 0;
        USAflag.image_angle = 180;
        audio_play_sound(global.sndCloneSummon, 1, false);
        attackState++;
    break;
    case 1:
        var _ang = _dir;
        _ang -= cos(current_time / 100) * 2;
        USAflag.x = x + lengthdir_x(18, _ang);
        USAflag.y = y + lengthdir_y(18, _ang);
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle = _ang;
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.visible = false;
        var _xx = x + lengthdir_x(8, _dir);
        var _yy = y + lengthdir_y(8, _dir);
        var _o = CloneCreate(_xx, _yy);
        _o.damage = skills[skill, StandSkill.Damage];
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define DimensionalHop(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, 90);
yTo = objPlayer.y + lengthdir_y(8, 90);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndDimensionalHop, 5, false);
        USAflag.x = x;
        USAflag.y = y;
        USAflag.visible = true;
        USAflag.image_angle = 0;
        USAflag.image_xscale = 0;
        attackState++;
    break;
    case 1:
        USAflag.x = x;
        USAflag.y = y - 16;
        USAflag.depth = depth - 10;
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle -= cos(current_time / 1000);
        if (attackStateTimer > 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.x = x;
        USAflag.y = lerp(USAflag.y, y + 8, 0.1);
        USAflag.depth = depth - 10;
        USAflag.image_angle = lerp(USAflag.image_angle, 90, 0.1);
        if (attackStateTimer > 3.5)
        {
            attackState++;
        }
    break;
    case 3:
        USAflag.visible = false;
        DimensionalHopCreate(x, y)
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

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
        objPlayer.myStand.skills[prevSkill, StandSkill.Icon] = global.sprSkillGunShot;
        with (objPlayer.myStand)
        {
            FireCD(other.prevSkill);
        }
    }
}

#define DimensionalHopCreate(_x, _y)

DimensionalHopEffect(_x, _y);
var _o = ModObjectSpawn(_x, _y, 0)
with (_o)
{
    type = "dimensionHop";
    owner = objPlayer;
    
    affected = [];
    warpedIn = [];
    life = 10;
    
    with (parEnemy)
    {
        if (distance_to_object(objPlayer) < 48)
        {
            array_push(other.warpedIn, self);
        }
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(DimensionalHopStep), false);
}

#define DimensionalHopStep

if (life <= 0)
{
    for (var i = 0; i < array_length(affected); i++)
    {
        instance_activate_object(affected[i]);
        with (affected[i])
        {
            freeze = 0;
            scale = 1;
            image_alpha = 1;
            visible = true;
        }
    }
    DimensionalHopEffect(x, y);
    instance_destroy(self);
    exit;
}
life -= 1 / room_speed;

if (instance_exists(owner))
{
    x = owner.x;
    y = owner.y;
}

if (instance_exists(parEnemy))
{
    with (parEnemy)
    {
        //freeze = 2;
        var _alreadyAffected = false;
        for (var i = 0; i < array_length(other.warpedIn); i++)
        {
            if (other.warpedIn[i] == self)
            {
                _alreadyAffected = true;
                break;
            }
        }
        for (var i = 0; i < array_length(other.affected); i++)
        {
            if (other.affected[i] == self)
            {
                _alreadyAffected = true;
                break;
            }
        }
        if (!_alreadyAffected)
        {
            array_push(other.affected, self);
            freeze = infinity;
            scale = 0;
            image_alpha = 0;
            visible = false;
        }
        //freeze = 2;
        // if (distance_to_object(objPlayer) > 64)
        // {
        //     instance_deactivate_object(self);
        // }
    }
}

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
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = TrickShot;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 0.5;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = CloneSwap;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneSwap;
_skills[sk, StandSkill.MaxCooldown] = 2;

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = DoubleSlap;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.04) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillDoubleSlap;
_skills[sk, StandSkill.MaxCooldown] = 4;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CloneBomb;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.01) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneBomb;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = CloneSummon;
_skills[sk, StandSkill.MaxCooldownAlt] = 6.5;
_skills[sk, StandSkill.IconAlt] = global.sprSkillCloneSummon;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = DimensionalHop;
_skills[sk, StandSkill.Icon] = global.sprSkillDimensionalHop;
_skills[sk, StandSkill.MaxCooldown] = 25;

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndD4CSummon;
    saveKey = "jjbamD4c";
    discType = global.jjbamDiscD4c;
    
    USAflag = ModObjectSpawn(x, y, depth);
    with (USAflag)
    {
        sprite_index = global.sprD4CFlag;
        visible = false;
    }
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(D4Cdestroy), true);
}

#define D4Cdestroy

if (instance_exists(USAflag))
{
    instance_destroy(USAflag);
}
