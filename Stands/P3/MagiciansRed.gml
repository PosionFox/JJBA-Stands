
global.jjbamDiscMr = ItemCreate(
    undefined,
    Localize("standDiscName") + "MR",
    Localize("standDiscDescription") + "Magician's Red",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscMrUse),
    5 * 10,
    true
);

#define DiscMrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscMr);
    exit;
}
GiveMagiciansRed(player);

#define BurningKnife(_, s)

var _dir = owner.attack_direction;

var _dmg = GetDmg(s);
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = _dmg;
    baseSpd = 8;
    onHitEvent = KnifeBurn;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = other.knifeSprite;
}
EndAtk(s);

#define KnifeBurn

if (enemy_instance_exists())
{
    var _near = get_nearest_enemy(x, y);
    LastingDamageCreate(_near, 0.002, 3, true);
    FireEffect(c_red, c_yellow);
}

#define GiveMagiciansRed(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = BurningKnife;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = Localize("josephKnifeDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 30;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("stopSignDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TwBloodDrain;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = Localize("bloodDrainDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TimeStopTeleport;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = Localize("tsTpDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = TwBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 25;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("strongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TwKnifeWall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("knifeWallDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = Localize("twTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Magician's Red";
    sprite_index = global.sprMagiciansRed;
    color = 0x3232ac;
    summonSound = global.sndTwSummon;
    discType = global.jjbamDiscMr;
    saveKey = "jjbamMr";
    knifeSprite = global.sprKnife;
}
return _s;

