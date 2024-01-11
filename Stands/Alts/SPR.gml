
global.jjbamDiscSpr = ItemCreate(
    undefined,
    Localize("standDiscName") + "SPR",
    Localize("standDiscDescription") + "Star Platinum Retro",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSprUse),
    5 * 10,
    true
);

#define DiscSprUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpr);
    exit;
}
GiveSpr(player);

#define SprBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSprBarrage, 10, false);
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
            audio_stop_sound(global.sndSprBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndSprBarrage);
        }
    break;
}
attackStateTimer += DT;

#define SprStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSprOra, 0, false);
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

#define SprStarFinger(method, skill) //attacks

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > player.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSprStaar, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.15)
        {
            attackState++;
        }
    break;
    case 2:
        audio_play_sound(global.sndSprFinger, 0, false);
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

#define SprTimestop(method, s)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        angleTarget = 25;
        audio_play_sound(global.sndSprTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.9)
        {
            attackState++;
        }
    break;
    case 2:
        angleTargetSpd = 0.3;
        angleTarget = -25;
        
        var ts = TimestopCreate(5 + (0.1 * player.level));
        ts.resumeSound = global.sndSprTsResume;
        attackState++;
    break;
    case 3:
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define GiveSpr(_owner) //stand

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum Retro";
    sprite_index = global.sprSPR;
    color = 0xe4cd5f;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjbamSpr";
    discType = global.jjbamDiscSpr;
    
    summonSound = global.sndSprSummon;
    soundWhenHurt = [global.sndSprHurt1, global.sndSprHurt2, global.sndSprHurt3];
    soundWhenDead = global.sndSprDead;
    
    skills[StandState.SkillA, StandSkill.Skill] = SprBarrage;
    skills[StandState.SkillB, StandSkill.Skill] = SprStrongPunch;
    skills[StandState.SkillC, StandSkill.Skill] = SprStarFinger;
    skills[StandState.SkillD, StandSkill.Skill] = SprTimestop;
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
}
return _s;
