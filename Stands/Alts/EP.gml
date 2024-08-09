
global.jjbamDiscEP = ItemCreate(
    undefined,
    Localize("standDiscName") + "EP",
    Localize("standDiscDescription") + "Estrella Platinada",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    4992,
    0,
    0,
    [],
    ScriptWrap(DiscEPUse),
    5 * 10,
    true
);

#define DiscEPUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscEP);
    exit;
}
GiveEP(player);

#define EpTimestop(m, s)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        angleTarget = 25;
        jj_play_audio(global.sndEpTs, 5, false);
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
        //ts.resumeSound = global.sndSprTsResume;
        attackState++;
    break;
    case 3:
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define GiveEP(_owner) //stand

var _s = GiveSPTW(_owner);
with (_s)
{
    name = "Estrella Platinada";
    sprite_index = global.sprEP;
    color = 0x6e9437;
    UpdateRarity(Rarity.Ultimate);
    saveKey = "jjbamEp";
    discType = global.jjbamDiscEP;
    
    summonSound = global.sndEpSummon;
    
    skills[StandState.SkillD, StandSkill.Skill] = EpTimestop;
}
return _s;

