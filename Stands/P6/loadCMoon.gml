
//wip
global.jjbamDiscCmn = ItemCreate(
    undefined,
    Localize("standDiscName") + "CMN",
    Localize("standDiscDescription") + "C-Moon",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscCmnUse),
    5 * 10,
    true
);

#define DiscCmnUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscCmn);
    exit;
}
GiveCMoon(player);

#define GravityShift(m, s)

GravityShiftCreate(owner);
EndAtk(s);

#define GravityShiftCreate(_owner)

var _o = ModObjectSpawn(_owner.x, _owner.y, -100000);
with (_o)
{
    life = 5;
    radius = 0;
    alpha = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GravityShiftStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(GravityShiftDraw));
}

#define GravityShiftStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;
alpha = min(life, 1);
radius += DT * 255;

#define GravityShiftDraw

draw_set_alpha(0.5 * alpha);
draw_circle_color(player.x, player.y, radius, c_lime, c_green, false);
draw_set_alpha(image_alpha);

#define GiveCMoon(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = GravityShift;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "C-Moon";
    sprite_index = global.sprCMoon;
    color = 0x30be6a;
    summonSound = global.sndCmSummon;
    saveKey = "jjbamCmn";
    discType = global.jjbamDiscCmn;
}
return _s;
