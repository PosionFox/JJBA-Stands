
global.enemyDioSpawned = false;

#define is_enemy(_ins)

return object_is_ancestor(_ins.object_index, ENEMY) or _ins.object_index == MOBJ and _ins.type == "Enemy";

#define JjsEnemyCreate(_x, _y)

var _o = ActorCreate(_x, _y);
with (_o)
{
    type = "Enemy";
    targetableFlag = true;
    sprIdle = sprPlayerIdle;
    sprWalk = sprPlayerWalk;
    level = 1;
    hpMax = 100;
    hp = hpMax;
    hp_display = hp;
    life = 512; // despawn timer
    attack_direction = 0;
    attack_cooldown = 2;
    dying_sound = undefined;
    
    
    InstanceAssignMethod(self, "step", ScriptWrap(JjsEnemyStep));
}
return _o;

#define JjsEnemyStep

if (hp <= 0 and state != "dying")
{
    state = "dying";
    if (dying_sound != undefined) jj_play_audio(dying_sound, 5, false);
}
hp = clamp(hp, 0, hpMax);

if (freeze > 0 and state != "dying")
{
    state = "freeze";
}

if (attack_cooldown > 0)
{
    attack_cooldown -= DT;
}

if (place_meeting(x, y, objSwordCollision))
{
    hp -= player.dmg;
    PunchEffectCreate(x, y);
    jj_play_audio(sndHitMeat, 0, false);
}
if (place_meeting(x, y, objArrow))
{
    hp -= player.dmg;
    PunchEffectCreate(x, y);
    jj_play_audio(sndHitMeat, 0, false);
}
if (place_meeting(x, y, objExplosion))
{
    hp -= player.dmg;
    PunchEffectCreate(x, y);
    jj_play_audio(sndHitMeat, 0, false);
}

h = lerp(h, 0, 0.1);
v = lerp(v, 0, 0.1);
image_xscale = facing;

#define EnemyStandUserCreate(_x, _y, _standkey)

var _o = JjsEnemyCreate(_x, _y);
with (_o)
{
    GiveStandByKey(_standkey, self);
    with (myStand)
    {
        destructive_power = 1;
        spd = 1;
        range = 1;
        stamina = 1;
        precision = 1;
        targets = [player];
        summonMethod = EventHandler;
        active = true;
        runDrawGUI = false;
        for (var i = 0; i < array_length(skills); i++)
        {
            skills[i, StandSkill.Key] = "null";
        }
    }
    
    trait_give_random(myStand);
    
    close_attacks = [];
    ranged_attacks = [];
    
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyStandUserStep));
}
return _o;

#define EnemyStandUserStep

if (instance_exists(myStand))
{
    if (instance_exists(player))
    {
        myStand.look_x = player.x;
        myStand.look_y = player.y;
    }
}

#define EnemyDioCreate(_x, _y)

jj_play_audio(global.sndDioSpawn, 1, false);
var _o = EnemyStandUserCreate(_x, _y, "jjbamTw");
with (_o)
{
    subtype = "DIO";
    sprIdle = global.sprDIO;
    sprWalk = global.sprDIOMoving;
    sprite_index = sprIdle;
    image_speed = 0.35;
    level = 65;
    hpMax = 6000;
    hp = hpMax;
    sun_immunity = false;
    dying_timer = 0;
    dying_sound = global.sndDioDeath;
    
    close_attacks = [
        StandState.SkillBOff,
        StandState.SkillCOff,
        StandState.SkillA,
        StandState.SkillB,
        StandState.SkillD
    ];
    ranged_attacks = [
        StandState.SkillAOff,
        StandState.SkillDOff,
        StandState.SkillC,
        StandState.SkillD
    ];
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyDioStep));
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(EnemyDioDrawGUI));
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

switch (state)
{
    case "idle":
        sprite_index = sprIdle;
        image_speed = 0.35;
        if (distance_to_object(player) < 1024)
        {
            state = "chase";
        }
    break;
    case "chase":
        facing = player.x > x ? 1 : -1;
        if (distance_to_object(player) > 16)
        {
            sprite_index = sprWalk;
            mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
        }
        else
        {
            sprite_index = sprIdle;
        }
        if (attack_cooldown <= 0)
        {
            state = "attack";
        }
    break;
    case "attack":
        sprite_index = sprIdle;
        if (attack_cooldown <= 0)
        {
            attack_direction = point_direction(x, y, player.x, player.y);
            var _rattack;
            
            if (distance_to_object(player) > 16)
            {
                var _rl = array_length(ranged_attacks);
                if (_rl < 1)
                {
                    attack_cooldown = 0.5;
                    state = "idle";
                    exit;
                }
                var _ri = irandom(_rl - 1);
                _rattack = ranged_attacks[_ri];
            }
            else
            {
                var _cl = array_length(close_attacks);
                if (_cl < 1)
                {
                    attack_cooldown = 0.5;
                    state = "idle";
                    exit;
                }
                var _ci = irandom(_cl - 1);
                _rattack = close_attacks[_ci];
            }
            
            if (myStand.skills[_rattack, StandSkill.Cooldown] > 0)
            {
                attack_cooldown = 0.5;
                state = "idle";
            }
            else
            {
                if (_rattack < 5)
                {
                    myStand.active = false;
                }
                myStand.state = _rattack;
                state = "attacking";
            }
        }
        else if (distance_to_object(player) > 16)
        {
            state = "chase";
        }
    break;
    case "attacking":
        sprite_index = sprIdle;
        facing = player.x > x ? 1 : -1;
        attack_direction = point_direction(x, y, player.x, player.y);
        if (distance_to_object(player) > 16)
        {
            sprite_index = sprWalk;
            mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
        }
        if (myStand.state == StandState.Idle)
        {
            attack_cooldown = random_range(1, 2);
            myStand.active = true;
            state = "idle";
        }
    break;
    case "freeze":
        image_speed = 0;
        image_blend = c_aqua;
        h = 0;
        v = 0;
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

#define EnemyDioDrawGUI

var xx = 372;
var yy = display_get_gui_height() - 96;
var length = 534;
hp_display = lerp(hp_display, hp, 0.1);

draw_set_color(c_black);
draw_line_width(xx, yy, xx + length, yy, 8);
draw_set_color(c_orange);
draw_line_width(xx, yy, xx + (hp_display / hpMax) * length, yy, 8);
draw_set_color(c_red);
draw_line_width(xx, yy, xx + (hp / hpMax) * length, yy, 8);
draw_set_color(c_white);
var _trait = "";
//if (instance_exists(myStand)) _trait = myStand.trait.name;
draw_text_color(xx + (length / 2), yy, string(_trait) + "dio", c_yellow, c_yellow, c_yellow, c_yellow, 1);

#define EnemyDioSpawn

var _xx = room_width / 2;
var _yy = room_height / 2;
if (instance_exists(player))
{
    _xx = player.x;
    _yy = player.y;
}
var _d = EnemyDioCreate(_xx, _yy);
global.enemyDioSpawned = true;
return _d;

#define EnemyPrisonerCreate(_x, _y)

var _o = EnemyStandUserCreate(_x, _y, "jjsPs");
with (_o)
{
    subtype = "Prisoner";
    sprIdle = global.sprPrisoner;
    sprWalk = global.sprPrisonerMoving;
    sprite_index = sprIdle;
    image_speed = 0.35;
    level = 10;
    hpMax = 120;
    hp = hpMax;
    life = 240;
    state = "waiting";
    
    myStand.active = false;
    
    close_attacks = [
        StandState.SkillAOff,
        StandState.SkillBOff
    ];
    
    InstanceAssignMethod(self, "step", ScriptWrap(EnemyPrisonerStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(EnemyPrisonerDraw));
}
return _o;

#define EnemyPrisonerStep

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
        if (distance_to_object(player) < 1024)
        {
            state = "chase";
        }
    break;
    case "chase":
        facing = player.x > x ? 1 : -1;
        if (distance_to_object(player) > 16)
        {
            sprite_index = sprWalk;
            mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
        }
        else
        {
            sprite_index = sprIdle;
            if (attack_cooldown <= 0)
            {
                state = "attack";
            }
        }
    break;
    case "attack":
        sprite_index = sprIdle;
        if (attack_cooldown <= 0)
        {
            attack_direction = point_direction(x, y, player.x, player.y);
            var _rattack;
            
            if (distance_to_object(player) > 16)
            {
                var _rl = array_length(ranged_attacks);
                if (_rl < 1)
                {
                    attack_cooldown = 0.5;
                    state = "idle";
                    exit;
                }
                var _ri = irandom(_rl - 1);
                _rattack = ranged_attacks[_ri];
            }
            else
            {
                var _cl = array_length(close_attacks);
                if (_cl < 1)
                {
                    attack_cooldown = 0.5;
                    state = "idle";
                    exit;
                }
                var _ci = irandom(_cl - 1);
                _rattack = close_attacks[_ci];
            }
            
            if (myStand.skills[_rattack, StandSkill.Cooldown] > 0)
            {
                attack_cooldown = 0.5;
                state = "idle";
            }
            else
            {
                myStand.state = _rattack;
                state = "attacking";
            }
        }
        else if (distance_to_object(player) > 16)
        {
            state = "chase";
        }
    break;
    case "attacking":
        sprite_index = sprIdle;
        facing = player.x > x ? 1 : -1;
        attack_direction = point_direction(x, y, player.x, player.y);
        if (distance_to_object(player) > 16)
        {
            sprite_index = sprWalk;
            mp_potential_step_object(player.x, player.y, maxSpd, parSolid);
        }
        if (myStand.state == StandState.Idle)
        {
            attack_cooldown = random_range(1, 2);
            state = "idle";
        }
    break;
    case "freeze":
        image_speed = 0;
        image_blend = c_aqua;
        h = 0;
        v = 0;
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

#define EnemyPrisonerDraw

if (hp < hpMax)
{
    draw_self();
    draw_line_width_color(x - 8, y - 16, x + 8, y - 16, 2, c_black, c_black);
    draw_line_width_color(x - 8, y - 16, (x - 8) + ((hp / hpMax) * 16), y - 16, 2, c_red, c_red);
}
