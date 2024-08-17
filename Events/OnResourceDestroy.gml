
#define OnResourceDestroy(_ins)

if (bool("isRoka" in _ins))
{
    DropItem(_ins.x, _ins.y, global.jjbamRokakaka, 3);
}

if (random(1) <= 0.03)
{
    if (_ins.object_index == objRock)
    {
        var _a = irandom_range(1, 4);
        DropItem(_ins.x, _ins.y, global.jjStarShard, _a);
    }
}
