
#define OnResourceDestroy(_ins)

if (bool("isRoka" in _ins))
{
    DropItem(_ins.x, _ins.y, global.jjsRokakakaFruit, 3);
}

if (random(1) <= 0.04)
{
    if (_ins.object_index == objRock)
    {
        var _a = irandom_range(1, 4);
        DropItem(_ins.x, _ins.y, global.jjsStarChunk, _a);
    }
}

if (instance_exists(player))
{
    StandGainExp(STAND, _ins.hpMax * 0.25);
}
