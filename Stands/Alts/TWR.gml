
global.jjbamDiscTwr = ItemCreate(
    undefined,
    tr("standDiscName") + "TWR",
    tr("standDiscDescription") + "The World Retro",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwrUse),
    5 * 10,
    true
);

#define DiscTwrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwr);
    exit;
}
GiveTwr(player);

#define TwrTimestop(method, skill)

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
        jj_play_audio(global.sndStwTheWorld, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        jj_play_audio(global.sndTwrTs, 5, false);
        
        var ts = TimestopCreate(9 + (0.05 * player.level));
        ts.resumeSound = global.sndStwTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.6)
        {
            attackState++;
        }
    break;
    case 4:
        jj_play_audio(global.sndStwTokiyotomare, 5, false);
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define GiveTwr(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World Retro";
    sprite_index = global.sprTWR;
    color = 0x66a0d9;
    colorAlt = 0x30be6a;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjbamTwr";
    discType = global.jjbamDiscTwr;
    
    knifeSprite = global.sprKnifeStw;
    summonSound = global.sndTwrSummon;
    soundWhenHurt = [global.sndStwHurt1, global.sndStwHurt2, global.sndStwHurt3];
    soundWhenDead = global.sndStwDead;
    soundIdle = [global.sndTwrIdle1, global.sndTwrIdle2];
    
    barrageData.sound = global.sndTwrBarrage;
    
    skills[StandState.SkillCOff, StandSkill.Vars] = { cast_sound : [global.sndTwrBd1, global.sndTwrBd2] };
    skills[StandState.SkillB, StandSkill.Vars] = { cry_sound : global.sndTwrMuda };
    skills[StandState.SkillC, StandSkill.Vars] = { toss_sound : global.sndTwrMudada };
    skills[StandState.SkillD, StandSkill.Skill] = TwrTimestop;
    
    evolutions[0] = [global.sprTWROH, global.sprDiosDiary, Rarity.Mythical];
}
return _s;
