
#define OnPlayerDamage(_dodge, _damage)

if (instance_exists(STAND) and !_dodge)
{
    var _sound = STAND.soundWhenHurt;
    if (player.hp == 0)
    {
        _sound = STAND.soundWhenDead;
        STAND.active = false;
    }
    if (_sound != undefined)
    {
        if (is_array(_sound))
        {
            var i = irandom(array_length(_sound) - 1);
            jj_play_audio(_sound[i], 0, false);
        }
        else
        {
            jj_play_audio(_sound, 0, false);
        }
    }
}

if (modTypeExists("loveTrain"))
{
    player.hp += _damage;
    var _t = get_nearest_enemy(player.x, player.y);
    _t.hp -= (_t.hpMax * 0.02) + _damage;
    player.invulFrames = 0;
    LTPunishEffect(_t.x, _t.y);
    jj_play_audio(global.sndLtPunish, 5, false);
}
if (modSubtypeExists("geFrog"))
{
    var _frog = modSubtypeFind("geFrog");
    if (_frog.state == "guard")
    {
        player.hp += _damage;
        var _t = get_nearest_enemy(player.x, player.y);
        _t.hp -= _damage;
        player.invulFrames = 0;
    }
}

if (enemy_instance_exists() and instance_exists(player) and instance_exists(STAND))
{
    if (STAND.trait.damage_reflected > 0)
    {
        var _n = get_nearest_enemy(player.x, player.y);
        _n.hp -= _damage * STAND.trait.damage_reflected;
    }
}
