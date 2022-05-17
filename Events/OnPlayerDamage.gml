
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
            audio_play_sound(_sound[i], 0, false);
        }
        else
        {
            audio_play_sound(_sound, 0, false);
        }
    }
}

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
