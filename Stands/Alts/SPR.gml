
global.jjbamDiscSpr = ItemCreate(
    undefined,
    tr("standDiscName") + "SPR",
    tr("standDiscDescription") + "Star Platinum Retro",
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

#define SprTimestop(method, s)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        angleTarget = 25;
        jj_play_audio(global.sndSprTs, 5, false);
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
    color = Color.Lime;
    colorAlt = Color.DarkGreen;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjbamSpr";
    discType = global.jjbamDiscSpr;
    scarf_color = Color.Gold;
    
    summonSound = global.sndSprSummon;
    soundWhenHurt = [global.sndSprHurt1, global.sndSprHurt2, global.sndSprHurt3];
    soundWhenDead = global.sndSprDead;
    
    barrageData.sound = global.sndSprBarrage;
    
    skills[StandState.SkillB, StandSkill.Vars] = { cry_sound : global.sndSprOra };
    skills[StandState.SkillC, StandSkill.Vars] = { star_sound : global.sndSprStaar, finger_sound : global.sndSprFinger };
    skills[StandState.SkillD, StandSkill.Skill] = SprTimestop;
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
    
    evolutions = [];
}
return _s;
