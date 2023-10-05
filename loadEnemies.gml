
#define EnemyDioCreate(_x, _y)

audio_play_sound(global.sndDioSpawn, 1, false);
var _o = ActorCreate(_x, _y);
with (_o)
{
    type = "Enemy";
    sprite_index = global.sprDIO;
    image_speed = 0.35;
    level = 65;
    maxSpd = 1;
    life = 120;
    facing = 1;
    attack_direction = point_direction(x, y, player.x, player.y);
    
    var _s = GiveTheWorld(self);
    _s.summonMethod = EventHandler;
    _s.active = true;
    _s.runDrawGUI = false;
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyDioStep), true);
}
return _o;

#define EnemyDioStep

facing = player.x > x ? 1 : -1;
image_xscale = facing;
attack_direction = point_direction(x, y, player.x, player.y);

if (distance_to_object(player) > 16)
{
    sprite_index = global.sprDIOMoving;
    mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
}
else
{
    sprite_index = global.sprDIO;
}
