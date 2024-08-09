
#define HorizontalSlash(method, skill) //attacks

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    sprite_index = global.sprHorizontalSlash;
    despawnTime = 0.1;
    distance = 16;
    direction = _dir;
    stationary = true;
    destroyOnImpact = false;
}
FireCD(skill);
state = StandState.Idle;

#define AnubisSummon

if (keyboard_check_pressed(ord("Q")) and state == StandState.Idle) {
    active = !active;
    if (active)
    {
        if (!audio_is_playing(summonSound) and summonSound != noone)
        {
            jj_play_audio(summonSound, 0, false);
            GainItem(global.jjbamAnubis);
            ToolbarAdd(global.jjbamAnubis);
            ToolbarRefresh(true);
            ToolbarSelect(global.jjbamAnubis);
        }
    }
    else
    {
        RemoveItem(global.jjbamAnubis);
        ToolbarRemove(global.jjbamAnubis);
    }
}

#define GiveAnubis(_owner) //stand

var _skills = StandSkillInit();

var sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = HorizontalSlash;

var s = StandBuilder(_owner, _skills);
with (s)
{
    name = "Anubis";
    sprite_index = global.sprAnubis;
    color = c_purple;
    saveKey = "jjbamAnubis";
    summonMethod = AnubisSummon;
}
