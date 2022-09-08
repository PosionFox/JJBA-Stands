
global.jjbamDiscKc = ItemCreate(
    undefined,
    "DISC:KC",
    "The label says: King Crimson",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscKcUse),
    5 * 10,
    true
);

#define DiscKcUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscKc);
    exit;
}
GiveKingCrimson(player);

#define KcBarrage(method, skill) //attacks
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += DT;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.08)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-45, 45);
        var _p = PunchCreate(xx, yy, ddir, GetDmg(skill), 0);
        with (_p)
        {
            onHitSound = global.sndGeHit;
            onHitSoundOverlap = true;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StandBarrageStep), true);
        }
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += DT;
}

if (keyboard_check_pressed(ord(skills[skill, StandSkill.Key])))
{
    if (skills[skill, StandSkill.ExecutionTime] > 0)
    {
        FireCD(skill);
    }
    else
    {
        ResetCD(skill);
    }
    state = StandState.Idle;
}

#define KcPos

var xPos = mouse_x > owner.x ? 1 : -1;
xTo = owner.x - (xPos * 8);
yTo = owner.y - 8;
angleTarget = 25 + (cos(current_time / 1000) * 5);
image_xscale = -xPos;


#define GiveKingCrimson(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = LifeFormPlant;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormPlant;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "lifeform plant:\nsummons a random plant.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = LifeFormScorpion;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormScorpion;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = "lifeform scorpion:\nsummons a scorpion that attacks nearby enemies.";

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = LifeFormFrog;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormFrog;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = "lifeform frog:\nsummons a frog that protects you and reflects damage.";

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = GeBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 7;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = LifePunch;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "life punch:\npunches the enemy and pulls their soul out,\nthe soul damages other enemies.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = SelfHeal;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.DamagePlayerStat] = false;
_skills[sk, StandSkill.Icon] = global.sprSkillSelfHeal;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "self heal:\nmends the user's wounds,\nthe effectiveness of the healing is tied to the user's level.";

sk = StandState.SkillD;

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "King Crimson";
    sprite_index = global.sprKingCrimson;
    color = 0x3232ac;
    idlePos = KcPos;
    summonSound = global.sndKcSummon;
    saveKey = "jjbamKc";
    discType = global.jjbamDiscKc;
}
