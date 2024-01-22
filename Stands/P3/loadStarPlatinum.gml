
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

#define SpBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpBarrage, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.08)
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndSpBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndSpBarrage);
        }
    break;
}
attackStateTimer += DT;

#define SpStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpStrongPunch, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
        break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 3);
        _p.onHitSound = global.sndStrongPunch;
        EndAtk(skill);
        break;
}
attackStateTimer += DT;

#define StarFinger(method, skill) //attacks

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > player.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpStarFinger, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.15)
        {
            attackState++;
        }
    break;
    case 2:
        var _dmg = GetDmg(skill);
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            owner = STAND;
            sprite_index = global.sprStarPlatinumFinger;
            image_xscale = 0;
            image_blend = STAND.color;
            damage = _dmg;
            stationary = true;
            canDespawnInTs = true;
            destroyOnImpact = false;
            direction = _dir;
            despawnFade = false;
            despawnTime = 1;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StarFingerStep));
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 2.2)
        {
            attackState++;
        }
    break;
    case 4:
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define StarFingerStep

var _dir = point_direction(STAND.x, STAND.y, mouse_x, mouse_y);
direction = _dir;

image_xscale = lerp(image_xscale, 1, 0.1);
var w = image_xscale * (sprite_width / 2);
x = STAND.x + lengthdir_x(w, direction);
y = STAND.y + lengthdir_y(w, direction);

var _col1 = collision_line(owner.x, owner.y, owner.x + lengthdir_x(w, direction), owner.y + lengthdir_y(w, direction), ENEMY, false, true); 
if (_col1)
{
    ProjHitTarget(_col1);
}

var _col2 = collision_line(owner.x, owner.y, owner.x + lengthdir_x(w, direction), owner.y + lengthdir_y(w, direction), MOBJ, false, true); 
if (_col2)
{
    if bool("hp" in _col2)
    {
        ProjHitTarget(_col2);
    }
}

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
        [GiveSPTW, global.common_arrow_weight],
        [GiveTe, global.epic_arrow_weight],
        [GiveEP, global.ultimate_arrow_weight],
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
_skills[sk, StandSkill.Skill] = SpBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = SpStrongPunch;
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
