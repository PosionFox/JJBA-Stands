
#define WindSE(_, _a, _t)

if (instance_exists(_t))
{
    EffectCircleLerpCreate(x, y, 8, 2);
    var _p = ProjectileCreate(x, y);
    _p.owner = owner;
    _p.baseSpd = 0;
    _p.destroyOnImpact = false;
    _p.despawnTime = 1;
    _p.col_cd_max = 0.5;
    _p.col_cd = 0.25;
    _p.multihit = true;
    _p.damage = 2 * (GetStandDestructivePower(owner) * 2);
}

#define FreezeSE(_, _a, _t)

if (instance_exists(_t))
{
    if bool("freeze" in _t)
    {
        _t.freeze = 10;
    }
}

#define ElectricSE(_, _a, _t)

if (instance_exists(_t))
{
    ZapSpawn(_t);
}

#define BurnSE(_, _a, _t)

if (instance_exists(_t))
{
    if bool("burn" in _t)
    {
        _t.burn = 10;
    }
}

#define BloodSpikes(_, s)

jj_play_audio(global.sndToss, 5, false);
var _am = round(5 * GetStandDestructivePower(self));
var _ac = 32 * (1 / GetStandPrecision(self));
Trace(_ac);
for (var i = 0; i < _am; i++)
{
    var _dir = owner.attack_direction + random_range(-_ac, _ac);
    BloodSpikeCreate(x, y, _dir, GetDmg(s));
}
EndAtk(s);

#define BloodSpikeCreate(_x, _y, _dir, _dmg)

var _se = ProjectileCreate(_x, _y);
with (_se)
{
    damage = _dmg;
    sprite_index = global.sprBloodSpike;
    image_blend = c_white;
    baseAnimSpd = 0;
    z = 0;
    zGrav = 0.5;
    bouncy = 0.1;
    rotate = false;
    zSpd = irandom_range(4, 8);
    baseSpd = random_range(2, 4);
    rotate_with_direction = false;
    direction = _dir;
    fric = 0.0;
    col_cd_max = 0.5;
    despawnTime = 10;
    destroyOnImpact = false;
    multihit = true;
    
    state = "drop";
    
    InstanceAssignMethod(self, "step", ScriptWrap(BloodSpikeStep));
    //InstanceAssignMethod(self, "draw", ScriptWrap(BloodSpikeDraw), false);
}

#define BloodSpikeStep

switch (state)
{
    case "drop":
        zSpd -= zGrav;
        z += zSpd;
        
        if (z <= 0)
        {
            zSpd *= -bouncy;
            baseSpd *= fric;
            if (WaterCollision(x, y))
            {
                instance_destroy(self);
                exit;
            }
            if (zSpd <= 0.1)
            {
                state = "active";
                baseAnimSpd = 1;
                var _s = jj_play_audio(choose(global.sndBloodSpike1, global.sndBloodSpike2), 5, false);
                audio_sound_pitch(_s, random_range(0.9, 1.1));
                audio_sound_gain(_s, 0.25, 0);
            }
        }
        z = clamp(z, 0, 99999);
    break;
    case "active":
        if (image_index >= image_number - 1)
        {
            baseAnimSpd = 0;
        }
    break;
}

#define AirBullets(_, s)

var _dir = owner.attack_direction;
xTo = owner.x + lengthdir_x(GetStandExtension(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandExtension(self), _dir + random_range(-4, 4));
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
    
    debris = array_create(24, undefined);
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

#define FrogRain(_, s)



#define LightningStrike(_, s)



#define HeavyWeather(_, s)



#define CrushingPressure(_, s)



#define O2Overload(_, s)



#define WeatherReportSummon

if (state == StandState.Idle)
{
    if (keyboard_check_pressed(ord("Q")))
    {
        radial_x = device_mouse_x_to_gui(0);
        radial_y = device_mouse_y_to_gui(0);
        radial_menu = true;
    }
    if (keyboard_check_released(ord("Q")))
    {
        if (radial_pick == -1)
        {
            if (owner.freeze < 1)
            {
                active = !active;
                if (active)
                {
                    if (summonSound != noone and playSummonSound)
                    {
                        if (is_array(summonSound))
                        {
                            var _s = irandom(array_length(summonSound) - 1);
                            var _is_playing = false;
                            for (var i = 0; i < array_length(summonSound); i++)
                            {
                                if audio_is_playing(summonSound[i]) _is_playing = true;
                                break;
                            }
                            if (!_is_playing) jj_play_audio(summonSound[_s], 5, false);
                        }
                        else
                        {
                            if (!audio_is_playing(summonSound)) jj_play_audio(summonSound, 0, false);
                        }
                    }
                }
            }
        }
        else
        {
            element = clamp(radial_pick, 0, array_length(movesets) - 1);
            skills = movesets[element];
            switch (element)
            {
                case 0:
                    jj_play_audio(global.sndWind, 1, false);
                break;
                case 1:
                    jj_play_audio(global.sndWater, 1, false);
                break;
                case 2:
                    jj_play_audio(global.sndElectric, 1, false);
                break;
                case 3:
                    jj_play_audio(global.sndFire, 1, false);
                break;
            }
        }
        radial_menu = false;
    }
}

#define StandSkillWrCDs

var _len = array_length(movesets);
for (var i = 0; i < _len; i++)
{
    StandSkillRunCD(movesets[i]);
}

#define GiveWeatherReport(_owner)

var sk1 = StandSkillInit(); // wind
var sk2 = StandSkillInit(); // rain
var sk3 = StandSkillInit(); // lightning
var sk4 = StandSkillInit(); // heat

var sk, s;
// wind
sk = sk1;
s = StandState.SkillA;
sk[s, StandSkill.Skill] = StandBarrageVars;
sk[s, StandSkill.Vars] = { hitEvent : WindSE };
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.DamageScale] = 0.02;
sk[s, StandSkill.MaxCooldown] = 5;
sk[s, StandSkill.MaxExecutionTime] = 2;
sk[s, StandSkill.Icon] = global.sprSkillBarrage;

s = StandState.SkillB;
sk[s, StandSkill.Skill] = AirBullets;
sk[s, StandSkill.Damage] = 0.5;
sk[s, StandSkill.DamageScale] = 0.04;
sk[s, StandSkill.MaxCooldown] = 8;
sk[s, StandSkill.MaxExecutionTime] = 5;
sk[s, StandSkill.Icon] = global.sprSkillStrongPunch;

s = StandState.SkillC;
sk[s, StandSkill.Skill] = Tornado;
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.MaxCooldown] = 3;
sk[s, StandSkill.Icon] = global.sprSkillStarFinger;

// rain
sk = sk2;
s = StandState.SkillAOff;
sk[s, StandSkill.Skill] = BloodSpikes;
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.DamageScale] = 0.02;
sk[s, StandSkill.MaxCooldown] = 1;
sk[s, StandSkill.Icon] = global.sprSkillBarrage;

s = StandState.SkillA;
sk[s, StandSkill.Skill] = StandBarrageVars;
sk[s, StandSkill.Vars] = { hitEvent : FreezeSE };
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.DamageScale] = 0.02;
sk[s, StandSkill.MaxCooldown] = 5;
sk[s, StandSkill.MaxExecutionTime] = 2;
sk[s, StandSkill.Icon] = global.sprSkillBarrage;
sk[s, StandSkill.Desc] = "freezing barrage:";

// lightning
sk = sk3;
s = StandState.SkillA;
sk[s, StandSkill.Skill] = StandBarrageVars;
sk[s, StandSkill.Vars] = { hitEvent : ElectricSE };
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.DamageScale] = 0.02;
sk[s, StandSkill.MaxCooldown] = 5;
sk[s, StandSkill.MaxExecutionTime] = 2;
sk[s, StandSkill.Icon] = global.sprSkillBarrage;
sk[s, StandSkill.Desc] = "electric barrage:";

// heat
sk = sk4;
s = StandState.SkillA;
sk[s, StandSkill.Skill] = StandBarrageVars;
sk[s, StandSkill.Vars] = { hitEvent : BurnSE };
sk[s, StandSkill.Damage] = 1;
sk[s, StandSkill.DamageScale] = 0.02;
sk[s, StandSkill.MaxCooldown] = 5;
sk[s, StandSkill.MaxExecutionTime] = 2;
sk[s, StandSkill.Icon] = global.sprSkillBarrage;
sk[s, StandSkill.Desc] = "burning barrage:";


var _s = StandBuilder(_owner, sk1);
with (_s)
{
    saveKey = "jjbamWr";
    name = "Weather Report";
    sprite_index = global.sprWeatherReport;
    color = 0xffffff;
    colorAlt = 0xff9b63;
    summonSound = global.sndSummonWR;
    auraParticleSprite = global.sprStandParticle4;
    UpdateRarity(Rarity.WIP);
    
    extra_serial_data[? "has_heavy_weather"] = false;
    
    element = 0;
    array_push(movesets, sk2);
    array_push(movesets, sk3);
    array_push(movesets, sk4);
    
    runCDsMethod = StandSkillWrCDs;
    summonMethod = WeatherReportSummon;
    radial_menu = false;
    radial_x = 0;
    radial_y = 0;
    radial_pick = -1;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(WeatherReportDrawGUI), false);
}
return _s;

#define WeatherReportDrawGUI

var _h = display_get_gui_height();
draw_text_color(380, _h - 100, string(extra_serial_data[? "has_heavy_weather"]), color, color, colorAlt, colorAlt, 1);

var _sprs = [global.sprWind, global.sprRain, global.sprLightning, global.sprHeat];
var _len = array_length(movesets);

draw_set_alpha(0.5 * global.jjsSettGuiVisibility);
draw_circle_color(330, (_h - 108), 32, c_black, c_dkgray, false);
draw_set_alpha(1);
for (var i = 0; i < _len; i++)
{
    var _xx = 330 + lengthdir_x(24, ((360 / _len) * i) + 90);
    var _yy = (_h - 108) + lengthdir_y(24, ((360 / _len) * i) + 90);
    var _s = 2;
    var _c = c_white;
    if (i != element)
    {
        _s = 1;
        _c = c_dkgray;
    }
    draw_sprite_ext(_sprs[i], 0, _xx, _yy, _s, _s, 0, _c, global.jjsSettGuiVisibility);
}

var _x = radial_x;
var _y = radial_y;
if (radial_menu)
{
    var _s = draw_radial_button(_x, _y, 32, global.sprTornado);
    if (_s)
    {
        radial_pick = -1;
    }
    
    for (var i = 0; i < _len; i++)
    {
        var _xx = _x + lengthdir_x(128, ((360 / _len) * i) + 90);
        var _yy = _y + lengthdir_y(128, ((360 / _len) * i) + 90);
        var _r = draw_radial_button(_xx, _yy, 40, _sprs[i]);
        if (_r) radial_pick = i;
    }
}

#define draw_radial_button(_x, _y, _radius, _spr)

var _color1 = c_black;
var _color2 = c_gray;
if (instance_exists(STAND))
{
    _color1 = STAND.color;
    _color2 = STAND.colorAlt;
}
var _btn_color = _color1;
var _btn2_color = _color2;

var _hover = point_in_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _radius);

if (_hover)
{
    _btn_color = _color2;
    _btn2_color = _color1;
    if (global.jjMenuHover != _x - _y * _x + _y)
    {
        if (global.jjsSettCustomModMenuSounds)
        {
            jj_play_audio(global.sndMenuHover, 0, false);
        }
        else
        {
            jj_play_audio(sndBuildHoverBig, 0, false);
        }
        global.jjMenuHover = _x - _y * _x + _y;
        return true;
    }
}
else
{
    if (global.jjMenuHover == _x - _y * _x + _y)
    {
        global.jjMenuHover = undefined;
    }
}

draw_circle_color(_x, _y, _radius + 4, _btn2_color, _btn2_color, false);
draw_circle_color(_x, _y, _radius, _btn_color, _btn_color, false);
draw_sprite_ext(_spr, 0, _x, _y, 3, 3, 0, c_white, 1);

return false;
