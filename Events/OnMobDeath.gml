
#define OnMobDeath(_mob)

if (instance_exists(player))
{
    if ("myStand" in player)
    {
        switch (STAND.name)
        {
            case "Shadow The World":
                STAND.xp += _mob.hpMax;
                STAND.xp = min(STAND.maxXp, STAND.xp);
            break;
            case "Tusk":
                STAND.act4Meter += _mob.hpMax * 0.25;
            break;
            case "Imposter":
                audio_play_sound(global.sndAmogDead, 5, false);
            break;
        }
    }
}
