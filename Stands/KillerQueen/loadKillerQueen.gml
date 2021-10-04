
/// attacks
#define PlaceBomb(method, skill)
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
var _dmg = 3 + (owner.level * 1.5);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        attackStateTimer += 1 / room_speed;
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        BombEffect(x, y);
        BombCreate(x, y, _dmg);
        skills[skill, StandSkill.Icon] = global.sprSkillDetonate;
        skills[skill, StandSkill.Skill] = DetonateBomb;
        if (name == "KQ: Bites The Dust")
        {
            skills[skill, StandSkill.IconAlt] = global.sprSkillDetonate;
            skills[skill, StandSkill.SkillAlt] = DetonateBomb;
        }
        skills[skill, StandSkill.MaxCooldown] = 2;
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define CoinBomb(method, skill)
if (modTypeCount("coinBomb") < 5)
{
    var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
    audio_play_sound(sndCoin1, 0, false);
    CoinBombCreate(owner.x, owner.y, _dir);
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define DetonateBomb(method, skill)
StandDefaultPos();

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndClickBomb, 1, false);
        attackState++;
    break;
    case 1:
        attackStateTimer += 1 / room_speed;
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        var _b = modTypeFind("bomb");
        if (_b)
        {
            instance_destroy(_b);
        }
        with (objModEmpty)
        {
            if ("type" in self)
            {
                if (type == "coinBomb")
                {
                    ExplosionCreate(x, y, 32, true);
                    instance_destroy(self);
                }
            }
        }
        skills[skill, StandSkill.Icon] = global.sprSkillFirstBomb;
        skills[skill, StandSkill.Skill] = PlaceBomb;
        if (name == "KQ: Bites The Dust")
        {
            skills[skill, StandSkill.IconAlt] = global.sprSkillCoinBomb;
            skills[skill, StandSkill.SkillAlt] = TripleCoin;
        }
        skills[skill, StandSkill.MaxCooldown] = 5;
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define ShaSummon(method, skill)

if (!modTypeExists("SHA"))
{
    ShaCreate(x, y);
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

/// attacks properties
#define BombCreate(_x, _y, _dmg)
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

var _target = noone;
var _nearest = self;
if (instance_exists(parObject))
{
    _nearest = instance_nearest(x, y, parObject);
    if (distance_to_object(_nearest) <= 8)
    {
        _target = _nearest;
    }
}
if (instance_exists(parEnemy))
{
    _nearest = instance_nearest(x, y, parEnemy);
    if (distance_to_object(_nearest) <= 8)
    {
        _target = _nearest;
    }
}
var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "bomb";
    target = _target;
    range = 32;
    damage = _dmg
    
    InstanceAssignMethod(self, "step", ScriptWrap(BombStep), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(BombDestroy), false);
}

#define BombStep

if (instance_exists(target))
{
    x = target.x;
    y = target.y;
}

#define BombDestroy

ExplosionCreate(x, y, 32, true);
ExplosionEffect(x, y);
audio_play_sound(global.sndDetonateBomb, 1, false);
if (instance_exists(parEnemy))
{
    with (parEnemy)
    {
        if (distance_to_object(other) < other.range)
        {
            hp -= other.damage;
        }
    }
}

#define CoinBombCreate(_x, _y, _dir)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "coinBomb";
    sprite_index = global.sprCoin;
    direction = _dir;
    speed = 5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(CoinBombStep), false);
}

#define CoinBombStep

speed = lerp(speed, 0, 0.1);
if (WaterCollision(x, y))
{
    instance_destroy(self);
}

#define ShaCreate(_x, _y)

audio_play_sound(global.sndSHA, 1, false);
var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "SHA";
    sprite_index = global.sprSHA;
    image_xscale = 0.5;
    image_yscale = 0.5;
    maxSpd = 2;
    spd = 0;
    h = 0;
    v = 0;
    
    life = 20;
    state = 0;
    bombCD = 0;
    canCollide = true;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ShaStep), false);
}

#define ShaStep

if (canCollide)
{
    // solid h
    if (place_meeting(x + h, y, parSolid))
    {
        while !(place_meeting(x + sign(h), y, parSolid))
        {
            x += sign(h);
        }
        h = 0;
    }
    // water h
    //var hSize = bbox_right - bbox_left;
    if (WaterCollision(x + h, y))
    {
        while !(WaterCollision(x + sign(h), y))
        {
            x += sign(h);
        }
        h = 0;
    }
    x += h;

    // solid v
    if (place_meeting(x, y + v, parSolid))
    {
        while !(place_meeting(x, y + sign(v), parSolid))
        {
            y += sign(v);
        }
        v = 0;
    }
    //var vSize = bbox_bottom - bbox_top;
    // water v
    if (WaterCollision(x, y + v))
    {
        while !(WaterCollision(x, y + sign(v)))
        {
            y += sign(v);
        }
        v = 0;
    }
    y += v;
}

depth = -y;

life -= 1 / room_speed;
if (life <= 0)
{
    state = 3;
}
if (bombCD > 0)
{
    bombCD -= 1 / room_speed;
}

switch (state)
{
    case 0: // follow
        if (instance_exists(objPlayer))
        {
            var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
            
            if (distance_to_object(objPlayer) > 100)
            {
                canCollide = false;
                state = 2;
            }
            if (distance_to_object(objPlayer) > 32)
            {
                image_xscale = sign(dcos(_dir)) * 0.5;
                h = lengthdir_x(spd, _dir);
                v = lengthdir_y(spd, _dir);
                spd = lerp(spd, maxSpd, 0.1);
            }
            else
            {
                spd = lerp(spd, 0, 0.1);
            }
        }
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            if (distance_to_object(_near) < 128)
            {
                state = 1;
            }
        }
    break;
    case 1: // attack
        if (instance_exists(parEnemy))
        {
            var _near = instance_nearest(x, y, parEnemy);
            var _dir = point_direction(x, y, _near.x, _near.y);
            var _dis = distance_to_object(_near);
            
            if (_dis > 136)
            {
                state = 0;
            }
            if (_dis > 8)
            {
                image_xscale = sign(dcos(_dir)) * 0.5;
                var _r = random_range(-4, 4)
                h = lengthdir_x(spd, _dir + _r);
                v = lengthdir_y(spd, _dir + _r);
                spd = lerp(spd, maxSpd, 0.1);
            }
            else if (bombCD <= 0)
            {
                ExplosionCreate(x, y, 32, false);
                bombCD = 2;
            }
        }
        else
        {
            state = 0;
        }
        if (instance_exists(objPlayer))
        {
            if (distance_to_object(objPlayer) > 200)
            {
                canCollide = false;
                state = 2;
            }
        }
    break;
    case 2: // super follow
        if (instance_exists(objPlayer))
        {
            if (distance_to_object(objPlayer) > 16)
            {
                FireEffect(c_white, c_fuchsia);
                var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
                x += lengthdir_x(5, _dir);
                y += lengthdir_y(5, _dir);
            }
            else
            {
                canCollide = true;
                state = 0;
            }
        }
    break;
    case 3: // come back
        if (instance_exists(objPlayer))
        {
            image_xscale = 0.1;
            image_yscale = 0.1;
            FireEffect(c_white, c_fuchsia);
            canCollide = false;
            var _dir = point_direction(x, y, objPlayer.myStand.x, objPlayer.myStand.y);
            x += lengthdir_x(5, _dir);
            y += lengthdir_y(5, _dir);
            
            if (place_meeting(x, y, objPlayer.myStand))
            {
                instance_destroy(self);
            }
        }
    break;
}

/// stand
#define GiveKillerQueen

var _name = "Killer Queen";
var _sprite = global.sprKillerQueen;
var _color = 0xba7bd7;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.4;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = PlaceBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillFirstBomb;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CoinBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillCoinBomb;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = ShaSummon;
_skills[sk, StandSkill.Icon] = global.sprSkillSHA;
_skills[sk, StandSkill.MaxCooldown] = 40;
_skills[sk, StandSkill.MaxExecutionTime] = 20;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndKqSummon;

objPlayer.myStand.saveKey = "jjbamKq";
objPlayer.myStand.discType = global.jjbamDiscKq;
