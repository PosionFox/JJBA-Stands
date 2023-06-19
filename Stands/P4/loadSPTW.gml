
//wip
global.jjbamDiscSptw = ItemCreate(
    undefined,
    "DISC:SPTW",
    "The label says: Star Platinum: The World",
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

var _dir = DIR_PLAYER_TO_MOUSE;
var _snd = audio_play_sound(global.sndGunShot, 0, false);
audio_sound_pitch(_snd, 2);
BulletCreate(x, y, _dir, GetDmg(s));
EndAtk(s);

#define TimeStopTeleport(m, s)

if (!WaterCollision(mouse_x, mouse_y))
{
    audio_play_sound(global.sndSptwTp, 5, false);
    player.x = mouse_x;
    player.y = mouse_y;
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define GiveSPTW(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = "dio's knife:\ntoss one of dio's knife.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = Soda;
_skills[sk, StandSkill.Icon] = global.sprSkillSoda;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "soda:\ndrink from a fresh can of soda.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = BearingShot;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.5;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.Desc] = "bearing shot:\ntoss a projectile forward.";

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TimeStopTeleport;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "time stop teleport:\nteleport where you cursor is at.";

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 10;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = @"strong punch:
charges and launches a strong punch.

(hold) melee pull:
pulls the enemy towards you.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SpTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "star platinum the world:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Star Platinum:\nThe World";
    sprite_index = global.sprSptw;
    color = /*#*/0xff9b63;
    summonSound = global.sndSpSummon;
    saveKey = "jjbamSptw";
    discType = global.jjbamDiscSptw;
    
    knifeSprite = global.sprKnife;
}
