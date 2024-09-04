
global.jjbamDiscCd = ItemCreate(
    undefined,
    Localize("standDiscName") + "CD",
    Localize("standDiscDescription") + "Crazy Diamond",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscHeUse),
    5 * 10,
    true
);

#define DiscCdUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscCd);
    exit;
}
GiveCrazyDiamond(player);

#define CdStrongPunch(m, s)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndCdPunch, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(s), 3);
        _p.onHitSound = global.sndStrongPunch;
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define StandBearingShot(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;

switch (attackState)
{
    case 0:
        xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
        yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
        if (attackStateTimer >= 0.25) attackState++;
    break;
    case 1:
        var _snd = jj_play_audio(global.sndGunShot, 0, false);
        audio_sound_pitch(_snd, 2);
        BulletCreate(x, y, _dir, GetDmg(s));
        EndAtk(s);
    break;
}

attackStateTimer += DT;

#define EnableHealingMode(m, s)

healingMode = true;
jj_play_audio(global.sndHealingMode, 0, false);
EndAtk(s);

#define HealingBarrage(_, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        if barrageData.sound != noone jj_play_audio(barrageData.sound, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= (0.08 / GetStandSpeed(self)))
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                with (_p)
                {
                    targets = [ENEMY, MOBJ, NATURAL, CRITTER, STRUCTURE];
                    damage = -damage;
                    if other.barrageData.hitSound != noone onHitSound = other.barrageData.hitSound;
                    if other.barrageData.hitEvent != noone onHitEvent = other.barrageData.hitEvent;
                    if other.barrageData.hitEventArgs != noone onHitEventArg = other.barrageData.hitEventArgs;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            if barrageData.sound != noone audio_stop_sound(barrageData.sound);
        }
    break;
}
attackStateTimer += DT;

#define HealingPunch(_, s)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndCdPunch, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(s), 3);
        _p.onHitSound = global.sndStrongPunch;
        _p.targets = [ENEMY, MOBJ, NATURAL, CRITTER, STRUCTURE];
        _p.damage = -_p.damage;
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define DisableHealingMode(_, s)

healingMode = false;
EndAtk(s);

#define GiveCrazyDiamond(_owner)

var _skills = StandSkillInit();
var _skillsHeal = StandSkillInit();

var sk;

#region default moveset

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = CdStrongPunch;
_skills[sk, StandSkill.Damage] = 20;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.SkillAlt] = GroundSlam;
_skills[sk, StandSkill.DamageAlt] = 30;
_skills[sk, StandSkill.IconAlt] = global.sprSkillDetonate;
_skills[sk, StandSkill.MaxCooldownAlt] = 12;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StandBearingShot;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.5;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = EnableHealingMode;
//_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 1;

#endregion

#region healing moveset

sk = StandState.SkillA;
_skillsHeal[sk, StandSkill.Skill] = HealingBarrage;
_skillsHeal[sk, StandSkill.Damage] = 1.5;
_skillsHeal[sk, StandSkill.DamageScale] = 0.02;
_skillsHeal[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skillsHeal[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillB;
_skillsHeal[sk, StandSkill.Skill] = HealingPunch;
_skillsHeal[sk, StandSkill.Damage] = 20;
_skillsHeal[sk, StandSkill.DamageScale] = 0.1;
_skillsHeal[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skillsHeal[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillD;
_skillsHeal[sk, StandSkill.Skill] = DisableHealingMode;
//_skillsHeal[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skillsHeal[sk, StandSkill.MaxCooldown] = 1;

#endregion

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Crazy Diamond"
    sprite_index = global.sprCrazyDiamond;
    color = 0xe4cd5f;
    healingMode = false;
    summonSound = global.sndCdSummon;
    UpdateRarity(Rarity.Common);
    saveKey = "jjbamCd";
    discType = global.jjbamDiscCd;
    barrageData.sound = global.sndCdBarrage;
    barrageData.hitSound = [global.sndCdHit1, global.sndCdHit2, global.sndCdHit3, global.sndCdHit4, global.sndCdHit5];
    
    baseMoveset = _skills;
    healMoveset = _skillsHeal;
    
    InstanceAssignMethod(self, "step", ScriptWrap(CrazyDiamondStep));
}
return _s;

#define CrazyDiamondStep

if (healingMode)
{
    skills = healMoveset;
    var _xx = x + random_range(-8, 8);
    var _yy = y + random_range(-8, 8) - height;
    var _e = ShrinkingCircleEffect(_xx, _yy);
    with (_e)
    {
        depth = other.depth + 1;
        color = c_yellow;
        radius = 2;
    }
}
else
{
    skills = baseMoveset;
}
