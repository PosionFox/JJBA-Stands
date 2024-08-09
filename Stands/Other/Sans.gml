

global.jjbamDiscSans = ItemCreate(
    undefined,
    Localize("standDiscName") + "SANS",
    Localize("standDiscDescription") + "Sans",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSansUse),
    5 * 10,
    true
);

#define DiscSansUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSans);
    exit;
}
GiveSans(player);

#define GroundBone(_, s)

var _dir = owner.attack_direction;

var _dmg = 1;
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    sprite_index = global.sprGroundBone;
    image_speed = 0.25;
    damage = _dmg;
    baseSpd = 2;
    z = 0
    onHitSound = global.sndSoulDamaged;
    onHitSoundOverlap = true;
    rotate_with_direction = false;
    direction = _dir;
    canMoveInTs = false;
    destroyOnImpact = false;
    multihit = true;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GroundBoneStep));
}
EndAtk(s);

#define GroundBoneStep

if (image_index >= 2)
{
    image_speed = 0;
}

#define SansTp(m, s)

if (!WaterCollision(mouse_x, mouse_y) and !modTypeExists("timestop"))
{
    EffectBlackScreen(0.1);
    jj_play_audio(global.sndSansTp, 5, false);
    player.x = mouse_x;
    player.y = mouse_y;
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define GiveSans(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = GroundBone;
_skills[sk, StandSkill.Damage] = 0.001;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("diosKnifeDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = SansTp;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 5;

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = SpBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = SpStrongPunch;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = Localize("spStrongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = Localize("starFingerDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = SpTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.SkillAlt] = SpEvolveToSptw;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStwTw;
_skills[sk, StandSkill.MaxHold] = 2;
_skills[sk, StandSkill.Desc] = Localize("spTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Sans";
    sprite_index = global.sprSans;
    color = 0xffffff;
    UpdateRarity(Rarity.Ultimate);
    discType = global.jjbamDiscSans;
    saveKey = "jjbamSans";
    
    InstanceAssignMethod(self, "step", ScriptWrap(SansStep))
}
return _s;

#define SansStep

if (active)
{
    var _xx = x + (5 * owner.facing);
    var _o = ModObjectSpawn(_xx, y - 5 - height, depth - 1);
    with (_o)
    {
        sprite_index = global.sprStandParticle;
        image_blend = c_aqua;
        if (other.owner.facing == 1)
        {
            direction = random_range(-25, 25);
        }
        else
        {
            direction = random_range(155, 205);
        }
        speed = irandom(3);
        
        InstanceAssignMethod(self, "step", ScriptWrap(SansEyeParticleStep))
    }
}

#define SansEyeParticleStep

image_xscale = lerp(image_xscale, 0, 0.2);
image_yscale = lerp(image_yscale, 0, 0.2);
if (image_xscale <= 0.02)
{
    instance_destroy(self);
}
