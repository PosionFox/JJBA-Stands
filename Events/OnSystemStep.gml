
#define OnSystemStep

if (instance_exists(player))
{
    if (bool("myStand" in player) and instance_exists(player.myStand))
    {
        RunRunesUpdateTick(STAND);
    }
}

if (room == rmGame)
{
    if (random(100) <= 0.02)
    {
        if (!NPC2Exists(global.npcPucci))
        {
            SpawnPucci(undefined, undefined);
        }
    }
    
    if (instance_exists(player) and player.hp >= 6)
    {
        if (random(1) <= 0.01)
        {
            var _xx = irandom(room_width);
            var _yy = irandom(room_height);
            if (!WaterCollision(_xx, _yy))
            {
                EnemyPrisonerCreate(_xx, _yy);
            }
        }
    }
}
