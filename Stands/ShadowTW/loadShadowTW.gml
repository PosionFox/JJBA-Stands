
#define StwPos // core

xTo = objPlayer.x;
yTo = objPlayer.y;
alphaTarget = 0;

#define StwDrawGui

var _height = display_get_gui_height() - 200;

draw_set_color(c_gray);
draw_line_width(32, _height, 32 + 256, _height, 2);
draw_set_color(c_yellow);
draw_line_width(32, _height, 32 + (xp / maxXp) * 256, _height, 2);
draw_set_color(c_white);

#define StwXXI(method, skill) //attacks
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dis = 12;
alphaTarget = 1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStwSummon, 0, false);
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 0);
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
        PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 0);
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 4:
        _dis = 16;
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage] * 2, 2);
        FireCD(skill);
        state = StandState.Idle;
    break;
}
xTo = objPlayer.x + lengthdir_x(_dis, _dir);
yTo = objPlayer.y + lengthdir_y(_dis, _dir);
attackStateTimer += 1 / room_speed;

#define StwPunishment(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(12, _dir);
yTo = objPlayer.y + lengthdir_y(12, _dir);
alphaTarget = 1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStwSummon, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 2);
        with (_p)
        {
            onHitEvent = KnifeCoffin;
            destroyOnImpact = true;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define KnifeCoffin(_x, _y)
var _dmg = 2 + (objPlayer.level * 0.2) + objPlayer.dmg;
//var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _target = objPlayer;
alphaTarget = 1;
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

#define StwThrowingKnifes(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        var _snd = audio_play_sound(global.sndStwKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var i = 0;
        repeat (4)
        {
            var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
            with (_p)
            {
                despawnTime = room_speed * 5;
                damage = other.skills[skill, StandSkill.Damage];
                direction = (_dir - (i * 2)) - 4;
                canMoveInTs = false;
                sprite_index = global.sprKnifeStw;
                x += lengthdir_x(4 * i, direction - 90);
                y += lengthdir_y(4 * i, direction - 90);
            }
            i++;
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
        var _snd = audio_play_sound(global.sndStwKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var i = 0;
        repeat (4)
        {
            var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
            with (_p)
            {
                despawnTime = room_speed * 5;
                damage = other.skills[skill, StandSkill.Damage];
                direction = (_dir + (i * 2)) + 4;
                canMoveInTs = false;
                sprite_index = global.sprKnifeStw;
                x += lengthdir_x(4 * i, direction + 90);
                y += lengthdir_y(4 * i, direction + 90);
            }
            i++;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define StwDivineBlood(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 1:
        var _p = PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 0);
        with (_p)
        {
            var _arg = noone;
            if (instance_exists(parEnemy))
            {
                _arg = instance_nearest(x, y, parEnemy);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define StwSRSE(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

objPlayer.h = lengthdir_x(1, _dir + 180);
objPlayer.v = lengthdir_y(1, _dir + 180);
audio_play_sound(global.sndStwSRSE, 0, false);
var _p = ProjectileCreate(objPlayer.x, objPlayer.y - 4);
with (_p)
{
    baseSpd = 10;
    despawnTime = room_speed * 5;
    damage = other.skills[skill, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    destroyOnImpact = false;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_red;
    x += lengthdir_x(2, _dir + 90);
    y += lengthdir_y(2, _dir + 90);
    GlowOrderCreate(self, 0.1, c_red);
}
var _p = ProjectileCreate(objPlayer.x, objPlayer.y - 4);
with (_p)
{
    baseSpd = 10;
    despawnTime = room_speed * 5;
    damage = other.skills[skill, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    destroyOnImpact = false;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_red;
    x += lengthdir_x(2, _dir - 90);
    y += lengthdir_y(2, _dir - 90);
    GlowOrderCreate(self, 0.1, c_red);
}
FireCD(skill);
state = StandState.Idle;

#define StwUry(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        objPlayer.h -= lengthdir_x(2, _dir);
        objPlayer.v -= lengthdir_y(2, _dir);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.2)
        {
            attackState++;
        }
    break;
    case 2:
        audio_play_sound(global.sndStwUry, 1, false);
        objPlayer.h += lengthdir_x(6, _dir);
        objPlayer.v += lengthdir_y(6, _dir);
        var _p = PunchCreate(x, y, _dir, skills[skill, StandSkill.Damage], 4);
        with (_p)
        {
            image_alpha = 0;
            stationary = true;
            speed = 0;
            despawnTime = room_speed * 0.8;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define StwCharisma(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStwCharisma, 1, false);
        GrowingCircleEffect(x, y);
        with (parEnemy)
        {
            if (distance_to_object(objPlayer) < 32)
            {
                var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
                h = lengthdir_x(-2, _dir);
                h = lengthdir_y(-2, _dir);
            }
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer > 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        for (var i = 0; i < 5; i++)
        {
            var _o = ProjectileCreate(x + lengthdir_x(16, 45 * i), y + lengthdir_y(16, 45 * i));
            with (_o)
            {
                damage = other.skills[skill, StandSkill.Damage];
                canMoveInTs = false;
                baseSpd = 0.1;
                direction = random(360);
                sprite_index = global.sprStwCharisma;
                baseAnimSpd = 0.2;
                image_speed = baseAnimSpd;
                destroyOnImpact = true;
                
                InstanceAssignMethod(self, "step", ScriptWrap(StwCharismaStep), true);
                GlowOrderCreate(self, 0.1, c_white);
            }
        }
        FireCD(skill)
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

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

#define StwTheWorld(method, skill)

if (xp >= maxXp)
{
    audio_play_sound(global.sndStwEvolve, 5, false);
    var _o = ModObjectSpawn(x, y, 0);
    with (_o)
    {
        timer = 1;
        
        InstanceAssignMethod(self, "step", ScriptWrap(StwTheWorldStep), false);
    }
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define StwTheWorldStep

if (instance_exists(objPlayer.myStand))
{
    RemoveStand();
}
FireEffect(c_white, c_yellow);
timer -= 1 / room_speed;
if (timer <= 0)
{
    GiveTheWorld();
    instance_destroy(self);
}

#define StwDivineBloodCreate(_scr, _target)

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
with (_o)
{
    if (!instance_exists(objPlayer)) { instance_destroy(self); }
    life = 3;
    timer = 0.8;
    target = noone;
    if (instance_exists(_target)) { target = _target; }
    
    InstanceAssignMethod(self, "step", ScriptWrap(StwDivineBloodStep), false);
}
audio_play_sound(global.sndStwDivineBlood, 1, false);

#define StwDivineBloodStep

if (instance_exists(target))
{
    target.behaviourEngage = false;
    target.h = 0;
    target.v = 0;
}
else
{
    objPlayer.invulFrames = 0;
    instance_destroy(self);
    exit;
}

objPlayer.invulFrames = 2;
objPlayer.h = 0;
objPlayer.v = 0;
if (timer > 0)
{
    timer -= 1 / room_speed;
}
else
{
    objPlayer.hp++;
    target.hp -= target.hpMax * 0.05;
    timer = 0.8;
}
life -= 1 / room_speed;
if (life <= 0)
{
    var _dir = point_direction(objPlayer.x, objPlayer.y, target.x, target.y);
    target.h = lengthdir_x(3, _dir);
    target.v = lengthdir_y(3, _dir);
    target.behaviourEngage = true;
    objPlayer.h = lengthdir_x(3, _dir + 180);
    objPlayer.v = lengthdir_y(3, _dir + 180);
    objPlayer.invulFrames = 0;
    instance_destroy(self);
}

#define StwCharismaStep

baseSpd *= 1.02;
if (instance_exists(parEnemy))
{
    var _near = instance_nearest(x, y, parEnemy);
    if (distance_to_object(_near) < 128)
    {
        var pd = point_direction(x, y, _near.x, _near.y);
        var dd = angle_difference(direction, pd);
        direction -= min(abs(dd), 5) * sign(dd);
    }
}

#define GiveShadowTheWorld //stand

var _name = "Shadow The World";
var _sprite = global.sprShadowTheWorld;
var _color = 0xffffff;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

var _skills = StandSkillInit(_stats);
// off
var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = StwUry;
_skills[sk, StandSkill.Damage] = 4 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillUry;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StwSRSE;
_skills[sk, StandSkill.Damage] = 6 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillSRSE;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = StwDivineBlood;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = StwCharisma;
_skills[sk, StandSkill.Damage] = 5 + (objPlayer.level * 0.01) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillCharisma;
_skills[sk, StandSkill.MaxCooldown] = 18;
// on
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StwXXI;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.03) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillXXI;
_skills[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StwPunishment;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillPunishment;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StwThrowingKnifes;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStwKnifes;
_skills[sk, StandSkill.MaxCooldown] = 6;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSTW;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopStw;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.SkillAlt] = StwTheWorld;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStwTw;
_skills[sk, StandSkill.MaxHold] = 2;

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = noone;
    idlePos = StwPos;
    saveKey = "jjbamStw";
    discType = global.jjbamDiscStw;
    maxXp = 300;
    xp = 0;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StwDrawGui), true);
}

