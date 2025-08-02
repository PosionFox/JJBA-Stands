
global.jjbamDiscSpp = ItemCreate(
    undefined,
    tr("standDiscName") + "SPP",
    tr("standDiscDescription") + "Star Platinum Prime",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscSppUse),
    5 * 10,
    true
);

#define DiscSppUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSpp);
    exit;
}
GiveSpp(player);

#define GiveSpp(_owner) //stand

var _s = GiveStarPlatinum(_owner);
with (_s)
{
    name = "Star Platinum Prime";
    sprite_index = global.sprSPP;
    color = Color.Aqua;
    colorAlt = Color.Blue;
    UpdateRarity(Rarity.Epic);
    saveKey = "jjbamSpp";
    discType = global.jjbamDiscSpp;
    ik_scarf = ik_create(8, 2);
    
    skills[StandState.SkillD, StandSkill.SkillAlt] = AttackHandler;
}
return _s;
