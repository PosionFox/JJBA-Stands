
//wip
global.jjbamDiscWs = ItemCreate(
    undefined,
    Localize("standDiscName") + "WS",
    Localize("standDiscDescription") + "WhiteSnake",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscWsUse),
    5 * 10,
    true
);

#define DiscWsUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscWs);
    exit;
}
GiveWhiteSnake(player);

#define SuddenStrike(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;
var _snd = jj_play_audio(global.sndPunchAir, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var xx = x + random_range(-4, 4);
var yy = y + random_range(-8, 8);
PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
EndAtk(s);

#define ExplosiveSurprise(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;
var _snd = jj_play_audio(global.sndPunchAir, 0, false);
audio_sound_pitch(_snd, 2);
var _b = BulletCreate(x, y, _dir, GetDmg(s));
with (_b)
{
    onHitEvent = ExplodeProjectile;
    onHitEventArg = GetStandRange(other);
}
EndAtk(s);

#define ExplodeProjectile(_, _args, _target)

if (instance_exists(_target))
{
    ExplosionCreate(_target.x, _target.y, 16 * _args, true);
}

#define DiscProduce(m, s)

DropItem(x, y, global.jjbamDisc, 1);
EndAtk(s);

#define WsBarrage(method, skill) //attacks
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = DIR_PLAYER_TO_MOUSE;

var _exdir = skills[skill, StandSkill.ExecutionTime] * 20;
xTo = owner.x + lengthdir_x(GetStandReach(self) + _exdir, _dir + random_range(-2, 2));
yTo = owner.y + lengthdir_y(GetStandReach(self) + _exdir, _dir + random_range(-2, 2));
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += DT;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.12 / GetStandSpeed(self))
    {
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        PunchSwingCreate(xx, yy, _dir, 45, GetDmg(skill));
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += DT;
}

if (keyboard_check_pressed(ord(skills[skill, StandSkill.Key])))
{
    if (skills[skill, StandSkill.ExecutionTime] > 0)
    {
        FireCD(skill);
    }
    else
    {
        ResetCD(skill);
    }
    state = StandState.Idle;
}

#define WsGun(m, s)
var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            attackState++;
        }
    break;
    case 2:
        if (attackStateTimer >= 0.7)
        {
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            attackState++;
        }
    break;
    case 3:
        if (attackStateTimer >= 0.9)
        {
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            var _p = EffectGeParticleCreate(x, y, c_dkgray);
            _p.sprite_index = global.sprGun;
            _p.bouncy = 0.8;
            _p.image_angle = random(360);
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define AcidicSpit(m, s)

var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndAcidicSpit, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.6)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            damage = other.skills[s, StandSkill.Damage];
            baseSpd = 8;
            direction = _dir;
            canMoveInTs = false;
            sprite_index = global.sprStandParticle3;
            onHitEvent = StuckKnife;
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define MeltYourHeart(m, s)
var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);
player.h = 0;
player.v = 0;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndMeltYourHeart, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.5)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = AcidicPoolCreate(x, y);
        _p.scale *= GetStandRange(self);
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define AcidicPoolCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprAcidicPool;
    image_xscale = 0;
    image_yscale = 0;
    image_angle = irandom(360);
    image_blend = other.color;
    life = 20;
    scale = 1;
    enemiesHit = ds_list_create();
    
    InstanceAssignMethod(self, "step", ScriptWrap(AcidicPoolStep));
}
return _o;

#define AcidicPoolStep

life -= DT;
if (life <= 0)
{
    image_alpha -= 0.1;
    if (image_alpha <= 0)
    {
        instance_destroy(self);
        exit;
    }
}

image_xscale = lerp(image_xscale, 1 * scale, 0.02);
image_yscale = lerp(image_yscale, 1 * scale, 0.02);
image_xscale = clamp(image_xscale, 0, 1 * scale);
image_yscale = clamp(image_yscale, 0, 1 * scale);

with (ENEMY)
{
    if (place_meeting(x, y, other))
    {
        hp -= 0.001 + (hpMax * 0.001);
        freeze = 2;
    }
}
with (NATURAL)
{
    if (place_meeting(x, y, other))
    {
        hp -= 0.001 + (hpMax * 0.001);
        freeze = 2;
    }
}
with (CRITTER)
{
    if (place_meeting(x, y, other))
    {
        hp -= 0.001 + (hpMax * 0.001);
        freeze = 2;
    }
}

#define DiscSteal(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;

xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 1.5)
        {
            attackState++;
        }
    break;
    case 1:
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
        with (_p)
        {
            onHitEvent = DiscStolen;
            onHitSound = global.sndWsDiscSteal;
        }
        attackState++;
    break;
    case 2:
        player.h = 0;
        player.v = 0;
        if (attackStateTimer >= 3)
        {
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define DiscStolen

var _near = noone;
if (enemy_instance_exists())
{
    _near = get_nearest_enemy(x, y);
}
if (_near != noone)
{
    STAND.discs++;
    DiscStolenCreate(_near);
    var _p = EffectGeParticleCreate(_near.x, _near.y, c_dkgray);
    _p.sprite_index = global.sprDisc;
    _p.bouncy = 0.8;
    _p.direction = point_direction(_near.x, _near.y, player.x, player.y);
    _p.image_xscale = 0.5;
    _p.image_yscale = 0.5;
    _p.life = 1;
}

#define DiscStolenCreate(_id)

var _o = ModObjectSpawn(_id.x, _id.y, 0);
with (_o)
{
    target = _id;
    
    InstanceAssignMethod(self, "step", ScriptWrap(DiscStolenStep))
    InstanceAssignMethod(self, "draw", ScriptWrap(DiscStolenDraw))
}

#define DiscStolenStep

if (instance_exists(target))
{
    target.freeze = 2;
    target.pathfindSpeed = 0;
    depth = target.depth - 1;
}

#define DiscStolenDraw

if (instance_exists(target))
{
    draw_sprite_ext(global.sprDisc, 0, target.x, target.y - 32, 0.5, 0.5, 0, c_white, 0.5);
}

#define GiveWhiteSnake(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = SuddenStrike;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillUry;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = Localize("suddenStrikeDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = ExplosiveSurprise;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillExplosiveSurprise;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = Localize("explosiveSurpriseDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = DiscProduce;
_skills[sk, StandSkill.Icon] = global.sprSkillDiscProduce;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = Localize("discProduceDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = MeltYourHeart;
_skills[sk, StandSkill.Icon] = global.sprSkillMeltYourHeart;
_skills[sk, StandSkill.MaxCooldown] = 40;
_skills[sk, StandSkill.Desc] = Localize("meltYourHeartDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = WsBarrage;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = Localize("wsBarrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = WsGun;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("quickDisposalDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AcidicSpit;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillAcidicSpit;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("acidicSpitDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = DiscSteal;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillDiscSteal;
_skills[sk, StandSkill.MaxCooldown] = 35;
_skills[sk, StandSkill.Desc] = Localize("discStealDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "WhiteSnake";
    sprite_index = global.sprWhiteSnake;
    color = 0xfcdbcb;
    summonSound = global.sndWsSummon;
    saveKey = "jjbamWs";
    discType = global.jjbamDiscWs;
    
    discs = 0;
    
    InstanceAssignMethod(self, "step", ScriptWrap(WhiteSnakeStep));
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(WhiteSnakeDrawGUI));
}
return _s;

#define WhiteSnakeStep

discs = clamp(discs, 0, 10);

#define WhiteSnakeDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

for (var i = 0; i < 10; i++)
{
    draw_sprite_ext(global.sprDisc, 0, 304 + (16 * i), _height - 96, 1, 1, 0, c_black, 1);
}

for (var i = 0; i < discs; i++)
{
    draw_sprite_ext(global.sprDisc, 0, 304 + (16 * i), _height - 96, 1, 1, 0, c_white, 1);
}
