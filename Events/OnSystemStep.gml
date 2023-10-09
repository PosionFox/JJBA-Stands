
#define OnSystemStep

if (instance_exists(player))
{
    if (bool("myStand" in player) and instance_exists(player.myStand))
    {
        RunRunesUpdateTick();
    }
}

if (room = rmGame)
{
    if (random(100) < 0.02)
    {
        if (!NPC2Exists(global.npcPucci))
        {
            SpawnPucci(undefined, undefined);
        }
    }
}
