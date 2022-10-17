
global.jjbamDiscTwau = ItemCreate(
    undefined,
    "DISC:TWAU",
    "The label says: The World Alternate Universe",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscTwauUse),
    5 * 10,
    true
);

#define DiscTwauUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwau);
    exit;
}
GiveTheWorldAU(player);

#define TripleKnifeThrow(m, s)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));

for (var i = 0; i < 3; i++)
{
    var _p = ProjectileCreate(player.x, player.y);
    with (_p)
    {
        var _d = (_dir - 16) + (i * 16);
        damage = GetDmg(s);
        direction = _d;
        canMoveInTs = false;
        sprite_index = global.sprKnife;
    }
}
EndAtk(s);

#define OilCan(m, s)

var xx = ((x div 16) * 16) + 8;
var yy = ((y div 16) * 16) + 8;

var _c = modTypePlace(xx, yy, "oil");
var _c2 = modTypePlace(xx, yy, "burningOil");
if (instance_exists(_c) or instance_exists(_c2))
{
    
}
else
{
    OilCreate(xx, yy);
    attackStateTimer += 0.1;
}

if (attackStateTimer > 1)
{
    EndAtk(s);
}

#define OilCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0)
with (_o)
{
    type = "oil";
    sprite_index = global.sprCoin;
    image_blend = c_black;
    
    life = 10;
    burn = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(OilStep));
}
return _o;

#define OilStep

image_xscale = lerp(image_xscale, 2.5, 0.02);
image_yscale = lerp(image_yscale, 2.2, 0.02);

image_alpha = min(0.5, life);

// var _n = modTypeFindNearest(x, y, "burningOil");
// if (instance_exists(_n))
// {
//     if (distance_to_object(_n) < 16)
//     {
//         BurningOilCreate(x, y);
//         ExplosionCreate(x, y, 4, true);
//         instance_destroy(self);
//     }
// }

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

#define BurningOilCreate(_x, _y)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    type = "burningOil";
    sprite_index = global.sprCoin;
    image_blend = c_black;
    
    life = 5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BurningOilStep));
}
return _o;

#define BurningOilStep

FireEffect(c_red, c_yellow);

if (modTypeExists("oil"))
{
    var _n = modTypeFindNearest(x, y, "oil");
    if (distance_to_object(_n) < 16)
    {
        BurningOilCreate(_n.x, _n.y);
        instance_destroy(_n);
    }
}

if (life <= 0)
{
    ExplosionCreate(x, y, 32, true);
    instance_destroy(self);
    exit;
}
life -= DT;

#define Matches(m, s)

MatchCreate(x, y, DIR_PLAYER_TO_MOUSE);
EndAtk(s);

#define MatchCreate(_x, _y, _dir)

var _o = ModObjectSpawn(_x, _y, 0);
with (_o)
{
    sprite_index = global.sprArrow;
    direction = _dir;
    speed = 5;
    
    life = 5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(MatchStep));
}

#define MatchStep

FireEffect(c_red, c_yellow);
speed *= 0.95;

var _c = modTypePlace(x, y, "oil");
if (instance_exists(_c))
{
    BurningOilCreate(_c.x, _c.y);
    instance_destroy(_c);
}

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

#define KnifeBarrage(method, skill) //attacks

var _dis = point_distance(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _xx = objPlayer.x + lengthdir_x(8, _dir);
var _yy = objPlayer.y + lengthdir_y(8, _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > objPlayer.x ? 1 : -1;

attackStateTimer += DT;
if (distance_to_point(_xx, _yy) < 2)
{
    if (attackStateTimer >= 0.1)
    {
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-8, 8);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-2, 2);
        var _p = ProjectileCreate(xx, yy);
        with (_p)
        {
            damage = GetDmg(skill);
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprKnife;
        }
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

#define GunShot(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

audio_play_sound(global.sndGunShot, 0, false);
BulletCreate(player.x, player.y, _dir, GetDmg(skill));
FireCD(skill)
state = StandState.Idle;

#define TwauTimestop(method, skill)

audio_play_sound(global.sndTwAuTs, 5, false);
TimestopCreate(5 + (0.15 * player.level));
EndAtk(skill);

#define GiveTheWorldAU(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = RevolverReload;
_skills[sk, StandSkill.Icon] = global.sprRevolverReload;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.Desc] = "reload revolver:\nreload your revolver";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = "bullet volley:\nfire a volley of three projectiles.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "triple knife:\ntoss three knifes at once.";
/*
sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = Matches;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.SkillAlt] = OilCan;
_skills[sk, StandSkill.IconAlt] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldownAlt] = 5;
_skills[sk, StandSkill.Desc] = @"matches:
tosses a match on the ground.

(hold) oil can:
pours oil on the ground.";
*/
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 4;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = KnifeBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = "knife barrage:\nlaunches a barrage of knifes.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 4;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwauTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.Desc] = "it's my time!:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "The World Alternate Universe";
    sprite_index = global.sprTheWorldAU;
    color = 0x36c7fb;
    summonSound = global.sndTwSummon;
    saveKey = "jjbamTwau";
    discType = global.jjbamDiscTwau;
    
    ammo = 6;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(TWAUDrawGui));
}

#define TWAUDrawGui

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

draw_sprite_ext(global.sprRevCylinderGUI, 0, 321, _height - 96, 2, 2, 0, c_white, 1);
for (var i = 0; i < ammo; i++)
{
    var xx = 320 + lengthdir_x(12, i * 60);
    var yy = _height - 96 + lengthdir_y(12, i * 60);
    draw_sprite_ext(global.sprBulletGUI, 0, xx, yy, 2, 2, 0, c_white, 1);
}

//draw_text(340, _height - 100, string(modTypeCount("oil")));
