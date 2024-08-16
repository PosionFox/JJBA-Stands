
global.jjbamDiscD4c = ItemCreate(
    undefined,
    Localize("standDiscName") + "D4C",
    Localize("standDiscDescription") + "Dirty Deeds Done Dirt Cheap",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscD4cUse),
    5 * 10,
    true
);

#define DiscD4cUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscD4c);
    exit;
}
GiveD4C(player);

#define RevolverReload(m, s)

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndRevReload, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        ammo = 6;
        FireCD(s);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define TrickShot(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

if (ammo > 0)
{
    var _dmg = GetDmg(skill);
    var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
    with (_p)
    {
        type = "bulletTime";
        prevSkill = skill;
        knockback = 2;
        var _snds = [global.sndRevFire1, global.sndRevFire2, global.sndRevFire3, global.sndRevFire4];
        var _s = jj_play_audio(_snds[irandom(array_length(_snds) - 1)], 5, false);
        audio_sound_pitch(_s, random_range(0.9, 1.1));
        audio_sound_gain(_s, 0.5, 0);
        baseSpd = 10;
        sprite_index = global.sprBtdVoidTrace;
        image_blend = c_yellow;
        mask_index = global.sprKnife;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        GlowOrderCreate(self, 0.1, c_yellow);
        
        InstanceAssignMethod(self, "destroy", ScriptWrap(TrickShotDestroy), true);
    }
    ammo--;
    skills[skill, StandSkill.Skill] = BulletTime;
    skills[skill, StandSkill.MaxCooldown] = 0.5;
    skills[skill, StandSkill.Icon] = global.sprSkillBulletTime;
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define BulletTime(method, skill)

var _o = modTypeFind("bulletTime");
if (_o)
{
    if (enemy_instance_exists())
    {
        var _e = ShrinkingCircleEffect(_o.x, _o.y);
        _e.color = c_aqua;
        var _near = get_nearest_enemy(_o.x, _o.y);
        _o.direction = point_direction(_o.x, _o.y, _near.x, _near.y);
    }
}
skills[skill, StandSkill.Skill] = TrickShot;
skills[skill, StandSkill.MaxCooldown] = 2;
skills[skill, StandSkill.Icon] = global.sprSkillGunShot;
FireCD(skill)
state = StandState.Idle;

#define BulletVolley(method, skill) //attacks
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
StandDefaultPos();

if (attackStateTimer >= 0.15)
{
    if (ammo > 0)
    {
        var _snds = [global.sndRevFire1, global.sndRevFire2, global.sndRevFire3, global.sndRevFire4];
        var _s = jj_play_audio(_snds[irandom(array_length(_snds) - 1)], 5, false);
        audio_sound_pitch(_s, random_range(0.9, 1.1));
        audio_sound_gain(_s, 0.5, 0);
        BulletCreate(player.x, player.y, _dir, GetDmg(skill));
        ammo--;
        attackStateTimer = 0;
        attackState++;
    }
    else
    {
        if (attackState > 0)
        {
            FireCD(skill);
            state = StandState.Idle;
        }
        else
        {
            ResetCD(skill);
            state = StandState.Idle;
        }
    }
}
attackStateTimer += DT * GetStandSpeed(self);
if (attackState >= 3)
{
    FireCD(skill);
    state = StandState.Idle;
}

#define DoubleSlap(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dis = GetStandReach(self);

switch (attackState)
{
    case 0:
        if (attackStateTimer > 0.5)
        {
            jj_play_audio(global.sndPunchAir, 0, false);
            PunchCreate(x, y, _dir, GetDmg(skill), 1);
            attackState++;
        }
    break;
    case 1:
        _dis = GetStandReach(self) * 1.5;
        if (attackStateTimer > 1)
        {
            jj_play_audio(global.sndPunchAir, 0, false);
            var _p = PunchCreate(x, y, _dir, GetDmg(skill) * 1.5, 2);
            with (_p)
            {
                crit_chance = 1;
                RollCrit();
            }
            attackState++;
        }
    break;
    case 2:
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT * GetStandSpeed(self);
xTo = objPlayer.x + lengthdir_x(_dis, _dir);
yTo = objPlayer.y + lengthdir_y(_dis, _dir);


#define CloneSwap(method, skill)

if (modSubtypeExists("clone"))
{
    var _near = modSubtypeFindNearest(mouse_x, mouse_y, "clone");
    var prevX = player.x;
    var prevY = player.y;
    player.x = _near.x;
    player.y = _near.y;
    _near.x = prevX;
    _near.y = prevY;
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define CloneBomb(method, skill)
if (!instance_exists(parEnemy))
{
    USAflag.visible = false;
    if (audio_is_playing(global.sndCloneSummon))
    {
        audio_stop_sound(global.sndCloneSummon);
    }
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(GetStandReach(self), _dir);
yTo = objPlayer.y + lengthdir_y(GetStandReach(self), _dir);
image_xscale = sign(dcos(_dir));

attackStateTimer += DT * GetStandSpeed(self);
switch (attackState)
{
    case 0:
        USAflag.visible = true;
        USAflag.x = x;
        USAflag.y = y;
        USAflag.image_xscale = 0;
        USAflag.image_angle = 180;
        jj_play_audio(global.sndCloneSummon, 1, false);
        attackState++;
    break;
    case 1:
        var _ang = _dir;
        _ang -= cos(current_time / 100) * 2;
        USAflag.x = x + lengthdir_x(18, _ang);
        USAflag.y = y + lengthdir_y(18, _ang);
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle = _ang;
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.visible = false;
        var _xx = x + lengthdir_x(8, _dir);
        var _yy = y + lengthdir_y(8, _dir);
        var _ins = noone;
        if (enemy_instance_exists())
        {
            _ins = get_nearest_enemy(mouse_x, mouse_y);
        }
        var _o = CloneBombCreate(_xx, _yy, _ins);
        _o.damage = GetDmg(skill);
        FireCD(skill);
        state = StandState.Idle;
    break;
}


#define CloneSummon(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(GetStandReach(self), _dir);
yTo = objPlayer.y + lengthdir_y(GetStandReach(self), _dir);
image_xscale = sign(dcos(_dir));

attackStateTimer += DT * GetStandSpeed(self);
switch (attackState)
{
    case 0:
        flagWave = 100
        USAflag.visible = true;
        USAflag.x = x;
        USAflag.y = y;
        USAflag.image_xscale = 0;
        USAflag.image_angle = 180;
        jj_play_audio(global.sndCloneSummon, 1, false);
        attackState++;
    break;
    case 1:
        var _ang = _dir;
        _ang -= cos(flagWave / 5) * 2;
        flagWave = lerp(flagWave, 0, 0.02);
        USAflag.x = x + lengthdir_x(18, _ang);
        USAflag.y = y + lengthdir_y(18, _ang);
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle = _ang;
        if (attackStateTimer >= 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.visible = false;
        var _clonesMax = ceil(player.level / 10) * GetStandDestructivePower(self);
        for (var i = 0; i < _clonesMax; i++)
        {
            var _xx = x + lengthdir_x(4 + (4 * i), _dir);
            var _yy = y + lengthdir_y(4 + (4 * i), _dir);
            var _o = CloneCreate(_xx, _yy);
            _o.damage = GetDmg(skill);
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}

#define DimensionalHop(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, 90);
yTo = objPlayer.y + lengthdir_y(8, 90);

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndDimensionalHop, 5, false);
        USAflag.x = x;
        USAflag.y = y;
        USAflag.visible = true;
        USAflag.image_angle = 0;
        USAflag.image_xscale = 0;
        attackState++;
    break;
    case 1:
        USAflag.x = x;
        USAflag.y = y - 16;
        USAflag.depth = depth - 10;
        USAflag.image_xscale = lerp(USAflag.image_xscale, 1, 0.1);
        USAflag.image_angle -= cos(current_time / 1000);
        if (attackStateTimer > 2)
        {
            attackState++;
        }
    break;
    case 2:
        USAflag.x = x;
        USAflag.y = lerp(USAflag.y, y + 8, 0.1);
        USAflag.depth = depth - 10;
        USAflag.image_angle = lerp(USAflag.image_angle, 90, 0.1);
        if (attackStateTimer > 3.5)
        {
            attackState++;
        }
    break;
    case 3:
        USAflag.visible = false;
        DimensionalHopCreate(x, y)
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define VolleyRefund //attack properties

var _skill = StandState.SkillC;
objPlayer.myStand.skills[_skill, StandSkill.Cooldown] -= 1.5;
objPlayer.myStand.skills[_skill, StandSkill.Cooldown] = clamp(
    objPlayer.myStand.skills[_skill, StandSkill.Cooldown],
    0,
    objPlayer.myStand.skills[_skill, StandSkill.MaxCooldown]
);

#define TrickShotDestroy

if (instance_exists(objPlayer))
{
    if (objPlayer.myStand.skills[prevSkill, StandSkill.Skill] == BulletTime)
    {
        objPlayer.myStand.skills[prevSkill, StandSkill.Skill] = TrickShot;
        objPlayer.myStand.skills[prevSkill, StandSkill.MaxCooldown] = 5;
        objPlayer.myStand.skills[prevSkill, StandSkill.Icon] = global.sprSkillGunShot;
        with (objPlayer.myStand)
        {
            FireCD(other.prevSkill);
        }
    }
}

#define DimensionalHopCreate(_x, _y)

DimensionalHopEffect(_x, _y);
var _o = ModObjectSpawn(_x, _y, 0)
with (_o)
{
    type = "dimensionHop";
    owner = objPlayer;
    
    affected = [];
    warpedIn = [];
    life = 10;
    
    with (parEnemy)
    {
        if (distance_to_object(objPlayer) < 48)
        {
            array_push(other.warpedIn, self);
        }
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(DimensionalHopStep), false);
}

#define DimensionalHopStep

if (life <= 0)
{
    for (var i = 0; i < array_length(affected); i++)
    {
        instance_activate_object(affected[i]);
        with (affected[i])
        {
            freeze = 0;
            scale = 1;
            image_alpha = 1;
            visible = true;
        }
    }
    DimensionalHopEffect(x, y);
    instance_destroy(self);
    exit;
}
life -= 1 / room_speed;

if (instance_exists(owner))
{
    x = owner.x;
    y = owner.y;
}

if (instance_exists(parEnemy))
{
    with (parEnemy)
    {
        //freeze = 2;
        var _alreadyAffected = false;
        for (var i = 0; i < array_length(other.warpedIn); i++)
        {
            if (other.warpedIn[i] == self)
            {
                _alreadyAffected = true;
                break;
            }
        }
        for (var i = 0; i < array_length(other.affected); i++)
        {
            if (other.affected[i] == self)
            {
                _alreadyAffected = true;
                break;
            }
        }
        if (!_alreadyAffected)
        {
            array_push(other.affected, self);
            freeze = infinity;
            scale = 0;
            image_alpha = 0;
            visible = false;
        }
        //freeze = 2;
        // if (distance_to_object(objPlayer) > 64)
        // {
        //     instance_deactivate_object(self);
        // }
    }
}

#define GiveD4C(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = RevolverReload;
_skills[sk, StandSkill.Icon] = global.sprRevolverReload;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.Desc] = Localize("revolverReloadDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = Localize("bulletVolleyDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = CloneSwap;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneSwap;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = Localize("cloneSwapDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = Localize("barrageDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = DoubleSlap;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.04;
_skills[sk, StandSkill.Icon] = global.sprSkillDoubleSlap;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.SkillAlt] = StrongPunch;
_skills[sk, StandSkill.DamageAlt] = 8;
_skills[sk, StandSkill.MaxCooldownAlt] = 5;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.Desc] = Localize("doubleSlapDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CloneBomb;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneBomb;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = CloneSummon;
_skills[sk, StandSkill.MaxCooldownAlt] = 6.5;
_skills[sk, StandSkill.IconAlt] = global.sprSkillCloneSummon;
_skills[sk, StandSkill.Desc] = Localize("clonesDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = DimensionalHop;
_skills[sk, StandSkill.Icon] = global.sprSkillDimensionalHop;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.Desc] = Localize("dimensionalHopDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Dirty Deeds Done Dirt Cheap";
    sprite_index = global.sprD4C;
    color = 0xe4cd5f;
    summonSound = global.sndD4CSummon;
    saveKey = "jjbamD4c";
    discType = global.jjbamDiscD4c;
    attack_range = 16;
    
    ammo = 6;
    
    hasArm = false;
    hasHeart = true;
    hasEye = false;
    
    flagWave = 10000;
    USAflag = ModObjectSpawn(x, y, depth);
    with (USAflag)
    {
        sprite_index = global.sprD4CFlag;
        visible = false;
    }
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(D4CDrawGui));
    InstanceAssignMethod(self, "destroy", ScriptWrap(D4Cdestroy));
}
return _s;

#define D4CEvolveIfCan

if (STAND.hasArm and STAND.hasHeart and STAND.hasEye)
{
    var _c = irandom(100);
    if (_c <= 1)
    {
        GiveGm(player);
    }
    else
    {
        GiveD4CLT(player);
    }
}

#define D4CDrawGui

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

var _cArm = c_dkgray;
var _cHeart = c_dkgray;
var _cEye = c_dkgray;
if (hasArm)
{
    _cArm = c_white;
}
if (hasHeart)
{
    _cHeart = c_white;
}
if (hasEye)
{
    _cEye = c_white;
}
draw_sprite_ext(global.sprLeftArm, 0, 368, _height - 96, 2, 2, 0, _cArm, 1);
draw_sprite_ext(global.sprHeart, 0, 368 + 32, _height - 96, 2, 2, 0, _cHeart, 1);
draw_sprite_ext(global.sprEye, 0, 368 + 64, _height - 96, 2, 2, 0, _cEye, 1);

draw_sprite_ext(global.sprRevCylinderGUI, 0, 321, _height - 96, 2, 2, 0, c_white, 1);
for (var i = 0; i < ammo; i++)
{
    var xx = 320 + lengthdir_x(12, i * 60);
    var yy = _height - 96 + lengthdir_y(12, i * 60);
    draw_sprite_ext(global.sprBulletGUI, 0, xx, yy, 2, 2, 0, c_white, 1);
}

#define D4Cdestroy

if (instance_exists(USAflag))
{
    instance_destroy(USAflag);
}
