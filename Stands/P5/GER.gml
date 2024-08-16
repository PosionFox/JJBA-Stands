
global.jjbamDiscGer = ItemCreate(
    undefined,
    Localize("standDiscName") + "GER",
    Localize("standDiscDescription") + "Gold Experience Requiem",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscGerUse),
    5 * 10,
    true
);

#define DiscGerUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscGer);
    exit;
}
GiveGer(player);

#define RequiemTaunt(m, s)

jj_play_audio(global.sndGerTaunt, 10, false);
EndAtk(s);

#define GerBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndGerBarrage, 10, false);
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
                    onHitSound = other.barrageData.hitSound;
                    onHitEvent = SpawnNullEffect;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndGerBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndGerBarrage);
        }
    break;
}
attackStateTimer += DT;

#define ScorpionToss(m, s)

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch(attackState)
{
    case 0:
        xTo = player.x + lengthdir_x(GetStandReach(self) / 2, _dir);
        yTo = player.y + lengthdir_y(GetStandReach(self) / 2, _dir);
        if (attackStateTimer >= 0.2) attackState++;
    break;
    case 1:
        jj_play_audio(global.sndGeHit, 5, false);
        var _dmg = 10 + (player.level * 0.1) + player.dmg;
        var _p = BulletCreate(x, y, _dir, _dmg);
        with (_p)
        {
            image_blend = c_maroon;
            onHitEvent = ScorpionTossSpawn;
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define ScorpionTossSpawn(_, _args, _target)

if (instance_exists(_target))
{
    var _n = _target;
    var _e = ShrinkingCircleEffect(_n.x, _n.y);
    _e.color = c_lime;
    _e.radius = 8;
    with (owner)
    {
        ScorpionCreate(_n.x, _n.y);
    }
}

#define SpawnNullEffect

EffectNullCreate(x, y)

#define TransformIntoGer(m, s)

if (attackState >= 3)
{
    angleTarget = random_range(-10, 10);
    angleTargetSpd = 0.2;
}

switch (attackState)
{
    case 0:
        angleTarget = 15;
        ShrinkingCircleEffect(x, y);
        jj_play_audio(global.sndGeStab, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer > 1)
        {
            EffectCircleCreate(x, y, 16, 2)
            attackState++;
        }
    break;
    case 2:
        if (attackStateTimer > 2)
        {
            angleTarget = -15;
            jj_play_audio(global.sndGeBreak, 5, false);
            repeat (5)
            {
                EffectGeParticleCreate(x, y, color);
            }
            EffectCircleCreate(x, y, 32, 4)
            attackState++;
        }
    break;
    case 3:
        if (attackStateTimer > 3)
        {
            EffectCircleCreate(x, y, 64, 8)
            attackState++;
        }
    break;
    case 4:
        ShrinkingCircleEffect(x, y);
        jj_play_audio(global.sndGeRequiem, 5, false);
        skills = gerMoveset;
        active = false;
        requiemActive = true;
        requiemTimer = 30;
        sprite_index = global.sprGER;
        color = 0x9ac3ee;
        summonSound = global.sndGerSummon;
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define GiveGer(_owner)

var _skills = StandSkillInit();
var _skillsGer = StandSkillInit();
var sk;

#region ge moveset

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = LifeFormPlant;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormPlant;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = Localize("lifeformPlantDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = LifeFormScorpion;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormScorpion;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = Localize("lifeformScorpionDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = LifeFormFrog;
_skills[sk, StandSkill.Icon] = global.sprSkillLifeFormFrog;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = Localize("lifeformFrogDesc");


sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 7;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = LifePunch;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("lifePunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = SelfHeal;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.DamagePlayerStat] = false;
_skills[sk, StandSkill.Icon] = global.sprSkillSelfHeal;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = Localize("selfHealDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TransformIntoGer;
_skills[sk, StandSkill.Icon] = global.sprSkillRequiem;
_skills[sk, StandSkill.MaxCooldown] = 60;
_skills[sk, StandSkill.Desc] = Localize("requiemDesc");

#endregion

#region GER moveset

sk = StandState.SkillAOff;
_skillsGer[sk, StandSkill.Skill] = RequiemTaunt;
_skillsGer[sk, StandSkill.Icon] = global.sprSkillSkip;
_skillsGer[sk, StandSkill.MaxCooldown] = 10;
_skillsGer[sk, StandSkill.Desc] = "requiem";

sk = StandState.SkillA;
_skillsGer[sk, StandSkill.Skill] = GerBarrage;
_skillsGer[sk, StandSkill.Damage] = 4;
_skillsGer[sk, StandSkill.DamageScale] = 0.4;
_skillsGer[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skillsGer[sk, StandSkill.MaxCooldown] = 3;
_skillsGer[sk, StandSkill.MaxExecutionTime] = 9;
_skillsGer[sk, StandSkill.Desc] = Localize("gerBarrageDesc");

sk = StandState.SkillB;
_skillsGer[sk, StandSkill.Skill] = LifePunch;
_skillsGer[sk, StandSkill.Damage] = 10;
_skillsGer[sk, StandSkill.DamageScale] = 0.2;
_skillsGer[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skillsGer[sk, StandSkill.MaxCooldown] = 4;
_skillsGer[sk, StandSkill.Desc] = Localize("lifePunchDesc");

sk = StandState.SkillC;
_skillsGer[sk, StandSkill.Skill] = ScorpionToss;
_skillsGer[sk, StandSkill.Icon] = global.sprSkillLifeFormScorpion;
_skillsGer[sk, StandSkill.MaxCooldown] = 5;
_skillsGer[sk, StandSkill.Desc] = Localize("scorpionTossDesc");

sk = StandState.SkillD;
_skillsGer[sk, StandSkill.Skill] = SelfHeal;
_skillsGer[sk, StandSkill.Damage] = 2;
_skillsGer[sk, StandSkill.DamageScale] = 0.15;
_skillsGer[sk, StandSkill.DamagePlayerStat] = false;
_skillsGer[sk, StandSkill.Icon] = global.sprSkillSelfHeal;
_skillsGer[sk, StandSkill.MaxCooldown] = 6;
_skillsGer[sk, StandSkill.Desc] = Localize("selfHealDesc");


#endregion

sk = StandState.SkillD;

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Gold Experience";
    sprite_index = global.sprGoldExperience;
    color = 0x36f2fb;
    summonSound = global.sndGeSummon;
    requiemActive = false;
    requiemTimer = 0;
    
    baseMoveset = _skills;
    gerMoveset = _skillsGer;
    
    discType = global.jjbamDiscGer;
    saveKey = "jjbamGer";
    
    barrageData.hitSound = global.sndGeHit;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GerStep))
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(GerDrawGUI))
}
return _s;

#define GerStep

if (requiemActive)
{
    requiemTimer -= DT;
    if (requiemTimer <= 0)
    {
        skills = baseMoveset;
        EndAtk(StandState.SkillD);
        ShrinkingCircleEffect(x, y);
        active = false;
        sprite_index = global.sprGoldExperience;
        color = 0x36f2fb;
        summonSound = global.sndGeSummon;
        if (audio_is_playing(global.sndGerBarrage))
        {
            audio_stop_sound(global.sndGerBarrage);
        }
        requiemActive = false;
    }
    EffectStandAuraCreate(player.x, player.y - 2, global.sprStandParticle2, c_aqua);
    player.invulFrames = 10;
}

#define GerDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

var _txt = "";
if (requiemActive) _txt = "requiem";

draw_set_color(c_yellow);
draw_text(256+60, _height - (160-10), _txt);
draw_set_color(c_white);

