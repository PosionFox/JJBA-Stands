
#define HamonBarrage(_, s)

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        if barrageData.sound != noone jj_play_audio(barrageData.sound, 10, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.08)
        {
            var xx = x + random_range(-4, 4);
            var yy = y + random_range(-8, 8);
            var _p = PunchSwingCreate(xx, yy, _dir, 45, 5);
            with (_p)
            {
                if other.barrageData.hitSound != noone onHitSound = other.barrageData.hitSound;
                if other.barrageData.hitEvent != noone onHitEvent = other.barrageData.hitEvent;
                if other.barrageData.hitEventArgs != noone onHitEventArg = other.barrageData.hitEventArgs;
            }
            attackStateTimer = 0;
        }
        if (barrageData.time > 3)
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
            EndSpecAtk(s);
        }
        barrageData.time += DT;
    break;
}
attackStateTimer += DT;

#define HamonPunch(_, s)



#define GiveHamon(_user)

var _skills = SpecSkillsInit();

_skills[SpecSkill.A, SpecSkillData.Skill] = HamonBarrage;
_skills[SpecSkill.B, SpecSkillData.Skill] = HamonPunch;

var _spec = SpecBuild(_user, _skills)
with (_spec)
{
    name = "Hamon";
}
return _spec;
