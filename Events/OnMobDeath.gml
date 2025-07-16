
#define OnMobDeath(_mob)

if (instance_exists(player))
{
    StandGainExp(STAND, _mob.hpMax);
    if (instance_exists(STAND))
    {
        switch (STAND.saveKey)
        {
            case "jjbamTsk":
                STAND.act4Meter += _mob.hpMax * 0.25;
            break;
            case "jjbamSus":
                jj_play_audio(global.sndAmogDead, 5, false);
            break;
        }
        
        if (STAND.max_energy > 0)
        {
            var _c = random(1);
            if (_c <= 0.2)
            {
                CreateEnergyOrb(_mob.x, _mob.y, _mob.depth);
            }
        }
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
        [global.jjsCommonShard, global.common_rarity_weight],
        [global.jjsUncommonShard, global.uncommon_rarity_weight],
        [global.jjsRareShard, global.rare_rarity_weight],
        [global.jjsEpicShard, global.epic_rarity_weight],
        [global.jjsLegendaryShard, global.legendary_rarity_weight],
        [global.jjsMythicalShard, global.mythical_rarity_weight],
        [global.jjsCelestialShard, global.celestial_rarity_weight],
        [global.jjsUltimateShard, global.ultimate_rarity_weight],
        [global.jjsBizarreMass, global.bizarre_rarity_weight]
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
        DropItem(_mob.x, _mob.y, global.jjsBizarreCandy, 1);
    }
}
