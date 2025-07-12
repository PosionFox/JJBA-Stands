
#define AirBullets(_, s)

var _dir = owner.attack_direction;
xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if barrageData.sound != noone jj_play_audio(barrageData.sound, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= (0.16 / GetStandSpeed(self)))
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _dmg = GetDmg(s);
                var _p = ProjectileCreate(xx, yy);
                with (_p)
                {
                    sprite_index = global.sprAttackPunch;
                    damage = _dmg;
                    direction = _dir;
                    if other.barrageData.hitSound != noone onHitSound = other.barrageData.hitSound;
                    if other.barrageData.hitEvent != noone onHitEvent = other.barrageData.hitEvent;
                    if other.barrageData.hitEventArgs != noone onHitEventArg = other.barrageData.hitEventArgs;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
        }
    break;
}
attackStateTimer += DT;

#define Tornado(_, s)

var _dir = owner.attack_direction;
image_xscale = sign(dcos(_dir));

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndHeavyWeather, 0, false);
        height_speed = 0.01;
        height_target = 64;
        angleTarget = 25;
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.5)
        {
            height_speed = 0.1;
            height_target = 256;
            angleTarget = -25;
            attackState++;
        }
    break;
    case 2:
        if (attackStateTimer >= 1.8) attackState++;
    break;
    case 3:
        var _t = TornadoCreate(x, y);
        _t.damage = GetDmg(s);
        _t.direction = _dir;
        attackState++;
    break;
    case 4:
        height_target = 0;
        if (attackStateTimer >= 2.5) EndAtk(s);
    break;
}
attackStateTimer += DT;

#define TornadoCreate(_x, _y)

var _o = ProjectileCreate(_x, _y);
with (_o)
{
    despawnTime = 30;
    baseSpd = 8;
    destroyOnImpact = false;
    show_projectile = false;
    col_size = 64;
    col_cd_max = 1;
    multihit = true;
    lerping_speed = 0.1;
    
    rot = 0;
    start_anim = 0;
    
    debris = array_create(16, undefined);
    for (var i = 0; i < array_length(debris); i++)
    {
        debris[i] = {
            distance : irandom(32) + 32
        }
    }
    
    segments = 8;
    segments_x = array_create(segments, x);
    segments_y = array_create(segments, y);
    
    move_time = 2;
    
    tornado_sound = jj_play_audio(global.sndTornado, 5, true);
    
    InstanceAssignMethod(self, "step", ScriptWrap(TornadoStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(TornadoDraw), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(TornadoDestroy));
}
return _o;

#define TornadoStep

start_anim = lerp(start_anim, 1, 0.1);

if (move_time <= 0)
{
    if (instance_exists(owner))
    {
        xTo = owner.x + irandom_range(-64, 64);
        yTo = owner.y + irandom_range(-64, 64);
        direction = point_direction(x, y, xTo, yTo);
    }
    else
    {
        xTo += irandom_range(-64, 64);
        yTo += irandom_range(-64, 64);
        direction = point_direction(x, y, xTo, yTo);
    }
    move_time = 2;
}
move_time -= DT;

rot += DT * 2;

if (instance_exists(owner) and audio_is_playing(tornado_sound))
{
    var _dis = clamp(1 - (distance_to_object(owner) / 128), 0, 1);
    audio_sound_gain(tornado_sound, _dis * global.jjSettAudioVolume, 0);
}

#define TornadoDraw

var _dlen = array_length(debris);
for (var i = 0; i < _dlen; i++)
{
    var _xx = x + lengthdir_x(debris[i].distance, rot * (i * i + 32));
    var _yy = y + lengthdir_y(debris[i].distance, rot * (i * i + 32));
    draw_sprite(global.sprStandParticle2, 0, _xx, _yy);
}

for (var i = 0; i < segments; i++)
{
    segments_x[i] = lerp(segments_x[i], x, 0.1 / (1 + i));
    segments_y[i] = lerp(segments_y[i], y, 0.1 / (1 + i));
    draw_sprite_ext(global.sprTornado, i, segments_x[i], (segments_y[i] - (12 * i)) * start_anim, 1 * i, 1 * i, rot * (i * i + 32), c_white, image_alpha * start_anim);
}

#define TornadoDestroy

if (audio_is_playing(tornado_sound))
{
    audio_stop_sound(tornado_sound);
}

#define GiveWeatherReport(_owner)

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = AirBullets;
_skills[sk, StandSkill.Damage] = 0.5;
_skills[sk, StandSkill.DamageScale] = 0.04;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = Tornado;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;

// sk = StandState.SkillD;
// _skills[sk, StandSkill.Skill] = GravityShiftRepel;
// _skills[sk, StandSkill.Icon] = global.sprSkillGravityShiftRepel;
// _skills[sk, StandSkill.MaxCooldown] = 30;
// _skills[sk, StandSkill.SkillAlt] = GravityShiftAttract;
// _skills[sk, StandSkill.IconAlt] = global.sprSkillGravityShiftAttract;
// _skills[sk, StandSkill.MaxCooldownAlt] = 30;

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    saveKey = "jjbamWr";
    name = "Weather Report";
    sprite_index = global.sprWeatherReport;
    color = 0xffffff;
    colorAlt = 0xff9b63;
    summonSound = global.sndSummonWR;
    auraParticleSprite = global.sprStandParticle4;
    
    extra_serial_data[? "has_heavy_weather"] = false;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(WeatherReportDrawGUI), false);
}
return _s;

#define WeatherReportDrawGUI

var _h = display_get_gui_height();
draw_text_color(380, _h - 100, string(extra_serial_data[? "has_heavy_weather"]), color, color, colorAlt, colorAlt, 1);
