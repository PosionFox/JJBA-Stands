
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

#define SpovaTimestop(m, s)

jj_play_audio(global.sndSpovaTs, 5, false);
TimestopCreate(5 + (0.1 * player.level));
EndAtk(s);

#define GiveSpova(_owner) //stand

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum OVA";
    sprite_index = global.sprSPOVA;
    color = 0x826030;
    colorAlt = 0xff9b63;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjbamSpova";
    discType = global.jjbamDiscSpova;
    
    summonSound = global.sndSpovaSummon;
    
    barrageData.sound = global.sndSpovaBarrage;
    
    skills[StandState.SkillB, StandSkill.Vars] = { cry_sound : global.sndSpovaStrongPunch };
    skills[StandState.SkillD, StandSkill.Skill] = SpovaTimestop;
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
    
    evolutions = [];
}
return _s;
