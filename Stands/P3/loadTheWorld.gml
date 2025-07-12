
global.jjbamDiscTw = ItemCreate(
    undefined,
    tr("standDiscName") + "TW",
    tr("standDiscDescription") + "The World",
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

var _dmg = GetDmg(skill);
var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    var _snd = jj_play_audio(global.sndKnifeThrow, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    damage = _dmg;
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
            _p.subtype = "stopSignSwing";
            _p.onHitSound = global.sndStopSign;
            _p.image_alpha = 0;
            _p.col_size = 24;
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
attackStateTimer += DT * GetStandSpeed(self);

#define TwBloodDrain(method, skill)
var _dir = owner.attack_direction;

switch (attackState)
{
    case 0:
        //jj_play_audio(global.sndStwNazimuzo, 0, false);
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
            if (enemy_instance_exists())
            {
                _arg = get_nearest_enemy(x, y);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define TwTsTp(m, s)

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

#define TwDonutPunch(_, s)

var _dir = 0;
var _xx = x;
var _yy = y;
if (instance_exists(owner))
{
    _dir = owner.attack_direction;
    
    _xx = owner.x + lengthdir_x(GetStandReach(self) + (attackStateTimer * 4), _dir);
    _yy = owner.y + lengthdir_y(GetStandReach(self) + (attackStateTimer * 4), _dir);
}
xTo = _xx;
yTo = _yy;
image_xscale = sign(dcos(_dir));

switch (attackState)
{
    case 0:
        var _sc = global.sndTwWindup;
        if (_sc) jj_play_audio(_sc, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.25)
        {
            attackState++;
        }
    break;
    case 2:
        var _hs = global.sndTwDonut;
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchSwingCreate(x, y, _dir, 45, GetDmg(s));
        with (_p)
        {
            destroyOnImpact = true;
            onHitEvent = DonutSE;
            crit_change = 0.1;
            RollCrit();
            onHitSound = global.sndStrongPunch;
            if (_hs) onHitSound = _hs;
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.5) EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define StatusEffect(_args, _target)

var _o = ModObjectSpawn(x, y, 0);
with (_o)
{
    target = _target;
    life = 5;
    damage = 0;
    
    InstanceAssignMethod(self, "step", ScriptWrap(StatusEffectStep), false);
}
return _o;

#define StatusEffectStep

if (life <= 0 or !instance_exists(target))
{
    instance_destroy(self);
    exit;
}
life -= DT;

depth = target.depth - 2;

if (damage > 0)
{
    target.hp -= damage;
}

#define DonutSE(_, _a, _t)

var _se = StatusEffect(_a, _t);
with (_se)
{
    damage = 0.01;
    hole_x = x;
    hole_y = y;
    
    InstanceAssignMethod(self, "draw", ScriptWrap(DonutSEDraw));
}

#define DonutSEDraw

if (instance_exists(target))
{
    if (is_enemy(target))
    {
        hole_x = target.bbox_left + (target.bbox_right - target.bbox_left) * 0.5;
        hole_y = target.bbox_top + (target.bbox_bottom - target.bbox_top) * 0.5;
        draw_circle_color(hole_x , hole_y, 4, c_purple, c_red, false);
    }
}

#define TwKnifeWall(method, skill)

var _kws = GetSkillVars(skill, "toss_sound");
if (_kws)
{
    var _c = random(1);
    if (_c < 0.5)
    {
        jj_play_audio(_kws, 0, false);
    }
}

var _dir = owner.attack_direction;
if modTypeExists("timestop")
{
    var _snd = jj_play_audio(global.sndKnifeThrow, 5, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
}
else
{
    jj_play_audio(global.sndTwohTp, 0, false);
    EffectWhiteScreen(0.1);
}

var _times = 5 * GetStandDestructivePower(self);
repeat (_times)
{
    var _dmg = GetDmg(skill);
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
        y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
        damage = _dmg;
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
    jj_play_audio(global.sndTwTs, 5, false);
    var _time = (9 + (0.05 * owner.level)) * GetStandTotalPower(self);
    TimestopCreate(_time);
    FireCD(skill);
}
state = StandState.Idle;

#define StuckKnife(_, _args, _target) //attack properties

if (instance_exists(_target))
{
    LastingDamageCreate(_target, 0.001, 3, true);
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
_skills[sk, StandSkill.Desc] = tr("josephKnifeDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 30;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = tr("stopSignDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = StwDivineBlood;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = tr("bloodDrainDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = TwTsTp;
_skills[sk, StandSkill.Icon] = global.sprSkillTimeSkip;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = tr("tsTpDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.5;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = tr("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = TwDonutPunch;
_skills[sk, StandSkill.Damage] = 20;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillDonutPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("donut_punch_desc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TwKnifeWall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = tr("knifeWallDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = tr("twTimestopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "The World";
    sprite_index = global.sprTheWorld;
    color = 0x36f2fb;
    colorAlt = c_gray;
    summonSound = global.sndTwSummon;
    discType = global.jjbamDiscTw;
    
    knifeSprite = global.sprKnife;
    stopSign = ModObjectSpawn(x, y, depth);
    with (stopSign)
    {
        sprite_index = global.sprStopSign;
        visible = false;
    }
    barrageData.sound = global.sndTwBarrage;
    saveKey = "jjbamTw";
    
    variants[0] = [sprite_index, rarity.tier];
    variants[1] = [global.sprTWG, Rarity.Uncommon];
    variants[2] = [global.sprSpookyWorld, Rarity.Epic];
    variants[3] = [global.sprTWGH, Rarity.Legendary];
    variants[4] = [global.sprTWOVA, Rarity.Legendary];
    variants[5] = [global.sprTWR, Rarity.Mythical];
    variants[6] = [global.sprTWRu, Rarity.Mythical];
    variants[7] = [global.sprTheWorldFrozen, Rarity.Event];
    
    evolutions[0] = [global.sprTWOH, global.sprDiosDiary, Rarity.Common];
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(TheWorldDestroy), true);
}
return _s;

#define TheWorldDestroy

if (instance_exists(stopSign))
{
    instance_destroy(stopSign);
}
