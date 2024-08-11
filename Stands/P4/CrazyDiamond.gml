
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

#define ToggleHealingMode(m, s)

healingMode = !healingMode;
jj_play_audio(global.sndHealingMode, 0, false);
EndAtk(s);

#define GiveCrazyDiamond(_owner)

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
//_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("diosKnifeDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = CdStrongPunch;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
//_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("spStrongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StandBearingShot;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.5;
//_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("starFingerDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = ToggleHealingMode;
//_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = Localize("spTimestopDesc");

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
    
    InstanceAssignMethod(self, "step", ScriptWrap(CrazyDiamondStep));
}
return _s;

#define CrazyDiamondStep

if (healingMode)
{
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
