
global.jjbamDiscDw = ItemCreate(
    undefined,
    Localize("standDiscName") + "DW",
    Localize("standDiscDescription") + "Dark World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscDwUse),
    5 * 10,
    true
);

#define DiscDwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscDw);
    exit;
}
GiveDw(player);

#define GiveDw(_owner) //stand

var _s = GiveShadowTheWorld(_owner);
with (_s)
{
    name = "Dark World";
    sprite_index = global.sprDW;
    color = /*#*/0x3c2845;
    UpdateRarity(Rarity.Legendary);
    summonSound = global.sndStw2Summon;
    saveKey = "jjbamDw";
    discType = global.jjbamDiscDw;
    auraParticleSprite = global.sprStandParticle2;
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
}
return _s;
