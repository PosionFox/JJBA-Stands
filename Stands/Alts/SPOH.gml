
global.jjbamDiscSpoh = ItemCreate(
    undefined,
    Localize("standDiscName") + "SPOH",
    Localize("standDiscDescription") + "Star Platinum Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSpohUse),
    5 * 10,
    true
);

#define DiscSpohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpoh);
    exit;
}
GiveSPOH(player);

#define GiveSPOH(_owner) //stand

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum\nOver Heaven";
    sprite_index = global.sprSPOH;
    color = 0xffffff;
    UpdateRarity(Rarity.Ascended);
    saveKey = "jjbamSpoh";
    discType = global.jjbamDiscSpoh;
    auraParticleSprite = global.sprStandParticle5;
    
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
}
return _s;
