
global.jjbamDiscSp = ItemCreate(
    undefined,
    Localize("standDiscName") + "SP",
    Localize("standDiscDescription") + "Star Platinum",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSpUse),
    5 * 10,
    true
);

#define DiscSpUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSp);
    exit;
}
GiveStarPlatinum(player);

#define Soda(m, s)

player.hp += 2;
audio_play_sound(global.sndSpOpenSoda, 5, false);
EffectSodaCreate(player);
EndAtk(s);

#define StarFinger(method, skill) //attacks

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

var _xx = player.x + lengthdir_x(8, _dir);
var _yy = player.y + lengthdir_y(8, _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > player.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 1.15)
        {
            attackState++;
        }
    break;
    case 1:
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            owner = STAND;
            sprite_index = global.sprStarPlatinumFinger;
            image_blend = STAND.color;
            damage = GetDmg(skill);
            stationary = true;
            canDespawnInTs = true;
            destroyOnImpact = false;
            direction = _dir;
            despawnFade = false;
            despawnTime = 1;
            fingerSize = 0;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StarFingerStep), false);
            InstanceAssignMethod(self, "draw", ScriptWrap(StarFingerDraw), false);
        }
        attackState++;
    break;
    case 2:
        if (attackStateTimer >= 2.2)
        {
            attackState++;
        }
    break;
    case 3:
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define StarFingerStep

fingerSize = lerp(fingerSize, 120, 0.1);
var _dir = point_direction(STAND.x, STAND.y, mouse_x, mouse_y);
direction = _dir;

var x2 = player.x + lengthdir_x(fingerSize, direction);
var y2 = player.y + lengthdir_y(fingerSize, direction);

var w = fingerSize / sprite_get_width(sprite_index);
image_xscale = w;
x = STAND.x + lengthdir_x(w, direction);
y = STAND.y + lengthdir_y(w, direction);

var _col = collision_line(STAND.x, STAND.y, x2, y2, ENEMY, false, true);
if (_col)
{
    ProjHitEnemy(_col);
}

#define StarFingerDraw

draw_self()

#define SpTimestop(m, s)

audio_play_sound(global.sndSpTs, 5, false);
TimestopCreate(5 + (0.1 * player.level));
EndAtk(s);

#define SpEvolveToSptw(m, s)

if (xp >= maxXp)
{
    audio_play_sound(global.sndStwEvolve, 5, false);
    var _o = ModObjectSpawn(x, y, 0);
    with (_o)
    {
        timer = 1;
        
        InstanceAssignMethod(self, "step", ScriptWrap(SpEvolveToSptwStep), false);
    }
}
else
{
    ResetAtk(s);
}

#define SpEvolveToSptwStep

if (instance_exists(STAND))
{
    RemoveStand(player);
}
FireEffect(c_purple, c_white);
timer -= DT;
if (timer <= 0)
{
    var _standPool =
    [
        [GiveSPTW, 100],
        [GiveTe, 12]
    ]
    script_execute(random_weight(_standPool), player);
    instance_destroy(self);
}

#define GiveStarPlatinum(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("diosKnifeDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("spStrongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = Localize("starFingerDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SpTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.SkillAlt] = SpEvolveToSptw;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStwTw;
_skills[sk, StandSkill.MaxHold] = 2;
_skills[sk, StandSkill.Desc] = Localize("spTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Star Platinum";
    sprite_index = global.sprStarPlatinum;
    color = 0x8a4276;
    summonSound = global.sndSpSummon;
    discType = global.jjbamDiscSp;
    saveKey = "jjbamSp";
    
    maxXp = 1000;
    xp = 0;
    knifeSprite = global.sprKnife;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StwDrawGui), true);
}
return _s;
