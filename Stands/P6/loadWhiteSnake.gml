
//wip
global.jjbamDiscWs = ItemCreate(
    undefined,
    tr("standDiscName") + "WS",
    tr("standDiscDescription") + "WhiteSnake",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscWsUse),
    5 * 10,
    true
);

#define DiscWsUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscWs);
    exit;
}
GiveWhiteSnake(player);

#define QuickHand(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;
var _snd = jj_play_audio(global.sndPunchAir, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var xx = x + random_range(-4, 4);
var yy = y + random_range(-8, 8);
var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
with (_p)
{
    onHitEvent = DiscRetrieveSE;
    onHitSound = global.sndWsHit;
}
EndAtk(s);

#define DiscRetrieveSE(_, _a, _t)

var _s = StatusEffectTargetGet(_t, "disc_steal");
if (instance_exists(_s) and !_s.taken)
{
    STAND.discs++;
    jj_play_audio(global.sndWsDiscGot, 5, false);
    _s.taken = true;
}

#define ExplosiveSurprise(m, s)

if (discs > 0)
{
    var _dir = DIR_PLAYER_TO_MOUSE;
    var _dmg = GetDmg(s);
    var _snd = jj_play_audio(global.sndWsToss, 0, false);
    audio_sound_pitch(_snd, random_range(0.9, 1.1));
    var _b = ProjectileCreate(x, y);
    with (_b)
    {
        damage = _dmg;
        sprite_index = global.sprDiscProjectile;
        direction = _dir;
        baseSpd = 7;
        rotation = 25;
        onHitEvent = ExplodeProjectile;
        onHitEventArg = [_dmg, GetStandRange(other)];
    }
    discs--;
    EndAtk(s);
}
else
{
    disc_warning_alpha = 1;
    ResetAtk(s);
}

#define ExplodeProjectile(_, _args, _target)

if (instance_exists(_target))
{
    var _e = ExplosionCreate(_target.x, _target.y, 32 * _args[1], true);
    _e.dmg = _args[0];
}

#define DiscSelfInsert(m, s)

if (discs > 0)
{
    jj_play_audio(global.sndWsInsert, 5, false);
    DiscBuffSE(undefined, undefined, owner);
    discs--;
    EndAtk(s);
}
else
{
    disc_warning_alpha = 1;
    ResetAtk(s);
}

#define DiscBuffSE(_, _a, _t)

if (!instance_exists(_t) or !instance_exists(_t.myStand)) exit;

var _se = StatusEffect(_a, _t);
with (_se)
{
    subtype = "disc_buff";
    life = 30;
    
    buffs = [
        "mod_destructive_power",
        "mod_rspd",
        "mod_range",
        "mod_stamina",
        "mod_precision"
    ];
    buff_index = irandom(array_length(buffs) - 1);
    
    var _v = variable_instance_get(_t.myStand, buffs[buff_index], 0);
    variable_instance_set(_t.myStand, buffs[buff_index], _v + 0.5)
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(DiscBuffSEDestroy));
}

#define DiscBuffSEDestroy

if (instance_exists(target) and instance_exists(target.myStand))
{
    var _v = variable_instance_get(target.myStand, buffs[buff_index], 0);
    variable_instance_set(target.myStand, buffs[buff_index], min(0, _v - 0.5))
}

#define PalePursuit(_, s)

switch (attackState)
{
    case 0:
        if (enemy_instance_exists())
        {
            var _n = get_nearest_enemy(mouse_x, mouse_y);
            if (distance_to_object(_n) < 512)
            {
                velocity = 0.1;
                SetSkillVar(s, "target", _n);
                SetSkillVar(s, "barrage_cd", 0.2);
                attackState++;
            }
            else
            {
                ResetAtk(s);
            }
        }
        else
        {
            ResetAtk(s);
        }
    break;
    case 1:
        var _t = GetSkillVars(s, "target");
        var _cd = GetSkillVars(s, "barrage_cd");
        if (instance_exists(_t) and _cd != undefined)
        {
            xTo = _t.x - (sign(scaleX) * 8);
            yTo = _t.y;
            if (_cd <= 0 and distance_to_object(_t) < 24)
            {
                var _dir = point_direction(x, y, _t.x, _t.y);
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                _p.onHitSound = global.sndWsHit;
                SetSkillVar(s, "barrage_cd", 0.15);
            } else SetSkillVar(s, "barrage_cd", _cd - DT);
            if (attackStateTimer >= 2.5)
            {
                var _dir = point_direction(x, y, _t.x, _t.y);
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                var _p = PunchSwingCreate(x, y, _dir, 25, GetDmg(s) * 4);
                with (_p)
                {
                    crit_change = 0.1;
                    RollCrit();
                    onHitSound = global.sndStrongPunch;
                    onHitEvent = AcidSE;
                }
                attackState++;
            }
        }
        else if (enemy_instance_exists())
        {
            var _n = get_nearest_enemy(x, y);
            if (distance_to_object(_n) < 512)
            {
                SetSkillVar(s, "target", _n);
                SetSkillVar(s, "barrage_cd", 0.2);
            }
        }
        else
        {
            attackState++;
        }
    break;
    case 2:
        var _t = GetSkillVars(s, "target");
        if (instance_exists(_t))
        {
            xTo = _t.x - (sign(scaleX) * 16);
            yTo = _t.y;
        }
        if (attackStateTimer >= 2.2) EndAtk(s);
    break;
}

attackStateTimer += DT;

#define WsGun(m, s)
var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);
image_xscale = -sign(dcos(_dir + 180));

switch (attackState)
{
    case 0:
        var _sp = GetSkillVars(s, "pistol_sprite");
        if (_sp != undefined)
        {
            var _p = ModObjectSpawn(x, y, depth - 1);
            _p.sprite_index = _sp;
            _p.image_blend = c_dkgray;
            SetSkillVar(s, "pistol", _p);
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3) attackState++;
    break;
    case 2:
        if (attackStateTimer >= 0.5)
        {
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            attackState++;
        }
    break;
    case 3:
        if (attackStateTimer >= 0.7)
        {
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            attackState++;
        }
    break;
    case 4:
        if (attackStateTimer >= 0.9)
        {
            var _p = GetSkillVars(s, "pistol");
            if (instance_exists(_p)) instance_destroy(_p);
            jj_play_audio(global.sndGunShot, 0, false);
            var _b = BulletCreate(x, y, _dir, GetDmg(s));
            var _p = EffectGeParticleCreate(x, y, c_dkgray);
            _p.sprite_index = global.sprGun;
            _p.bouncy = 0.5;
            _p.image_angle = random(360);
            _p.rotate = true;
            attackState++;
        }
    break;
    case 5:
        if (attackStateTimer >= 1) EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

var _p = GetSkillVars(s, "pistol");
if (instance_exists(_p))
{
    _p.x = x + lengthdir_x(6, _dir);
    _p.y = y + lengthdir_y(6, _dir);
    _p.depth = depth - 1;
    _p.image_yscale = -sign(dcos(_dir + 180));
    _p.image_angle = _dir;
}

#define AcidicSpit(m, s)

var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir);
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir);

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndAcidicSpit, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.6)
        {
            attackState++;
        }
    break;
    case 2:
        for (var i = 0; i < 5; i++)
        {
            var _d = (_dir - 4) + (i * 4);
            var _p = ProjectileCreate(x, y);
            with (_p)
            {
                damage = other.skills[s, StandSkill.Damage];
                destroyOnImpact = false;
                baseSpd = 8;
                direction = _d;
                spd_decay = 0.9;
                z_grav = 0.2;
                scale_with_velocity = true;
                canMoveInTs = false;
                sprite_index = global.sprAcidicSpit;
                onHitEvent = AcidSE;
            }
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define MeltYourHeart(m, s)
var _dir = point_direction(x, y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);
player.h = 0;
player.v = 0;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndMeltYourHeart, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.5)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = AcidicPoolCreate(x, y);
        _p.damage = GetDmg(s);
        _p.size_target *= GetStandRange(self);
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define AcidicPoolCreate(_x, _y)

var _o = ProjectileCreate(_x, _y);
with (_o)
{
    sprite_index = global.sprAcidicPool;
    image_angle = irandom(360);
    image_blend = other.color;
    baseSpd = 0;
    despawnTime = 20;
    scale = 0;
    col_size = 32;
    col_cd_max = 0.5;
    destroyOnImpact = false;
    multihit = true;
    destroy_in_water = false;
    depth_sort = false;
    depth = 1;
    onHitEvent = AcidicPoolOnHit;
    
    size_target = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(AcidicPoolStep));
}
return _o;

#define AcidicPoolStep

scale = lerp(scale, size_target, 0.1);

#define AcidicPoolOnHit(_, _a, _t)

if (instance_exists(_t))
{
    _t.freeze = 50;
}

#define DiscSteal(m, s)

var _dir = DIR_PLAYER_TO_MOUSE;

xTo = owner.x + lengthdir_x(8, _dir);
yTo = owner.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 1:
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-8, 8);
        var _p = PunchSwingCreate(xx, yy, _dir, 25, GetDmg(s));
        with (_p)
        {
            destroyOnImpact = true;
            onHitEvent = DiscStolenSE;
            onHitSound = global.sndWsHit;
        }
        attackState++;
    break;
    case 2:
        player.h = 0;
        player.v = 0;
        if (attackStateTimer >= 1)
        {
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define DiscStolenSE(_, _a, _t)

if (!instance_exists(_t) or !is_enemy(_t) or StatusEffectTargetHas(_t, "disc_steal")) exit;

jj_play_audio(global.sndWsDiscSteal, 5, false);

var _se = StatusEffect(_a, _t);
with (_se)
{
    subtype = "disc_steal";
    life = 9999;
    taken = false;
    destroy_when_target_empty = false;
    cc_time = 30;
    
    InstanceAssignMethod(self, "step", ScriptWrap(DiscStolenSEStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(DiscStolenSEDraw));
}

#define DiscStolenSEStep

if (cc_time > 0)
{
    cc_time -= DT;
}
if (instance_exists(target))
{
    if (cc_time > 0)
    {
        target.freeze = 2;
        target.pathfindSpeed = 0;
    }
    depth = target.depth - 1;
}

#define DiscStolenSEDraw

if (instance_exists(target))
{
    var _col = c_white;
    if (taken) _col = c_black;
    draw_sprite_ext(global.sprDisc, 0, target.x, target.y - 32, 0.5, 0.5, 0, _col, 0.75);
}

#define AcidSE(_, _a, _t)

var _se = StatusEffect(_a, _t);
with (_se)
{
    damage = 0.01;
    damage_percent = 0.0002;
    p_time = 0.5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(AcidSEStep));
}

#define AcidSEStep

if (p_time <= 0)
{
    if (instance_exists(target))
    {
        var _e = EffectGeParticleCreate(target.x, target.y, c_white);
        with (_e)
        {
            bouncy = 0.2;
            life = 2;
        }
    }
    p_time = 0.5;
}
p_time -= DT;

#define GiveWhiteSnake(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = QuickHand;
_skills[sk, StandSkill.Damage] = 10;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillQuickHand;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = tr("quick_hand_desc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = ExplosiveSurprise;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.4;
_skills[sk, StandSkill.Icon] = global.sprSkillExplosiveCommand;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 2;
_skills[sk, StandSkill.Desc] = tr("explosive_command_desc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = DiscSelfInsert;
_skills[sk, StandSkill.Icon] = global.sprSkillDiscSelfInsert;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("disc_self_insert_desc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = MeltYourHeart;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.4;
_skills[sk, StandSkill.Icon] = global.sprSkillMeltYourHeart;
_skills[sk, StandSkill.MaxCooldown] = 40;
_skills[sk, StandSkill.Desc] = tr("melt_your_heart_desc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = PalePursuit;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = tr("pale_pursuit_desc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = WsGun;
_skills[sk, StandSkill.Damage] = 8;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Vars] = { pistol_sprite : global.sprGun };
_skills[sk, StandSkill.Desc] = tr("quick_disposal_desc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AcidicSpit;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.05;
_skills[sk, StandSkill.Icon] = global.sprSkillAcidicSpit;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = tr("acidic_spit_desc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = DiscSteal;
_skills[sk, StandSkill.Damage] = 0;
_skills[sk, StandSkill.DamageScale] = 0;
_skills[sk, StandSkill.Icon] = global.sprSkillDiscSteal;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = tr("disc_steal_desc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "WhiteSnake";
    sprite_index = global.sprWhiteSnake;
    color = Color.DimWhite;
    colorAlt = Color.DarkBlue;
    summonSound = global.sndWsSummon;
    saveKey = "jjbamWs";
    discType = global.jjbamDiscWs;
    
    discs = 0;
    disc_warning_alpha = 0;
    
    variants[0] = [sprite_index, rarity.tier];
    variants[1] = [global.sprBlackSnake, Rarity.Ordinary];
    variants[2] = [global.sprGreenSnake, Rarity.Uncommon];
    variants[3] = [global.sprBlueSnake, Rarity.Rare];
    variants[4] = [global.sprPurpleSnake, Rarity.Epic];
    variants[5] = [global.sprYellowSnake, Rarity.Legendary];
    variants[6] = [global.sprRedSnake, Rarity.Mythical];
    variants[7] = [global.sprOrangeSnake, Rarity.Celestial];
    variants[8] = [global.sprPinkSnake, Rarity.Ultimate];
    variants[9] = [global.sprWhiteSnakeUltimate, Rarity.Ultimate];
    
    evolutions[0] = [global.sprCMoon, "???", Rarity.Common];
    
    InstanceAssignMethod(self, "step", ScriptWrap(WhiteSnakeStep));
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(WhiteSnakeDrawGUI));
}
return _s;

#define WhiteSnakeStep

discs = clamp(discs, 0, 10);
disc_warning_alpha = lerp(disc_warning_alpha, 0, 0.1);

#define WhiteSnakeDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

draw_set_alpha(disc_warning_alpha * global.jjsSettGuiVisibility);
draw_rectangle_color(296, _height - 104, 456, _height - 88, c_red, c_red, c_red, c_red, false);
draw_set_alpha(1);

for (var i = 0; i < 10; i++)
{
    draw_sprite_ext(global.sprDisc, 0, 304 + (16 * i), _height - 96, 1, 1, 0, c_black, global.jjsSettGuiVisibility);
}

for (var i = 0; i < discs; i++)
{
    draw_sprite_ext(global.sprDisc, 0, 304 + (16 * i), _height - 96, 1, 1, 0, c_white, global.jjsSettGuiVisibility);
}
