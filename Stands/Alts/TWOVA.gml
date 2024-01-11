
global.jjbamDiscTwova = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWOVA",
    Localize("standDiscDescription") + "The World OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwovaUse),
    5 * 10,
    true
);

#define DiscTwovaUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwova);
    exit;
}
GiveTwova(player);

#define TwovaBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndTwovaBarrage, 10, false);
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
            audio_stop_sound(global.sndTwovaBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndTwovaBarrage);
        }
    break;
}
attackStateTimer += DT;

#define TwovaStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndTwovaStrongPunch, 0, false);
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

#define TwovaTimestop(method, skill)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        var _tsExists = modTypeExists("timestop");

        if (_tsExists)
        {
            instance_destroy(modTypeFind("timestop"));
        }
        angleTarget = 25;
        audio_play_sound(global.sndTwovaTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        //audio_play_sound(global.sndTwrTs, 5, false);
        
        var ts = TimestopCreate(9 + (0.05 * player.level));
        ts.resumeSound = global.sndTwTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.6)
        {
            attackState++;
        }
    break;
    case 4:
        //audio_play_sound(global.sndStwTokiyotomare, 5, false);
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define GiveTwova(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World OVA";
    sprite_index = global.sprTWOVA;
    color = 0xb7ad9b;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamTwova";
    discType = global.jjbamDiscTwova;
    
    summonSound = global.sndTwovaSummon;
    
    skills[StandState.SkillA, StandSkill.Skill] = TwovaBarrage;
    skills[StandState.SkillB, StandSkill.Skill] = TwovaStrongPunch;
    skills[StandState.SkillD, StandSkill.Skill] = TwovaTimestop;
}
return _s;
