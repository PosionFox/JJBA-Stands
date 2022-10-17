
#define OnMobDeath(_mob)

if (instance_exists(player))
{
    if (instance_exists(STAND))
    {
        switch (STAND.saveKey)
        {
            case "jjbamStw":
                STAND.xp += _mob.hpMax;
                STAND.xp = min(STAND.maxXp, STAND.xp);
            break;
            case "jjbamShadow":
                STAND.xp += _mob.hpMax;
                STAND.xp = min(STAND.maxXp, STAND.xp);
            break;
            case "jjbamTsk":
                STAND.act4Meter += _mob.hpMax * 0.25;
            break;
            case "jjbamSus":
                audio_play_sound(global.sndAmogDead, 5, false);
            break;
        }
    }
}
