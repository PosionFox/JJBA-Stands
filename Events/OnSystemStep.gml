
#define OnSystemStep

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

if (room = rmGame)
{
    if (random(100) < 0.02)
    {
        if (!modSubtypeExists("DIO"))
        {
            var _xx = room_width / 2 - 32;
            var _yy = room_height / 2;
            ExplosionCreate(_xx, _yy, 32, false);
            EnemyDioCreate(_xx, _yy);
        }
    }
}
