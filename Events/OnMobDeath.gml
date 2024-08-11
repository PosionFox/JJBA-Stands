
#define OnMobDeath(_mob)

if (instance_exists(player))
{
    if (instance_exists(STAND))
    {
        STAND.experience += _mob.hpMax * STAND.development_potential;
        switch (STAND.saveKey)
        {
            case "jjbamTsk":
                STAND.act4Meter += _mob.hpMax * 0.25;
            break;
            case "jjbamSus":
                jj_play_audio(global.sndAmogDead, 5, false);
            break;
        }
    }
}

if (STAND.max_energy > 0)
{
    var _c = random(1);
    if (_c <= 0.5)
    {
        CreateEnergyOrb(_mob.x, _mob.y);
    }
}

// shards
var _rolls = irandom(1);
var _name = object_get_name(_mob.object_index);
switch (_name)
{
    case "objThunderSpiritBoss": _rolls = 2; break;
    case "objWizrobBoss": _rolls = 2; break;
    case "objDemonBoss": _rolls = 2; break;
    case "objSlimeKing": _rolls = 3; break;
    case "objSkeletonKing": _rolls = 4; break;
    case "objToxicGuardian": _rolls = 5; break;
    case "objDarkBeet": _rolls = 6; break;
}
repeat (_rolls)
{
    var _pool =
    [
        [global.jjCommonShard, 128],
        [global.jjUncommonShard, 64],
        [global.jjRareShard, 32],
        [global.jjEpicShard, 16],
        [global.jjLegendaryShard, 8],
        [global.jjMythicalShard, 4],
        [global.jjAscendedShard, 2],
        [global.jjUltimateShard, 1],
    ]
    var _shard = random_weight(_pool);
    DropItem(_mob.x, _mob.y, _shard, 1);
}

// bizarre candy
if (current_month == 12)
{
    var _rolls = 1;
    var _name = object_get_name(_mob.object_index);
    switch (_name)
    {
        case "objThunderSpiritBoss": _rolls = 2; break;
        case "objWizrobBoss": _rolls = 2; break;
        case "objDemonBoss": _rolls = 2; break;
        case "objSlimeKing": _rolls = 3; break;
        case "objSkeletonKing": _rolls = 4; break;
        case "objToxicGuardian": _rolls = 5; break;
        case "objDarkBeet": _rolls = 6; break;
    }
    repeat (_rolls)
    {
        DropItem(_mob.x, _mob.y, global.jjBizarreCandy, 1);
    }
}
