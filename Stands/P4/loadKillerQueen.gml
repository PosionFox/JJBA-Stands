
global.jjbamDiscKq = ItemCreate(
    undefined,
    Localize("standDiscName") + "KQ",
    Localize("standDiscDescription") + "Killer Queen",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscKqUse),
    5 * 10,
    true
);

#define DiscKqUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscKq);
    exit;
}
GiveKillerQueen(player);

#define PlaceBomb(method, skill) //attacks
if (modTypeExists("bomb"))
{
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(GetStandReach(self), _dir);
yTo = objPlayer.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        BombEffect(x, y);
        BombCreate(x, y, GetDmg(skill));
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define CoinBomb(method, skill)

if (modTypeCount("coinBomb") < 5)
{
    var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
    jj_play_audio(sndCoin1, 0, false);
    CoinBombCreate(objPlayer.x, objPlayer.y, _dir, GetDmg(skill));
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
        jj_play_audio(global.sndClickBomb, 1, false);
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
        _b = modTypeFind("ScBubble");
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
                    instance_destroy(self);
                }
            }
        }
        EndAtk(skill);
    break;
}

#define ShaSummon(method, skill)

if (!modTypeExists("SHA"))
{
    ShaCreate(x, y, GetDmg(skill));
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define BombCreate(_x, _y, _dmg) //attack properties

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

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
if (enemy_instance_exists())
{
    _nearest = get_nearest_enemy(x, y);
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
    damage = _dmg;
    
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

var _e = ExplosionCreate(x, y, 32, true);
_e.dmg = damage;
ExplosionEffect(x, y);
jj_play_audio(global.sndDetonateBomb, 1, false);

#define CoinBombCreate(_x, _y, _dir, _dmg)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "coinBomb";
    sprite_index = global.sprCoin;
    direction = _dir;
    speed = 5;
    damage = _dmg;
    z = 0;
    zGrav = 4;
    bouncy = 0.75;
    zSpdMax = random_range(10, 15);
    zSpd = zSpdMax;
    
    InstanceAssignMethod(self, "step", ScriptWrap(CoinBombStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(CoinBombDraw), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(CoinBombDestroy));
}

#define CoinBombStep

speed = lerp(speed, 0, 0.1);
z += zSpd - zGrav;
zSpd *= bouncy;

if (z <= 0)
{
    zSpdMax *= bouncy;
    zSpd = zSpdMax;
    if (WaterCollision(x, y))
    {
        instance_destroy(self);
        exit;
    }
}
z = clamp(z, 0, 99999);

#define CoinBombDraw

draw_sprite_ext(
    sprShadow,
    0,
    x,
    y,
    min(0.5, abs(image_xscale / (z * 0.2))),
    min(0.5, abs(image_yscale / (z * 0.2))),
    0,
    c_white,
    image_alpha * 0.5
);

draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y - z,
    image_xscale,
    image_yscale,
    image_angle,
    image_blend,
    image_alpha
);

#define CoinBombDestroy

var _e = ExplosionCreate(x, y, 32, true);
_e.dmg = damage;
ExplosionEffect(x, y);
jj_play_audio(global.sndDetonateBomb, 1, false);

#define GiveKillerQueen(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = DetonateBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillDetonate;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = Localize("detonateBombDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = PlaceBomb;
_skills[sk, StandSkill.Damage] = 20;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillFirstBomb;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("placeBombDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CoinBomb;
_skills[sk, StandSkill.Damage] = 10;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillCoinBomb;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = Localize("coinBombDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = ShaSummon;
_skills[sk, StandSkill.Damage] = 30;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillSHA;
_skills[sk, StandSkill.MaxCooldown] = 40;
_skills[sk, StandSkill.MaxExecutionTime] = 20;
_skills[sk, StandSkill.Desc] = Localize("shaSummonDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Killer Queen";
    sprite_index = global.sprKillerQueen;
    color = 0xba7bd7;
    summonSound = global.sndKqSummon;
    discType = global.jjbamDiscKq;
    saveKey = "jjbamKq";
}
