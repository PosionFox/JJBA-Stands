
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
var _sprite = global.sprD4CLT;
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
_skills[sk, StandSkill.MaxCooldown] = 0.6;
_skills[sk, StandSkill.SkillAlt] = BulletVolley;
_skills[sk, StandSkill.MaxCooldownAlt] = 6;
_skills[sk, StandSkill.IconAlt] = global.sprSkillBulletVolley;

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 4;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CloneSummon;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneSummon;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = LoveTrain;
_skills[sk, StandSkill.Icon] = global.sprSkillLoveTrain;
_skills[sk, StandSkill.MaxCooldown] = 45;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndD4CSummon;

objPlayer.myStand.saveKey = "jjbamD4clt";
objPlayer.myStand.discType = global.jjbamDiscD4clt;
