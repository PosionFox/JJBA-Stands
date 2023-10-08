
#define OnSystemStep

if (instance_exists(player))
{
    if (instance_exists(STAND))
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
