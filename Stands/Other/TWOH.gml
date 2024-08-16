
global.jjbamDiscTwoh = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWOH",
    Localize("standDiscDescription") + "The World Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscTwohUse),
    5 * 10,
    true
);

#define DiscTwohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwoh);
    exit;
}
GiveTWOH(player);

#define LightningKnifes(m, s)

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
var _snd = jj_play_audio(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));

for (var i = 0; i < 3; i++)
{
    var _dmg = GetDmg(s);
    var _p = ProjectileCreate(player.x, player.y);
    with (_p)
    {
        var _d = (_dir - 16) + (i * 16);
        damage = _dmg;
        direction = _d;
        canMoveInTs = false;
        sprite_index = other.knifeSprite;
        onHitEvent = LightningKnifesEvent;
    }
}
EndAtk(s);

#define LightningKnifesEvent

var _near = self;
if (enemy_instance_exists())
{
    _near = get_nearest_enemy(x, y);
    instance_create_depth(_near.x, _near.y, _near.depth, objLightning);
    ZapSpawn(_near);
}

#define KnifeBuryal(m, s)

EffectWhiteScreen(0.1);
jj_play_audio(global.sndTwohTp, 5, false);
var _target = get_nearest_enemy(mouse_x, mouse_y);
var _k = 16;
for (var i = 0; i <= _k; i++)
{
    var _xx = _target.x + lengthdir_x(128, i * (360 / _k));
    var _yy = _target.y + lengthdir_y(128, i * (360 / _k));
    var _p = ProjectileCreate(_xx, _yy);
    var _dmg = GetDmg(s);
    with (_p)
    {
        var _dir = (i * (360 / _k)) - 180;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = other.knifeSprite;
    }
}
EndAtk(s);

#define RealityHeal(m, s)

var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(-8, _dir);
yTo = owner.y + lengthdir_y(-8, _dir);
image_xscale = sign(dcos(_dir));
alphaTarget = 1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 1:
        if (instance_exists(owner))
        {
            var _s = jj_play_audio(global.sndTwohRealityOverwrite, 0, false);
            var _s2 = jj_play_audio(global.sndTwohHeal, 0, false);
            audio_sound_pitch(_s, random_range(0.8, 1.2));
            audio_sound_pitch(_s2, random_range(0.8, 1.2));
            owner.hp += 1 + owner.hpMax / 2;
            player.energy += 25;
            SpawnNullEffect();
            SpawnNullEffect();
            EndAtk(s)
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define TwohTsTp(m, s)

if (!WaterCollision(mouse_x, mouse_y) and !modTypeExists("timestop"))
{
    EffectWhiteScreen(0.1);
    jj_play_audio(global.sndTwohTp, 5, false);
    player.x = mouse_x;
    player.y = mouse_y;
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define ThunderousWave(m, s)

var _dir = point_direction(x, y, mouse_x, mouse_y);
xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);
image_xscale = sign(dcos(_dir));
alphaTarget = 1;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 1:
        jj_play_audio(global.sndTwohWave, 0, false);
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            damage = _dmg;
            canMoveInTs = true;
            canDespawnInTs = true;
            explosionTimer = 0.1;
            destroyOnImpact = false;
            direction = _dir;
            despawnTime = 1;
            visible = false;
            
            InstanceAssignMethod(self, "step", ScriptWrap(ThunderousWaveStep));
        }
        EndAtk(s)
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define ThunderousWaveStep

if (explosionTimer <= 0)
{
    ExplosionCreate(x, y, 32, false);
    explosionTimer = 0.1;
}
explosionTimer -= DT;

#define TwohBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndTwBarrage, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.08 / GetStandSpeed(self))
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                _p.onHitEvent = TwohBarrageStep;
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndTwBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndTwBarrage);
        }
    break;
}
attackStateTimer += DT;

#define TwohBarrageStep

var _e = EffectCircleLerpCreate(x, y, 8, 2);
_e.growingSpd = 0.5;
_e.life = 0.5;

#define MeleeCombo(m, s)

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dis = 12;
xTo = objPlayer.x + lengthdir_x(_dis, _dir);
yTo = objPlayer.y + lengthdir_y(_dis, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.1) attackState++;
    break;
    case 1:
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchSwingCreate(x, y, _dir, 45, GetDmg(s));
        attackState++;
    break;
    case 2:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 3:
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchSwingCreate(x, y, _dir, 45, GetDmg(s));
        attackState++;
    break;
    case 4:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 5:
        _dis = 16;
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchSwingCreate(x, y, _dir, 45, GetDmg(s) * 2);
        _p.onHitSound = global.sndStrongPunch;
        EndAtk(s);
    break;
}

attackStateTimer += DT * GetStandSpeed(self);

#define RealityOverwritePunch(m, s)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(8, _dir);
var _yy = player.y + lengthdir_y(8, _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        //jj_play_audio(global.sndTwrMuda, 0, false);
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
        _p.onHitSound = global.sndTwohRealityOverwrite;
        _p.onHitEvent = OverwriteHealth;
        EndAtk(s);
        break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define OverwriteHealth(_, _args, _target)

if (instance_exists(_target))
{
    _target.hp -= _target.hp * 0.2;
}
repeat (5)
{
    SpawnNullEffect();
}
EffectCircleCreate(x, y, 16, 4);

#define TwohTimestop(m, s)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        var _tsExists = modTypeExists("timestop");

        if (_tsExists)
        {
            instance_destroy(modTypeFind("timestop"));
            EndAtk(s);
        }
        attackState++;
    break;
    case 1:
        jj_play_audio(global.sndTwohTs, 5, false);
        attackState++;
    break;
    case 2:
        if (attackStateTimer >= 2) attackState++;
    break;
    case 3:
        var ts = TimestopCreate(99999999);
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define GiveTWOH(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World\nOver Heaven";
    sprite_index = global.sprTWOH;
    color = 0xffffff;
    desummonSound = summonSound;
    UpdateRarity(Rarity.Common);
    saveKey = "jjbamTwoh";
    discType = global.jjbamDiscTwoh;
    zapTimer = 5;
    
    skills[StandState.SkillCOff, StandSkill.Skill] = RealityHeal;
    skills[StandState.SkillCOff, StandSkill.Icon] = global.sprSkillSelfHeal;
    skills[StandState.SkillCOff, StandSkill.Desc] = Localize("realityHealDesc");
    
    skills[StandState.SkillDOff, StandSkill.Skill] = TwohTsTp;
    skills[StandState.SkillDOff, StandSkill.Icon] = global.sprSkillTimeSkip;
    skills[StandState.SkillDOff, StandSkill.MaxCooldown] = 3;
    skills[StandState.SkillDOff, StandSkill.Desc] = Localize("tsTpDesc");
    
    skills[StandState.SkillA, StandSkill.Skill] = TwohBarrage;
    skills[StandState.SkillA, StandSkill.Damage] = 3;
    skills[StandState.SkillA, StandSkill.SkillAlt] = ThunderousWave;
    skills[StandState.SkillA, StandSkill.DamageAlt] = 10;
    skills[StandState.SkillA, StandSkill.MaxCooldownAlt] = 8;
    skills[StandState.SkillA, StandSkill.IconAlt] = global.sprSkillDetonate;
    skills[StandState.SkillA, StandSkill.Desc] = Localize("twohBarrageDesc");
    
    skills[StandState.SkillB, StandSkill.Skill] = MeleeCombo;
    skills[StandState.SkillB, StandSkill.Damage] = 3;
    skills[StandState.SkillB, StandSkill.MaxCooldown] = 5;
    skills[StandState.SkillB, StandSkill.Icon] = global.sprSkillXXI;
    skills[StandState.SkillB, StandSkill.SkillAlt] = RealityOverwritePunch;
    skills[StandState.SkillB, StandSkill.DamageAlt] = 5;
    skills[StandState.SkillB, StandSkill.MaxCooldownAlt] = 10;
    skills[StandState.SkillB, StandSkill.IconAlt] = global.sprSkillStrongPunch;
    skills[StandState.SkillB, StandSkill.Desc] = Localize("meleeComboDesc");
    
    skills[StandState.SkillC, StandSkill.Skill] = LightningKnifes;
    skills[StandState.SkillC, StandSkill.Damage] = 15;
    skills[StandState.SkillC, StandSkill.MaxCooldown] = 3;
    skills[StandState.SkillC, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
    skills[StandState.SkillC, StandSkill.SkillAlt] = KnifeBuryal;
    skills[StandState.SkillC, StandSkill.DamageAlt] = 4;
    skills[StandState.SkillC, StandSkill.MaxCooldownAlt] = 15;
    skills[StandState.SkillC, StandSkill.IconAlt] = global.sprSkillPunishment;
    skills[StandState.SkillC, StandSkill.Desc] = Localize("lightningKnifesDesc");
    
    skills[StandState.SkillD, StandSkill.Skill] = TwohTimestop;
    skills[StandState.SkillD, StandSkill.MaxCooldown] = 1;
    skills[StandState.SkillD, StandSkill.Desc] = Localize("twohTimestopDesc");
    
    InstanceAssignMethod(self, "step", ScriptWrap(TwohStep))
}
return _s;

#define TwohStep

zapTimer -= DT;
if (zapTimer <= 0)
{
    ZapSpawn(self);
    zapTimer = 5;
}
