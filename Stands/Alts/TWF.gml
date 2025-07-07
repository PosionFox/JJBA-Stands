
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
    color = 0xe4cd5f;
    colorAlt = 0x6357d9;
    UpdateRarity(Rarity.Event);
    saveKey = "jjbamTwf";
    discType = global.jjbamDiscTwf;
    
    auraParticleSprite = global.sprStandParticleSnowflake;
    summonSound = global.sndTwfSummon;
    soundIdle = [global.sndTwfIdle1, global.sndTwfIdle2, global.sndTwfIdle3, global.sndTwfIdle4, global.sndTwfIdle5];
    
    barrageData.sound = global.sndTwfBarrage;
    
    skills[StandState.SkillD, StandSkill.Skill] = TwfTimestop;
    
    evolutions = [];
}
return _s;
