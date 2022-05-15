
#define OnMobDeath(_mob)

if (instance_exists(player))
{
    if ("myStand" in player)
    {
        switch (STAND.name)
        {
            case "Shadow The World":
                if (STAND.xp < STAND.maxXp)
                {
                    STAND.xp += _mob.hpMax;
                }
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
