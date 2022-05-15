
#define OnPlayerDamage(_dodge, _damage)

if (modTypeExists("loveTrain"))
{
    player.hp += _damage;
    if (instance_exists(ENEMY))
    {
        var _t = instance_nearest(player.x, player.y, ENEMY);
        _t.hp -= (_t.hpMax * 0.06) + _damage;
        player.invulFrames = 0;
        LTPunishEffect(_t.x, _t.y);
        audio_play_sound(global.sndLtPunish, 5, false);
    }
}
if (modSubtypeExists("geFrog"))
{
    player.hp += _damage;
    if (instance_exists(ENEMY))
    {
        var _t = instance_nearest(player.x, player.y, ENEMY);
        _t.hp -= _damage;
        player.invulFrames = 0;
    }
}
