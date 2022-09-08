// wip

global.jjbamDiscSc = ItemCreate(
    undefined,
    "DISC:SC",
    "The label says: Silver Chariot",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscScUse),
    5 * 10,
    true
);

#define DiscScUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscSc);
    exit;
}
GiveSilverChariot(player);

#define ScBarrage(m, skill)
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(xTo, yTo) < 2)
{
    var _cd = 0.08;
    if (isFtl)
    {
        _cd = 0.04;
    }
    if (attackStateTimer >= _cd)
    {
        var _sndSrc = global.sndKnifeThrow;
        if (audio_is_playing(_sndSrc))
        {
            audio_stop_sound(_sndSrc);
        }
        var _snd = audio_play_sound(_sndSrc, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-25, 25);
        var _p = PunchCreate(xx, yy, ddir, GetDmg(skill), 0);
        with (_p)
        {
            sprite_index = global.sprScAttack;
            despawnTime = 0.15;
            onHitSound = global.sndPunchHit;
        }
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
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

#define ScFTL(m, skill)

sprite_index = global.sprSCarmorless;
ExplosionEffect(x, y);
isFtl = true;
FireCD(skill);
state = StandState.Idle;

#define GiveSilverChariot(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = ScBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.Damage] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.Damage] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = ScFTL;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = @"faster than light:
stops the time, most enemies are not allowed to move
and makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Silver Chariot";
    sprite_index = global.sprSilverChariot;
    color = /*#*/0x877e84;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamSc";
    discType = global.jjbamDiscSc;
    
    isFtl = false;
}
