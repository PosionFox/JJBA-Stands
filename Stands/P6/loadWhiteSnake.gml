
//wip
global.jjbamDiscWs = ItemCreate(
    undefined,
    "DISC:WS",
    "The label says: WhiteSnake",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscWsUse),
    5 * 10,
    true
);

#define DiscWsUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscWs);
    exit;
}
GiveWhiteSnake(player);

#define WsBarrage(method, skill) //attacks
var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = DIR_PLAYER_TO_MOUSE;

var _exdir = skills[skill, StandSkill.ExecutionTime] * 20;
xTo = owner.x + lengthdir_x(8 + _exdir, _dir + random_range(-2, 2));
yTo = owner.y + lengthdir_y(8 + _exdir, _dir + random_range(-2, 2));
image_xscale = mouse_x > owner.x ? 1 : -1;

attackStateTimer += DT;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.12)
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

#define AcidicSpit(m, s)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = other.skills[s, StandSkill.Damage];
    baseSpd = 8;
    direction = _dir;
    canMoveInTs = false;
    //sprite_index = global.sprKnife;
    image_blend = c_lime;
}
FireCD(s);
state = StandState.Idle;

#define Pilot(m, s)

isPilot = !isPilot;
FireCD(s);
state = StandState.Idle;

#define GiveWhiteSnake(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = WsBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.\ndmg: " + DMG;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = GunShot;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.\ndmg: " + DMG;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AcidicSpit;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.\ndmg: " + DMG;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = Pilot;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "WhiteSnake";
    sprite_index = global.sprWhiteSnake;
    color = /*#*/0xfcdbcb;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamWs";
    discType = global.jjbamDiscWs;
    
    isPilot = false;
}
return _s;
