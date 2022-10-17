
global.jjbamDiscStw = ItemCreate(
    undefined,
    "DISC:STW",
    "The label says: Shadow The World",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscStwUse),
    5 * 10,
    true
);

#define DiscStwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscStw);
    exit;
}
GiveShadowTheWorld(player);

#define StwPos // core

xTo = objPlayer.x;
yTo = objPlayer.y;
alphaTarget = 0;

#define StwDrawGui

var xx = 244;
var yy = 40;
var length = 790;

draw_set_color(c_black);
draw_line_width(xx, yy, xx + length, yy, 3);
draw_set_color(c_yellow);
draw_line_width(xx, yy, xx + (xp / maxXp) * length, yy, 3);
draw_set_color(c_white);

#define StwXXI(method, skill) //attacks
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dis = 12;
alphaTarget = 1;

switch (attackState)
{
    case 0:
        audio_play_sound(summonSound, 0, false);
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchSwingCreate(x, y, _dir, 45, GetDmg(skill));
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchSwingCreate(x, y, _dir, 45, GetDmg(skill));
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 4:
        _dis = 16;
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        PunchSwingCreate(x, y, _dir, 45, GetDmg(skill) * 2);
        audio_play_sound(global.sndStw2Desummon, 0, false);
        FireCD(skill);
        state = StandState.Idle;
    break;
}
xTo = objPlayer.x + lengthdir_x(_dis, _dir);
yTo = objPlayer.y + lengthdir_y(_dis, _dir);
attackStateTimer += 1 / room_speed;

#define StwPunishment(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(12, _dir);
yTo = objPlayer.y + lengthdir_y(12, _dir);
alphaTarget = 1;

switch (attackState)
{
    case 0:
        audio_play_sound(summonSound, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 2);
        with (_p)
        {
            knifeSprite = other.knifeSprite;
            onHitEvent = KnifeCoffin;
            destroyOnImpact = true;
        }
        audio_play_sound(global.sndStw2Desummon, 0, false);
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define KnifeCoffin(_x, _y)
var _dmg = 2 + (player.level * 0.2) + player.dmg;
//var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _target = player;
alphaTarget = 1;
if (instance_exists(ENEMY))
{
    _target = instance_nearest(x, y, ENEMY);
}
var c = random(1);
if (c < 0.5)
{
    var _s = choose(global.sndStwLaugh1, global.sndStwLaugh2);
    audio_play_sound(_s, 0, false);
}

var _snd = audio_play_sound(global.sndStwKnifeThrow2, 0, false);
audio_sound_pitch(_snd, random_range(0.9, 1.1));
var _k = 8;
for (var i = 0; i <= _k; i++)
{
    var _xx = _target.x + lengthdir_x(96, i * (360 / _k));
    var _yy = _target.y + lengthdir_y(96, i * (360 / _k));
    var _p = ProjectileCreate(_xx, _yy);
    with (_p)
    {
        var _dir = (i * (360 / _k)) - 180;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = other.knifeSprite;
    }
}

#define StwThrowingKnifes(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        audio_play_sound(summonSound, 0, false);
        var _snd = audio_play_sound(global.sndStwKnifeThrow1, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var i = 0;
        repeat (4)
        {
            var _p = ProjectileCreate(player.x, player.y);
            with (_p)
            {
                damage = GetDmg(skill);
                direction = (_dir - (i * 2)) - 4;
                canMoveInTs = false;
                sprite_index = other.knifeSprite;
                x += lengthdir_x(4 * i, direction - 90);
                y += lengthdir_y(4 * i, direction - 90);
            }
            i++;
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndStwKnifeThrow1, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var i = 0;
        repeat (4)
        {
            var _p = ProjectileCreate(player.x, player.y);
            with (_p)
            {
                damage = GetDmg(skill);
                direction = (_dir + (i * 2)) + 4;
                canMoveInTs = false;
                sprite_index = other.knifeSprite;
                x += lengthdir_x(4 * i, direction + 90);
                y += lengthdir_y(4 * i, direction + 90);
            }
            i++;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += 1 / room_speed;

#define StwDivineBlood(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStwNazimuzo, 0, false);
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
            if (instance_exists(ENEMY))
            {
                _arg = instance_nearest(x, y, ENEMY);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define StwSRSE(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

player.h = lengthdir_x(1, _dir + 180);
player.v = lengthdir_y(1, _dir + 180);
audio_play_sound(global.sndStwSRSE, 0, false);
var _p = ProjectileCreate(player.x, player.y - 4);
with (_p)
{
    baseSpd = 10;
    damage = GetDmg(skill);
    direction = _dir;
    canMoveInTs = false;
    destroyOnImpact = false;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_red;
    x += lengthdir_x(2, _dir + 90);
    y += lengthdir_y(2, _dir + 90);
    GlowOrderCreate(self, 0.1, c_red);
}
var _p = ProjectileCreate(player.x, player.y - 4);
with (_p)
{
    baseSpd = 10;
    damage = GetDmg(skill);
    direction = _dir;
    canMoveInTs = false;
    destroyOnImpact = false;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_red;
    x += lengthdir_x(2, _dir - 90);
    y += lengthdir_y(2, _dir - 90);
    GlowOrderCreate(self, 0.1, c_red);
}
FireCD(skill);
state = StandState.Idle;

#define StwUry(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        player.h -= lengthdir_x(2, _dir);
        player.v -= lengthdir_y(2, _dir);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.2)
        {
            attackState++;
        }
    break;
    case 2:
        audio_play_sound(global.sndStwUry, 1, false);
        player.h += lengthdir_x(6, _dir);
        player.v += lengthdir_y(6, _dir);
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 4);
        with (_p)
        {
            image_alpha = 0;
            stationary = true;
            speed = 0;
            despawnTime = 0.8;
        }
        FireCD(skill);
        state = StandState.Idle;
    break;
}
attackStateTimer += DT;

#define StwCharisma(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStwCharisma, 1, false);
        EffectCircleLerpCreate(x, y, 32, 0);
        with (ENEMY)
        {
            if (distance_to_object(player) < 32)
            {
                var _dir = point_direction(x, y, player.x, player.y);
                h = lengthdir_x(-2, _dir);
                h = lengthdir_y(-2, _dir);
            }
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer > 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        for (var i = 0; i < 5; i++)
        {
            var _o = ProjectileCreate(x + lengthdir_x(16, 45 * i), y + lengthdir_y(16, 45 * i));
            with (_o)
            {
                damage = GetDmg(skill);
                canMoveInTs = false;
                baseSpd = 0.1;
                direction = random(360);
                sprite_index = global.sprStwCharisma;
                baseAnimSpd = 0.2;
                image_speed = baseAnimSpd;
                destroyOnImpact = true;
                
                InstanceAssignMethod(self, "step", ScriptWrap(StwCharismaStep), true);
                GlowOrderCreate(self, 0.1, c_white);
            }
        }
        FireCD(skill)
        state = StandState.Idle;
    break;
}
attackStateTimer += DT;

#define StwTimestop(method, skill)

xTo = player.x;
yTo = player.y;

switch (attackState)
{
    case 0:
        var _tsExists = modTypeExists("timestop");

        if (_tsExists)
        {
            instance_destroy(modTypeFind("timestop"));
        }
        
        var s = audio_play_sound(global.sndStwTheWorld, 5, false);
        
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 2:
        var s = audio_play_sound(global.sndTsOld, 5, false);
        
        var ts = TimestopCreate(2 + (0.05 * player.level));
        ts.resumeSound = global.sndStwTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 4:
        var s = audio_play_sound(global.sndStwTokiyotomare, 5, false);
        
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define StwTheWorld(method, skill)

if (xp >= maxXp)
{
    audio_play_sound(global.sndStwEvolve, 5, false);
    var _o = ModObjectSpawn(x, y, 0);
    with (_o)
    {
        timer = 1;
        
        InstanceAssignMethod(self, "step", ScriptWrap(StwTheWorldStep), false);
    }
}
else
{
    ResetCD(skill);
    state = StandState.Idle;
}

#define StwTheWorldStep

if (instance_exists(STAND))
{
    RemoveStand(player);
}
FireEffect(c_white, c_yellow);
timer -= DT;
if (timer <= 0)
{
    var _standPool =
    [
        [GiveTheWorld, 30],
        [GiveSpookyWorld, 1]
    ]
    script_execute(random_weight(_standPool), player);
    instance_destroy(self);
}

#define StwDivineBloodCreate(_scr, _target)

var _o = ModObjectSpawn(player.x, player.y, 0);
with (_o)
{
    if (!instance_exists(player)) { instance_destroy(self); }
    life = 3;
    timer = 0.8;
    target = noone;
    if (instance_exists(_target)) { target = _target; }
    
    InstanceAssignMethod(self, "step", ScriptWrap(StwDivineBloodStep), false);
}
audio_play_sound(global.sndStwDivineBlood, 1, false);

#define StwDivineBloodStep

if (instance_exists(target))
{
    target.behaviourEngage = false;
    target.h = 0;
    target.v = 0;
}
else
{
    player.invulFrames = 0;
    instance_destroy(self);
    exit;
}

player.invulFrames = 2;
player.h = 0;
player.v = 0;
if (timer > 0)
{
    timer -= DT;
}
else
{
    audio_play_sound(global.sndTwrDrain, 0, false);
    player.hp++;
    target.hp -= target.hpMax * 0.05;
    player.energy += 6;
    timer = 0.8;
}
life -= DT;
if (life <= 0)
{
    var _dir = point_direction(player.x, player.y, target.x, target.y);
    target.h = lengthdir_x(3, _dir);
    target.v = lengthdir_y(3, _dir);
    target.behaviourEngage = true;
    player.h = lengthdir_x(3, _dir + 180);
    player.v = lengthdir_y(3, _dir + 180);
    player.invulFrames = 0;
    instance_destroy(self);
}

#define StwCharismaStep

baseSpd *= 1.02;
if (instance_exists(ENEMY))
{
    var _near = instance_nearest(x, y, ENEMY);
    if (distance_to_object(_near) < 128)
    {
        var pd = point_direction(x, y, _near.x, _near.y);
        var dd = angle_difference(direction, pd);
        direction -= min(abs(dd), 5) * sign(dd);
    }
}

#define GiveShadowTheWorld(_owner) //stand

var _skills = StandSkillInit();
// off
var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = StwUry;
_skills[sk, StandSkill.Damage] = 4;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillUry;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "uryyy:\nlunge forward striking enemies on the way.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StwSRSE;
_skills[sk, StandSkill.Damage] = 6;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillSRSE;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "space ripper stingy eyes:\nfire two piercing lasers at high speeds.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = StwDivineBlood;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "divine blood:\ndrains the target's health and heals the user.";

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = StwCharisma;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillCharisma;
_skills[sk, StandSkill.MaxCooldown] = 18;
_skills[sk, StandSkill.Desc] = "charisma:\nrelease vampiric spores that chase enemies around.";
// on
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StwXXI;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.03;
_skills[sk, StandSkill.Icon] = global.sprSkillXXI;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "xxi:\nexecutes a combo of two punches and a strong final punch.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StwPunishment;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillPunishment;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = "punishment:\ncharges an attack that upon impact surrounds the enemy with knifes.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StwThrowingKnifes;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillStwKnifes;
_skills[sk, StandSkill.MaxCooldown] = 6;
_skills[sk, StandSkill.Desc] = "throwing knifes:\nthrows two bursts of knifes.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = StwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopStw;
_skills[sk, StandSkill.MaxCooldown] = 22;
_skills[sk, StandSkill.SkillAlt] = StwTheWorld;
_skills[sk, StandSkill.IconAlt] = global.sprSkillStwTw;
_skills[sk, StandSkill.MaxHold] = 2;
_skills[sk, StandSkill.Desc] = @"the world's secret power:
stops the time for a brief moment,
most enemies are not allowed to move
and makes your projectiles freeze in place.

(hold) the world:
with enough experience,
shadow the world evolves into the world.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Shadow The World";
    sprite_index = global.sprShadowTheWorld;
    summonSound = global.sndStwSummon;
    playSummonSound = false;
    idlePos = StwPos;
    soundWhenHurt = [global.sndStwHurt1, global.sndStwHurt2, global.sndStwHurt3];
    soundWhenDead = global.sndStwDead;
    knifeSprite = global.sprKnifeStw;
    discType = global.jjbamDiscStw;
    maxXp = 300;
    xp = 0;
    
    saveKey = "jjbamStw";
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StwDrawGui), true);
}
return _s;
