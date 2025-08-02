
global.jjbamDiscPd4clt = ItemCreate(
    undefined,
    tr("standDiscName") + "PD4CLT",
    tr("standDiscDescription") + "Patriot D4C Love Train",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscPd4cltUse),
    5 * 10,
    true
);

#define DiscPd4cltUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscPd4clt);
    exit;
}
GivePd4clt(player);

#define GivePd4clt(_owner) //stand

var _s = GiveD4CLT(_owner);
with (_s)
{
    sprite_index = global.sprPD4CLT;
    name = "Patriot D4C\nLove Train";
    color = Color.Blue;
    colorAlt = Color.BrightRed;
    UpdateRarity(Rarity.Epic);
    auraParticleSprite = global.sprStandParticle4;
    saveKey = "jjbamPd4clt";
    discType = global.jjbamDiscPd4clt;
    
    skills[StandState.SkillD, StandSkill.Vars] = { ray_colors : colorAlt };
}
return _s;


