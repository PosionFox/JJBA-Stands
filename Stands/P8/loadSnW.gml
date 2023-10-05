
global.jjbamDiscSnw = ItemCreate(
    undefined,
    Localize("standDiscName") + "SnW",
    Localize("standDiscDescription") + "Soft and Wet",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSnwUse),
    5 * 10,
    true
);

#define DiscSnwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSnw);
    exit;
}
GiveSoftAndWet(player);

#define MoisturePlunder(m, s)

audio_play_sound(global.sndSnwBubbleSummon, 5, false)
for (var i = 0; i < 8; i++)
{
    var xx = x + lengthdir_x(8, 0 + (i * 45));
    var yy = y + lengthdir_y(8, 0 + (i * 45));
    var _dmg = GetDmg(s);
    var _p = ProjectileCreate(xx, yy);
    with (_p)
    {
        baseSpd = 0;
        despawnTime = 15;
        damage = _dmg;
        canMoveInTs = false;
        sprite_index = global.sprBubble;
        onHitSound = global.sndSnwBubblePop;
    }
}
EndAtk(s);

#define BubbleBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSnwBubble, 5, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.16)
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _dmg = GetDmg(s);
                var _p = ProjectileCreate(xx, yy);
                with (_p)
                {
                    baseSpd = 2;
                    damage = _dmg;
                    direction = _dir;
                    direction += random_range(-4, 4);
                    canMoveInTs = false;
                    sprite_index = global.sprBubble;
                    onHitSound = global.sndSnwBubblePop;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndSnwBubble);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndSnwBubble);
        }
    break;
}
attackStateTimer += DT;

#define ScrewsAndNuts(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5) attackState++;
    break;
    case 1:
        audio_play_sound(global.sndSnwBubbleThrow, 5, false);
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(xx, yy);
        with (_p)
        {
            baseSpd = 2;
            damage = _dmg;
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprBubble;
            onHitSound = global.sndSnwBubblePop;
            onHitEvent = BubbleExplode;
            onHitEventArg = _dmg;
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define BubbleExplode(_, _args)

for (var i = 0; i < 16; i++)
{
    BulletCreate(x, y, i * 22.5, _args);
}

#define BubbleShield(m, s)

audio_play_sound(global.sndSnwBubbleSummon, 5, false);
BubbleShieldCreate(player);
EndAtk(s);

#define BubbleShieldCreate(_owner)

var _o = ModObjectSpawn(_owner.x, _owner.y, 0);
with (_o)
{
    owner = _owner
    sprite_index = global.sprBubbleShield;
    life = 10;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BubbleShieldStep));
}

#define BubbleShieldStep

if (life <= 0)
{
    audio_play_sound(global.sndSnwBubbleBigPop, 5, false);
    instance_destroy(self);
    exit;
}
life -= DT;

image_xscale = (1 + abs(cos(current_time / 1000)));
image_yscale = (1 + abs(sin(current_time / 1000)));

owner.invulFrames = 10;
x = owner.x;
y = owner.y;

#define BubbleTrap(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5) attackState++;
    break;
    case 1:
        audio_play_sound(global.sndSnwBubbleThrow, 5, false);
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(xx, yy);
        with (_p)
        {
            baseSpd = 2;
            damage = _dmg;
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprBubble;
            onHitSound = global.sndSnwBubblePop;
            onHitEvent = TrapEnemyBubble;
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define TrapEnemyBubble

if (instance_exists(ENEMY))
{
    var _target = instance_nearest(x,  y, ENEMY);
    BubbleTrapCreate(_target)
}

#define BubbleTrapCreate(_t)

var _o = ModObjectSpawn(_t.x, _t.y, _t.depth - 1);
with (_o)
{
    target = _t;
    sprite_index = global.sprBubbleShield;
    life = 15;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BubbleTrapStep))
}

#define BubbleTrapStep

life -= DT;
if (life <= 0)
{
    audio_play_sound(global.sndSnwBubbleBigPop, 5, false);
    instance_destroy(self);
    exit;
}

image_xscale = (1 + abs(cos(current_time / 1000)));
image_yscale = (1 + abs(sin(current_time / 1000)));

target.freeze = 2;
x = target.x;
y = target.y;

#define GiveSoftAndWet(_owner)

var _skills = StandSkillInit();

var sk;

sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = MoisturePlunder;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillMoisturePlunder;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("moisturePlunderDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 30;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillShovel;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("shovelDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = BubbleShield;
_skills[sk, StandSkill.Icon] = global.sprSkillBubbleShield;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = Localize("bubbleShieldDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BubbleBarrage;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillBubbleBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("bubbleBarrageDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = ScrewsAndNuts;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillScrewsAndNuts;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("screwsAndNutsDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = BubbleTrap;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBubbleTrap;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = Localize("bubbleTrapDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Soft and Wet";
    sprite_index = global.sprSoftAndWet;
    color = 0xffffff
    summonSound = global.sndSnwSummon;
    discType = global.jjbamDiscSnw;
    stopSign = ModObjectSpawn(x, y, depth);
    with (stopSign)
    {
        sprite_index = global.sprShovel;
        visible = false;
    }
    saveKey = "jjbamSnw";
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(SnWDestroy), true);
}
return _s;

#define SnWDestroy

if (instance_exists(stopSign))
{
    instance_destroy(stopSign);
}
