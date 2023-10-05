
global.jjbamDiscTw = ItemCreate(
    undefined,
    Localize("standDiscName") + "TW",
    Localize("standDiscDescription") + "The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscTwUse),
    5 * 10,
    true
);

#define DiscTwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTw);
    exit;
}
GiveTheWorld(player);

#define JosephKnife(method, skill)
var _dir = owner.attack_direction;

var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = GetDmg(skill);
    baseSpd = 8;
    onHitEvent = StuckKnife;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = other.knifeSprite;
}
FireCD(skill);
state = StandState.Idle;

#define StopSign(method, skill)
var _dir = owner.attack_direction;

switch (attackState)
{
    case 0:
        stopSign.x = owner.x;
        stopSign.y = owner.y;
        stopSign.visible = true;
        stopSign.image_angle = _dir;
        stopSign.direction = _dir;
        stopSign.image_xscale = 0;
        attackState++;
    break;
    case 1:
        stopSign.image_xscale = lerp(stopSign.image_xscale, 1, 0.2);
        stopSign.x = owner.x;
        stopSign.y = owner.y;
        stopSign.image_angle = lerp(stopSign.image_angle, stopSign.direction - 125, 0.1);
        if (attackStateTimer >= 0.5)
        {
            var _dmg = GetDmg(skill);
            var _p = PunchCreate(owner.x, owner.y, stopSign.direction, _dmg, 3);
            _p.onHitSound = global.sndStopSign;
            _p.image_alpha = 0;
            _p.mask_index = global.sprHorizontalSlash;
            attackState++;
        }
    break;
    case 2:
        stopSign.x = owner.x;
        stopSign.y = owner.y;
        stopSign.image_angle = lerp(stopSign.image_angle, stopSign.direction + 90, 0.5);
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 3:
        stopSign.image_xscale = lerp(stopSign.image_xscale, 0, 0.3);
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 4:
        stopSign.visible = false;
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT;

#define TwBloodDrain(method, skill)
var _dir = owner.attack_direction;

switch (attackState)
{
    case 0:
        //audio_play_sound(global.sndStwNazimuzo, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 0);
        with (_p)
        {
            var _arg = noone;
            if (instance_exists(parEnemy))
            {
                _arg = instance_nearest(x, y, parEnemy);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TwBarrage(m, s)

var _dir = owner.attack_direction;

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndTwBarrage, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.08)
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
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

#define TwKnifeWall(method, skill)

var _dir = owner.attack_direction;
var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));

repeat (5)
{
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
        y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
        damage = GetDmg(skill);
        direction = _dir;
        canMoveInTs = false;
        sprite_index = other.knifeSprite;
    }
}
EndAtk(skill);

#define TwTimestop(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwTs, 5, false);
    TimestopCreate(9 + (0.05 * owner.level));
    FireCD(skill);
}
state = StandState.Idle;

#define StuckKnife //attack properties

if (instance_exists(parEnemy))
{
    var _near = instance_nearest(x, y, parEnemy);
    LastingDamageCreate(_near, 0.001, 3, true);
}

#define GiveTheWorld(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = JosephKnife;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = Localize("josephKnifeDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 30;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = Localize("stopSignDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TwBloodDrain;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = Localize("bloodDrainDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TimeStopTeleport;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = Localize("tsTpDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = TwBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 25;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("strongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TwKnifeWall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = Localize("knifeWallDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = Localize("twTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "The World";
    sprite_index = global.sprTheWorld;
    color = 0x36f2fb;
    summonSound = global.sndTwSummon;
    discType = global.jjbamDiscTw;
    
    knifeSprite = global.sprKnife;
    stopSign = ModObjectSpawn(x, y, depth);
    with (stopSign)
    {
        sprite_index = global.sprStopSign;
        visible = false;
    }
    saveKey = "jjbamTw";
    InstanceAssignMethod(self, "destroy", ScriptWrap(TheWorldDestroy), true);
}
return _s;

#define TheWorldDestroy

if (instance_exists(stopSign))
{
    instance_destroy(stopSign);
}
