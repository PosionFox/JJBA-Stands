
global.jjbamDiscTwf = ItemCreate(
    undefined,
    tr("standDiscName") + "TWF",
    tr("standDiscDescription") + "The World Frozen",
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
        jj_play_audio(global.sndTwfTs, 5, false);
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
    color = Color.Aqua;
    colorAlt = Color.Red;
    UpdateRarity(Rarity.Event);
    saveKey = "jjbamTwf";
    discType = global.jjbamDiscTwf;
    
    auraParticleSprite = global.sprStandParticleSnowflake;
    summonSound = global.sndTwfSummon;
    soundIdle = [global.sndTwfIdle1, global.sndTwfIdle2, global.sndTwfIdle3, global.sndTwfIdle4, global.sndTwfIdle5];
    
    barrageData.sound = global.sndTwfBarrage;
    
    skills[StandState.SkillD, StandSkill.Skill] = TwfTimestop;
    
    evolutions = [];
    
    cape_sprite = global.sprTWFCape;
    cape_color = Color.Red;
    target_x = x;
    target_y = y;
    ik_scarf = ik_create(4, 2);
    
    InstanceAssignMethod(self, "step", ScriptWrap(TheWorldFrozenStep), false);
    pre_draw = ScriptWrap(TheWorldFrozenPreDraw);
}
return _s;

#define TheWorldFrozenStep

target_x = lerp(target_x, x - (16 * image_xscale), 0.1);
target_y = lerp(target_y, y + 8 + (sin(current_time / 1000) * 4), 0.1);

inverse_kinematics(ik_scarf, x - (3 * scaleX), y - height - 2, target_x, target_y);

#define TheWorldFrozenPreDraw

if (alphaTarget > 0)
{
    draw_ik(ik_scarf, cape_sprite, cape_color);
}
