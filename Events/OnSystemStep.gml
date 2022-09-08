
#define OnSystemStep

if (room = rmGame)
{
    if (random(100) < 0.02)
    {
        if (!NPC2Exists(global.npcPucci))
        {
            SpawnPucci("", "");
        }
    }
}
