
global.jjbamDiscMr = ItemCreate(
    undefined,
    Localize("standDiscName") + "MR",
    Localize("standDiscDescription") + "Magician's Red",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscMrUse),
    5 * 10,
    true
);

#define DiscMrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscMr);
    exit;
}
GiveMagiciansRed(player);

#define BurningKnife(_, s)

var _dir = owner.attack_direction;

var _dmg = GetDmg(s);
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = jj_play_audio(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = _dmg;
    baseSpd = 8;
    onHitEvent = Burning;
    direction = _dir;
    canMoveInTs = false;
    sprite_index = other.knifeSprite;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BurningProjectileStep));
}
EndAtk(s);

#define BurningProjectileStep

FireEffect(c_yellow, c_red);

#define Burning(_, _args, _target)

if (instance_exists(_target))
{
    BurnDamageCreate(_target, 0.002, 3, true);
}

#define LesserBurning(_, _args, _target)

if (instance_exists(_target))
{
    BurnDamageCreate(_target, 0.00002, 3, true);
}

#define HeavyBurningPunch(method, skill)

var _dir = 0;
var _xx = x;
var _yy = y;
if (instance_exists(owner))
{
    _dir = owner.attack_direction;
    
    _xx = owner.x + lengthdir_x(GetStandReach(self), _dir);
    _yy = owner.y + lengthdir_y(GetStandReach(self), _dir);
}
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
        break;
    case 1:
        var _p = PunchSwingCreate(x, y, _dir, 4, GetDmg(skill));
        _p.onHitSound = global.sndHeavyPunch;
        _p.onHitEvent = Burning;
        EndAtk(skill);
        break;
}
attackStateTimer += DT;

#define RedBindPull(_, skill)

var _dir = owner.attack_direction;
xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        //jj_play_audio(global.sndSfGrab, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, 3, 1);
        with (_p)
        {
            subtype = "redBindPull";
            target = noone;
            despawnTime = 10;
            timer = 0.4;
            grab = false;
            knockback = 0;
            
            InstanceAssignMethod(self, "step", ScriptWrap(RedBindPullStep), true);
            InstanceAssignMethod(self, "draw", ScriptWrap(RedBindDraw), true);
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 4:
        var _o = modSubtypeFind("redBindPull");
        if (_o == noone)
        {
            EndAtk(skill);
        }
        if (instance_place(x, y, _o))
        {
            with (_o)
            {
                if (instance_exists(target))
                {
                    target.behaviourEngage = true;
                }
                instance_destroy(self);
            }
            EndAtk(skill);
        }
    break;
}
attackStateTimer += DT;

#define RedBindPullStep
var _dir = point_direction(x, y, STAND.x, STAND.y);

timer -= DT;
if (timer <= 0)
{
    direction = _dir;
}

var _hit = instance_place(x, y, ENEMY);
if (_hit and !grab)
{
    //jj_play_audio(global.sndSfGrabReturn, 0, false);
    target = _hit;
    grab = true;
    timer = 0;
}

if (grab and instance_exists(target))
{
    target.behaviourEngage = false;
    target.x = x;
    target.y = y;
}

#define RedBindDraw

draw_set_color(c_red);
draw_line_width(x, y, STAND.x, STAND.y, 2);
draw_line_width(x, y - 4, STAND.x, STAND.y - 4, 2);
draw_set_color(image_blend);

#define RedBindRestrain(_, skill)

var _dir = owner.attack_direction;
xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        //jj_play_audio(global.sndSfGrab, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, 3, 1);
        with (_p)
        {
            subtype = "redBindRestrain";
            target = noone;
            despawnTime = 10;
            timer = 0.4;
            grab = false;
            
            InstanceAssignMethod(self, "step", ScriptWrap(RedBindRestrainStep), true);
            InstanceAssignMethod(self, "draw", ScriptWrap(RedBindDraw), true);
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 4:
        var _o = modSubtypeFind("redBindRestrain");
        if (_o == noone)
        {
            EndAtk(skill);
        }
        if (instance_place(x, y, _o))
        {
            with (_o)
            {
                if (instance_exists(target))
                {
                    target.behaviourEngage = true;
                }
                instance_destroy(self);
            }
            EndAtk(skill);
        }
    break;
}
attackStateTimer += DT;

#define RedBindRestrainStep
var _dir = point_direction(x, y, STAND.x, STAND.y);

timer -= DT;
if (timer <= 0)
{
    direction = _dir;
}

var _hit = instance_place(x, y, ENEMY);
if (_hit and !grab)
{
    //jj_play_audio(global.sndSfGrabReturn, 0, false);
    target = _hit;
    grab = true;
    timer = 0;
}

if (grab and instance_exists(target))
{
    RestrainCreate(target);
}

#define RestrainCreate(_target)

var _o = ModObjectSpawn(_target.x, _target.y, _target.depth - 1);
with (_o)
{
    type = "restrain";
    target = _target;
    life = 5;
    sprite_index = global.sprRestrains;
    
    InstanceAssignMethod(self, "step", ScriptWrap(RestrainStep));
}

#define RestrainStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

image_xscale = max(1, cos(current_time / 100) * 1.2);

if (instance_exists(target))
{
    target.freeze = 5;
}

#define CrossFireHurricane(_, skill)

var _dir = 0;
var _xx = x;
var _yy = y;
if (instance_exists(owner))
{
    _dir = owner.attack_direction;
    
    _xx = owner.x + lengthdir_x(GetStandReach(self), _dir);
    _yy = owner.y + lengthdir_y(GetStandReach(self), _dir);
}
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var _dmg = GetDmg(skill);
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            damage = _dmg;
            direction = _dir;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define CrossFireHurricaneSpecial(_, skill)



#define GiveMagiciansRed(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = BurningKnife;
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
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = HeavyBurningPunch;
_skills[sk, StandSkill.Damage] = 20;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = Localize("strongPunchDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = RedBindPull;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.SkillAlt] = RedBindRestrain;
_skills[sk, StandSkill.IconAlt] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldownAlt] = 10;
_skills[sk, StandSkill.Desc] = Localize("knifeWallDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = Localize("twTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Magician's Red";
    sprite_index = global.sprMagiciansRed;
    color = 0x3232ac;
    summonSound = global.sndTwSummon;
    auraParticleSprite = global.sprStandParticle7;
    discType = global.jjbamDiscMr;
    saveKey = "jjbamMr";
    
    knifeSprite = global.sprBurningKnife;
    barrageData.hitEvent = LesserBurning;
}
return _s;

