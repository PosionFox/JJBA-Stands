
global.jjbamDiscSpova = ItemCreate(
    undefined,
    Localize("standDiscName") + "SPOVA",
    Localize("standDiscDescription") + "Star Platinum OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSpovaUse),
    5 * 10,
    true
);

#define DiscSpovaUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpova);
    exit;
}
GiveSpova(player);

#define SpovaBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpovaBarrage, 10, false);
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
            audio_stop_sound(global.sndSpovaBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndSpovaBarrage);
        }
    break;
}
attackStateTimer += DT;

#define SpovaStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpovaStrongPunch, 0, false);
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

#define SpovaTimestop(m, s)

audio_play_sound(global.sndSpovaTs, 5, false);
TimestopCreate(5 + (0.1 * player.level));
EndAtk(s);

#define GiveSpova(_owner) //stand

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum OVA";
    sprite_index = global.sprSPOVA;
    color = 0x826030;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamSpova";
    discType = global.jjbamDiscSpova;
    
    summonSound = global.sndSpovaSummon;
    
    skills[StandState.SkillA, StandSkill.Skill] = SpovaBarrage;
    skills[StandState.SkillB, StandSkill.Skill] = SpovaStrongPunch;
    skills[StandState.SkillD, StandSkill.Skill] = SpovaTimestop;
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
}
return _s;
