
#define PlaceBomb(method, skill) //attacks
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

#define BombCreate(_x, _y, _dmg) //attack properties
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

#define GiveKillerQueen //stand

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
