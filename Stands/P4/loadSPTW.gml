
global.jjbamDiscSptw = ItemCreate(
    undefined,
    tr("standDiscName") + "SPTW",
    tr("standDiscDescription") + "Star Platinum: The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSptwUse),
    5 * 10,
    true
);

#define DiscSptwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSptw);
    exit;
}
GiveSPTW(player);

#define BearingShot(m, s)

var _dir = owner.attack_direction;
var _snd = jj_play_audio(global.sndGunShot, 0, false);
audio_sound_pitch(_snd, 2);
BulletCreate(x, y, _dir, GetDmg(s));
EndAtk(s);

#define TimeStopTeleport(m, s)

var _aim = get_aim_position(self);
if (!WaterCollision(_aim.x, _aim.y) and !modTypeExists("timestop"))
{
    EffectWhiteScreen(0.1);
    jj_play_audio(global.sndSptwTp, 5, false);
    player.x = _aim.x;
    player.y = _aim.y;
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define SptwTimestop(method, skill)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        var _tsExists = modTypeExists("timestop");

        if (_tsExists)
        {
            instance_destroy(modTypeFind("timestop"));
        }
        angleTarget = 25;
        jj_play_audio(global.sndSptwTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.8)
        {
            attackState++;
        }
    break;
    case 2:
        //jj_play_audio(global.sndTwrTs, 5, false);
        var _time = (5 + (0.1 * owner.level)) * GetStandTotalPower(self);
        var ts = TimestopCreate(_time);
        ts.resumeSound = global.sndTwTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 4:
        //jj_play_audio(global.sndStwTokiyotomare, 5, false);
        EndAtk(skill);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define GiveSPTW(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = tr("diosKnifeDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = Soda;
_skills[sk, StandSkill.Icon] = global.sprSkillSoda;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = tr("sodaDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = BearingShot;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.5;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.Desc] = tr("bearingShotDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TimeStopTeleport;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = tr("tsTpDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.SkillAlt] = GroundSlam;
_skills[sk, StandSkill.DamageAlt] = 40;
_skills[sk, StandSkill.DamageScaleAlt] = 0.02;
_skills[sk, StandSkill.IconAlt] = global.sprSkillGroundSlam;
_skills[sk, StandSkill.MaxCooldownAlt] = 12;
_skills[sk, StandSkill.Desc] = tr("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Vars] = { cry_sound : global.sndSpStrongPunch, hit_sound : global.sndStrongPunch };
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = tr("spStrongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = tr("starFingerDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SptwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = tr("sptwTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Star Platinum\nThe World";
    sprite_index = global.sprSptw;
    color = Color.Blue;
    colorAlt = Color.Pink;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamSptw";
    discType = global.jjbamDiscSptw;
    
    knifeSprite = global.sprKnife;
    barrageData.sound = global.sndSpBarrage;
    scarf_sprite = global.sprScarf;
    scarf_color = Color.White;
    target_x = x;
    target_y = y;
    ik_scarf = ik_create(5, 2);
    
    variants[0] = [sprite_index, rarity.tier];
    variants[1] = [global.sprTimeEmperor, Rarity.Epic];
    variants[2] = [global.sprEP, Rarity.Ultimate];
    
    InstanceAssignMethod(self, "step", ScriptWrap(StarPlatinumStep), false);
    pre_draw = ScriptWrap(StarPlatinumPreDraw);
}
return _s;
