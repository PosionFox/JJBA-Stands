
global.jjbamDiscHg = ItemCreate(
    undefined,
    Localize("standDiscName") + "HG",
    Localize("standDiscDescription") + "Hierophant Green",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscHgUse),
    5 * 10,
    true
);

#define DiscHgUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscHg);
    exit;
}
GiveHierophantGreen(player);

#define EmeraldSplash(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = owner.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndHgEmeraldSplash, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5) attackState++;
    break;
    case 2:
        if (distance_to_point(_xx, _yy) < 2)
        {
            if (attackStateTimer >= 0.1)
            {
                var xx = x + random_range(-8, 8);
                var yy = y + random_range(-8, 8);
                var ddir = _dir + random_range(-2, 2);
                var _dmg = GetDmg(s);
                var _p = ProjectileCreate(xx, yy);
                with (_p)
                {
                    damage = _dmg;
                    direction = _dir;
                    direction += random_range(-4, 4);
                    canMoveInTs = false;
                    sprite_index = global.sprHierophantGreenEmerald;
                    image_blend = other.color;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT;

#define HierophantBarrier(m, s)

owner.h = 0;
owner.v = 0;

switch (attackState)
{
    case 0:
        xTo = owner.x + random_range(-32, 32);
        yTo = owner.y + random_range(-32, 32);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5) attackState++;
    break;
    case 2:
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(x, y)
        with (_p)
        {
            damage = _dmg;
            direction = random(360);
            canMoveInTs = false;
            despawnTime = 15;
            sprite_index = global.sprHierophantBarrier;
            image_xscale = 0;
            image_blend = other.color;
            baseSpd = 0;
            lengthMax = GetStandRange(other);
            
            InstanceAssignMethod(self, "step", ScriptWrap(HierophantBarrierStep));
        }
        attackState = 0;
        attackStateTimer = 0;
    break;
}
attackStateTimer += DT;
skills[s, StandSkill.ExecutionTime] += DT;

#define HierophantBarrierStep

image_xscale = lerp(image_xscale, lengthMax, 0.1);

#define EmeraldSplash20Meters(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = owner.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndHgEmeraldSplash, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5) attackState++;
    break;
    case 2:
        if (distance_to_point(_xx, _yy) < 2)
        {
            if (attackStateTimer >= 0.1)
            {
                var xx = x + random_range(-8, 8);
                var yy = y + random_range(-8, 8);
                var ddir = _dir + random_range(-2, 2);
                var _dmg = GetDmg(s);
                var _p = ProjectileCreate(xx, yy);
                with (_p)
                {
                    damage = _dmg;
                    direction = _dir;
                    direction += random_range(-4, 4);
                    canMoveInTs = false;
                    sprite_index = global.sprHierophantGreenEmerald;
                    image_blend = other.color;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT;

#define GiveHierophantGreen(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = EmeraldSplash;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.03;
_skills[sk, StandSkill.Icon] = global.sprSkillEmeraldSplash;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("emeraldSplashDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 25;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("strongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = HierophantBarrier;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillHierophantBarrier;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = Localize("hierophantBarrierDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = EmeraldSplash20Meters;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.03;
_skills[sk, StandSkill.Icon] = global.sprSkillEmeraldSplash20Meters;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("emeraldSplash20MetersDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Hierophant Green";
    sprite_index = global.sprHierophantGreen;
    color = 0x30be6a;
    discType = global.jjbamDiscHg;
    saveKey = "jjbamHg";
    stand_reach = 16;
}
return _s;

