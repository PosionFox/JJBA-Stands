
global.jjbamDiscTwf = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWF",
    Localize("standDiscDescription") + "The World Frozen",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwfUse),
    5 * 10,
    true
);

#define DiscTwfUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwf);
    exit;
}
GiveTWF(player);

#define TwfBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndTwfBarrage, 10, false);
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
            audio_stop_sound(global.sndTwfBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndTwfBarrage);
        }
    break;
}
attackStateTimer += DT;

#define TwfTimestop(method, skill)

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
        audio_play_sound(global.sndTwfTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        var ts = TimestopCreate(9 + (0.05 * player.level));
        ts.resumeSound = global.sndTwfTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.6)
        {
            attackState++;
        }
    break;
    case 4:
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define GiveTWF(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World Frozen";
    sprite_index = global.sprTheWorldFrozen;
    color = 0xe4cd5f;
    UpdateRarity(Rarity.Event);
    saveKey = "jjbamTwf";
    discType = global.jjbamDiscTwf;
    
    auraParticleSprite = global.sprStandParticleSnowflake;
    summonSound = global.sndTwfSummon;
    soundIdle = [global.sndTwfIdle1, global.sndTwfIdle2, global.sndTwfIdle3, global.sndTwfIdle4, global.sndTwfIdle5];
    
    skills[StandState.SkillA, StandSkill.Skill] = TwfBarrage;
    skills[StandState.SkillD, StandSkill.Skill] = TwfTimestop;
}
return _s;
