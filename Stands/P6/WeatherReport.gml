
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
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 3;
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
