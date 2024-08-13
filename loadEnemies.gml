
global.enemyDioSpawned = false;

#define EnemyDioCreate(_x, _y)

jj_play_audio(global.sndDioSpawn, 1, false);
var _o = ActorCreate(_x, _y);
with (_o)
{
    type = "Enemy";
    subtype = "DIO";
    targetableFlag = true;
    sprIdle = global.sprDIO;
    sprWalk = global.sprDIOMoving;
    sprite_index = sprIdle;
    image_speed = 0.35;
    level = 65;
    hpMax = 8000;
    hp = hpMax;
    life = 120;
    sun_immunity = false;
    attack_direction = 0;
    attack_cooldown = 0;
    dying_timer = 0;
    
    init_trait(self);
    
    myStand = GiveTheWorld(self);
    with (myStand)
    {
        targets = [player];
        summonMethod = EventHandler;
        active = true;
        runDrawGUI = false;
        for (var i = 0; i < array_length(skills); i++)
        {
            skills[i, StandSkill.Key] = "null";
        }
    }
    
    var _pool =
    [
        [ConstructRuneStandMight1, 128],
        [ConstructRuneStandMight2, 64],
        [ConstructRuneStandMight3, 32],
        [ConstructRuneStandMight4, 16],
        [ConstructRuneStandMight5, 8],
        [ConstructRuneStandMight6, 4],
        [ConstructRuneStandMight7, 2],
        [ConstructRuneStandMight8, 1],
        [ConstructRuneReach1, 128],
        [ConstructRuneReach2, 64],
        [ConstructRuneReach3, 32],
        [ConstructRuneReach4, 16],
        [ConstructRuneReach5, 8],
        [ConstructRuneReach6, 4],
        [ConstructRuneReach7, 2],
        [ConstructRuneReach8, 1],
        [ConstructRuneMending1, 128],
        [ConstructRuneMending2, 64],
        [ConstructRuneMending3, 32],
        [ConstructRuneMending4, 16],
        [ConstructRuneMending5, 8],
        [ConstructRuneMending6, 4],
        [ConstructRuneMending7, 2],
        [ConstructRuneMending8, 1],
        [ConstructRuneEnergize1, 128],
        [ConstructRuneEnergize2, 64],
        [ConstructRuneEnergize3, 32],
        [ConstructRuneEnergize4, 16],
        [ConstructRuneEnergize5, 8],
        [ConstructRuneEnergize6, 4],
        [ConstructRuneEnergize7, 2],
        [ConstructRuneEnergize8, 1]
    ]
    
    repeat (3)
    {
        var _rune = random_weight(_pool);
        RuneEquip(self, script_execute(_rune));
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyDioStep), true);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(EnemyDioDrawGUI), true);
}
return _o;

#define EnemyDioStep

if (sun_immunity == false)
{
    if (TimeControl.lightState == 1 or TimeControl.lightState == 2)
    {
        var _c = EffectCircleCreate(x, y, 32, 4);
        _c.lifeMulti = 2;
        RunesErase(self);
        RemoveStand(self);
        global.enemyDioSpawned = false;
        instance_destroy(self);
        exit;
    }
}

if (attack_cooldown > 0)
{
    attack_cooldown -= DT;
    if (instance_exists(myStand))
    {
        for (var i = 0; i < array_length(myStand.skills); i++)
        {
            myStand.skills[i, StandSkill.Key] = "null";
        }
    }
}

if (freeze > 0)
{
    state = "freeze";
}

if (hp <= 0 and state != "dying")
{
    jj_play_audio(global.sndDioDeath, 5, false);
    state = "dying";
}
hp = clamp(hp, 0, hpMax);

switch (state)
{
    case "idle":
        sprite_index = sprIdle;
        image_speed = 0.35;
        if (distance_to_object(player) < 128)
        {
            state = "chase"
        }
    break;
    case "chase":
        if (distance_to_object(player) > 16)
        {
            sprite_index = sprWalk;
            mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
        }
        else
        {
            state = "attack";
        }
    break;
    case "attack":
        sprite_index = sprIdle;
        attack_direction = point_direction(x, y, player.x, player.y);
        facing = player.x > x ? 1 : -1;
        if (attack_cooldown <= 0)
        {
            for (var i = 0; i < array_length(myStand.skills); i++)
            {
                myStand.skills[i, StandSkill.Key] = "";
            }
            attack_cooldown = 1;
        }
        if (distance_to_object(player) > 16)
        {
            state = "chase";
        }
    break;
    case "freeze":
        image_speed = 0;
        image_blend = c_aqua;
        h = 0;
        v = 0;
        for (var i = 0; i < array_length(myStand.skills); i++)
        {
            myStand.skills[i, StandSkill.Key] = "null";
        }
        if (freeze <= 0)
        {
            image_blend = c_white;
            state = "idle";
        }
    break;
    case "dying":
        RemoveStand(self);
        image_angle = 90;
        image_speed = 0.1;
        EffectArmChopCreate(x, y);
        dying_timer += DT;
        if (dying_timer > 7)
        {
            var _c = EffectCircleCreate(x, y, 32, 4);
            _c.color = c_red;
            _c.lifeMulti = 2;
            var _drops = [global.jjDiosDiary, global.jjDiosBone];
            var _item = irandom(array_length(_drops) - 1);
            DropItem(x, y, _drops[_item], 1);
            repeat (8)
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
                DropItem(x, y, _shard, 1);
            }
            DropItem(x, y, global.jjBizarreCandy, 8);
            global.enemyDioSpawned = false;
            instance_destroy(self);
            exit;
        }
    break;
}

h = lerp(h, 0, 0.1);
v = lerp(v, 0, 0.1);
image_xscale = facing;

if (place_meeting(x, y, objSwordCollision))
{
    hp -= player.dmg;
}
if (place_meeting(x, y, objArrow))
{
    hp -= player.dmg;
}
if (place_meeting(x, y, objExplosion))
{
    hp -= player.dmg;
}

#define EnemyDioDrawGUI

var xx = 372;
var yy = display_get_gui_height() - 128;
var length = 534;

draw_set_color(c_black);
draw_line_width(xx, yy, xx + length, yy, 8);
draw_set_color(c_red);
draw_line_width(xx, yy, xx + (hp / hpMax) * length, yy, 8);
draw_set_color(c_white);
draw_text(xx + (length / 2), yy, "dio");

#define EnemyDioSpawn

var _xx = room_width / 2;
var _yy = room_height / 2;
if (instance_exists(player))
{
    _xx = player.x;
    _yy = player.y;
}
ExplosionCreate(_xx, _yy, 32, false);
var _d = EnemyDioCreate(_xx, _yy);
global.enemyDioSpawned = true;
return _d;
