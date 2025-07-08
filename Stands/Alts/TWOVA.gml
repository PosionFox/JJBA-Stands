
global.jjbamDiscTwova = ItemCreate(
    undefined,
    tr("standDiscName") + "TWOVA",
    tr("standDiscDescription") + "The World OVA",
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
        jj_play_audio(global.sndTwovaTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        //jj_play_audio(global.sndTwrTs, 5, false);
        
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
        //jj_play_audio(global.sndStwTokiyotomare, 5, false);
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
    colorAlt = 0x30be6a;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamTwova";
    discType = global.jjbamDiscTwova;
    
    summonSound = global.sndTwovaSummon;
    
    barrageData.sound = global.sndTwovaBarrage;
    
    skills[StandState.SkillB, StandSkill.Vars] = { cry_sound : global.sndTwovaStrongPunch };
    skills[StandState.SkillD, StandSkill.Skill] = TwovaTimestop;
    
    evolutions = [];
}
return _s;
