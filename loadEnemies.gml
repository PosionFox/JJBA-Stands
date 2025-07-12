
global.enemyDioSpawned = false;

#define is_enemy(_ins)

return object_is_ancestor(_ins.object_index, ENEMY) or _ins.object_index == MOBJ and _ins.type == "Enemy";

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
    hpMax = 6000;
    hp = hpMax;
    life = 512;
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
        state = "destroy";
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
    state = "dying";
    jj_play_audio(global.sndDioDeath, 5, false);
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
            DropItem(x, y, global.jjsRuneBundle, 1);
            var _drops = [global.jjsDiosDiary, global.jjsDiosBone];
            var _item = irandom(array_length(_drops) - 1);
            DropItem(x, y, _drops[_item], 1);
            repeat (8)
            {
                var _pool =
                [
                    [global.jjsCommonShard, 128],
                    [global.jjsUncommonShard, 64],
                    [global.jjsRareShard, 32],
                    [global.jjsEpicShard, 16],
                    [global.jjsLegendaryShard, 8],
                    [global.jjsMythicalShard, 4],
                    [global.jjsCelestialShard, 2],
                    [global.jjsUltimateShard, 1],
                ]
                var _shard = random_weight(_pool);
                DropItem(x, y, _shard, 1);
            }
            if (current_month == 12)
            {
                DropItem(x, y, global.jjsBizarreCandy, 8);
            }
            global.enemyDioSpawned = false;
            StandGainExp(STAND, hpMax);
            instance_destroy(self);
            exit;
        }
    break;
    case "destroy":
        RemoveStand(self);
        global.enemyDioSpawned = false;
        instance_destroy(self);
        exit;
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

#define EnemyPrisonerCreate(_x, _y)

var _o = ActorCreate(_x, _y);
with (_o)
{
    type = "Enemy";
    subtype = "Prisoner";
    targetableFlag = true;
    sprIdle = global.sprPrisoner;
    sprWalk = global.sprPrisonerMoving;
    sprite_index = sprIdle;
    image_speed = 0.35;
    level = 10;
    hpMax = 120;
    hp = hpMax;
    life = 240;
    attack_direction = 0;
    attack_cooldown = 0;
    state = "waiting";
    
    init_trait(self);
    
    myStand = GivePrisoner(self);
    with (myStand)
    {
        targets = [player];
        summonMethod = EventHandler;
        runDrawGUI = false;
        for (var i = 0; i < array_length(skills); i++)
        {
            skills[i, StandSkill.Key] = "null";
        }
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyPrisonerStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(EnemyPrisonerDraw));
}
return _o;

#define EnemyPrisonerStep

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
    state = "dying";
}
hp = clamp(hp, 0, hpMax);

switch (state)
{
    case "waiting":
        if (distance_to_object(player) < 32 or hp < hpMax)
        {
            state = "chase";
        }
    break;
    case "idle":
        sprite_index = sprIdle;
        image_speed = 0.35;
        if (distance_to_object(player) < 128)
        {
            state = "chase";
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
        DropItem(x, y, global.jjsPrisonerSoul, 1);
        StandGainExp(STAND, hpMax);
        instance_destroy(self);
        exit;
    break;
    case "destroy":
        RemoveStand(self);
        instance_destroy(self);
        exit;
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

#define EnemyPrisonerDraw

if (hp < hpMax)
{
    draw_self();
    draw_line_width_color(x - 8, y - 16, x + 8, y - 16, 2, c_black, c_black);
    draw_line_width_color(x - 8, y - 16, (x - 8) + ((hp / hpMax) * 16), y - 16, 2, c_red, c_red);
}
