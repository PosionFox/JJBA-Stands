
global.jjbamDiscD4clt = ItemCreate(
    undefined,
    Localize("standDiscName") + "D4CLT",
    Localize("standDiscDescription") + "D4C Love Train",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    832,
    0,
    0,
    [],
    ScriptWrap(DiscD4cltUse),
    5 * 10,
    true
);

#define DiscD4cltUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscD4clt);
    exit;
}
GiveD4CLT(player);

#define SlashingStrikes(m, s)
var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = DIR_PLAYER_TO_MOUSE;

xTo = player.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = player.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > player.x ? 1 : -1;

attackStateTimer += DT;
if (distance_to_point(xTo, yTo) < 2)
{
    if (attackStateTimer >= 0.08)
    {
        var _snd = audio_play_sound(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-4, 4);
        var yy = y + random_range(-6, 6);
        var _p = PunchSwingCreate(xx, yy, _dir, 90, GetDmg(s));
        with (_p)
        {
            onHitSound = global.sndPunchHit;
            onHitEvent = SlashNearest;
            swingSpd = 20;
        }
        attackStateTimer = 0;
    }
    skills[s, StandSkill.ExecutionTime] += DT;
}

if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
{
    if (skills[s, StandSkill.ExecutionTime] > 0)
    {
        FireCD(s);
    }
    else
    {
        ResetCD(s);
    }
    state = StandState.Idle;
}

#define SlashNearest

if (enemy_instance_exists())
{
    var _n = get_nearest_enemy(x, y);
    LastingDamageCreate(_n, 0.0002, 1, true);
}

#define MeleePull(m, s)

switch (attackState)
{
    case 0:
        GrabCreate(0, 0);
        attackState++;
    break;
    case 1:
        xTo = player.x + lengthdir_x(GetStandReach(self) * 4, DIR_PLAYER_TO_MOUSE);
        yTo = player.y + lengthdir_y(GetStandReach(self) * 4, DIR_PLAYER_TO_MOUSE);
        if (attackStateTimer > 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        xTo = player.x + lengthdir_x(GetStandReach(self) * 4, DIR_PLAYER_TO_MOUSE);
        yTo = player.y + lengthdir_y(GetStandReach(self) * 4, DIR_PLAYER_TO_MOUSE);
        if (attackStateTimer > 1)
        {
            attackState++;
        }
    break;
    case 3:
        var _o = modTypeFind("grab");
        if (instance_exists(_o))
        {
            instance_destroy(_o);
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define SuperCloneSummon(m, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(GetStandReach(self), _dir);
yTo = objPlayer.y + lengthdir_y(GetStandReach(self), _dir);
image_xscale = sign(dcos(_dir));

attackStateTimer += 1 / room_speed;
switch (attackState)
{
    case 0:
        USAflag.visible = true;
        USAflag.x = x;
        USAflag.y = y;
        USAflag.image_xscale = 0;
        USAflag.image_angle = 180;
        audio_play_sound(global.sndCloneSummon, 1, false);
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
        var _clonesMax = ceil(player.level / 5);
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

#define LoveTrain(method, skill)

if (!modTypeExists("loveTrain"))
{
    LoveTrainCreate(GetDmg(skill));
    FireCD(skill);
    state = StandState.Idle;
}
else
{
    ResetCD(skill)
    state = StandState.Idle;
}

#define LoveTrainCreate(_length)

audio_play_sound(global.sndLoveTrain, 5, false);
var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, 0)
with (_o)
{
    depth = -1000;
    type = "loveTrain";
    size = 1;
    length = _length;
    rotSpeed = 0;
    range = 500;
    circRange = 500;
    amountRays = 12;
    InstanceAssignMethod(self, "step", ScriptWrap(LoveTrainStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(LoveTrainDraw), false);
    
    for (var i = 0; i < amountRays; i++)
    {
        rays[i] = ModObjectSpawn(x, y, 0);
        rays[i].width = 1;
        rays[i].height = 1;
        InstanceAssignMethod(rays[i], "step", ScriptWrap(LoveTrainRayStep), false);
        InstanceAssignMethod(rays[i], "draw", ScriptWrap(LoveTrainRayDraw), false);
    }
}

#define LoveTrainStep

size *= 1.1;
size = clamp(size, 0, 1000);
rotSpeed = lerp(rotSpeed, 100, 0.05);
range = lerp(range, 24, 0.08);
circRange = lerp(circRange, 0, 0.2);

if (instance_exists(player))
{
    x = player.x;
    y = player.y;
    for (var i = 0; i < amountRays; i++)
    {
        var rr = cos((current_time / 1000) + i) * 2;
        rays[i].x = x + lengthdir_x(range + rr, (i * (360 / amountRays)) + current_time / rotSpeed);
        rays[i].y = y + lengthdir_y((range - 8) + rr, (i * (360 / amountRays)) + current_time / rotSpeed);
    }
}

length -= 1 / room_speed;
if (length <= 0)
{
    var _s = audio_play_sound(global.sndLtEnd, 5, false);
    audio_sound_pitch(_s, random_range(0.9, 1.1));
    instance_destroy(self);
}

#define LoveTrainDraw

gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha);
draw_set_color(c_teal);
draw_circle(x, y, circRange, false);
draw_set_color(image_blend);
gpu_set_blendmode(bm_normal);

#define LoveTrainRayStep

depth = -y;

if (modTypeExists("loveTrain"))
{
    height *= 1.1;
    height = clamp(height, 0, 1000);
    width = cos(current_time / 1000) * 2;
}
else
{
    height *= 0.9;
    width *= 0.9;
    if (height <= 0)
    {
        instance_destroy(self);
    }
}

#define LoveTrainRayDraw

gpu_set_blendmode(bm_add);
draw_set_alpha(0.5);
draw_set_color(c_yellow);
draw_line_width(x, y, x, y - height, width);
draw_circle(x, y, width, false);
draw_set_color(c_white);
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);

#define GiveD4CLT(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = RevolverReload;
_skills[sk, StandSkill.Icon] = global.sprRevolverReload;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.Desc] = Localize("revolverReloadDesc");

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = TrickShot;
_skills[sk, StandSkill.Damage] = 4;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 0.5;
_skills[sk, StandSkill.Desc] = Localize("trickShotDesc");

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = BulletVolley;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.3;
_skills[sk, StandSkill.Icon] = global.sprSkillBulletVolley;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = Localize("bulletVolleyDesc");

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = CloneSwap;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneSwap;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = Localize("cloneSwapDesc");

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = SlashingStrikes;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 0.5;
_skills[sk, StandSkill.Desc] = Localize("slashingStrikesDesc");

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = DoubleSlap;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.04;
_skills[sk, StandSkill.Icon] = global.sprSkillDoubleSlap;
_skills[sk, StandSkill.MaxCooldown] = 4;
_skills[sk, StandSkill.Desc] = Localize("doubleSlapDesc");

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = CloneBomb;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.01;
_skills[sk, StandSkill.Icon] = global.sprSkillCloneBomb;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = SuperCloneSummon;
_skills[sk, StandSkill.MaxCooldownAlt] = 6.5;
_skills[sk, StandSkill.IconAlt] = global.sprSkillCloneSummon;
_skills[sk, StandSkill.Desc] = Localize("clonesDesc");

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = LoveTrain;
_skills[sk, StandSkill.Icon] = global.sprSkillLoveTrain;
_skills[sk, StandSkill.MaxCooldown] = 45;
_skills[sk, StandSkill.Damage] = 15;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.SkillAlt] = DimensionalHop;
_skills[sk, StandSkill.IconAlt] = global.sprSkillDimensionalHop;
_skills[sk, StandSkill.MaxCooldownAlt] = 20;
_skills[sk, StandSkill.Desc] = Localize("loveTrainDesc");

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "D4C: Love Train";
    sprite_index = global.sprD4CLT;
    color = 0xe4cd5f;
    summonSound = global.sndD4CLTSummon;
    saveKey = "jjbamD4clt";
    discType = global.jjbamDiscD4clt;
    
    ammo = 6;
    USAflag = ModObjectSpawn(x, y, depth);
    with (USAflag)
    {
        sprite_index = global.sprD4CFlag;
        visible = false;
    }
    
    InstanceAssignMethod(self, "destroy", ScriptWrap(D4Cdestroy));
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(D4CLTDrawGui));
}
return _s;

#define D4CLTDrawGui

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

draw_sprite_ext(global.sprRevCylinderGUI, 0, 321, _height - 96, 2, 2, 0, c_white, 1);
for (var i = 0; i < ammo; i++)
{
    var xx = 320 + lengthdir_x(12, i * 60);
    var yy = _height - 96 + lengthdir_y(12, i * 60);
    draw_sprite_ext(global.sprBulletGUI, 0, xx, yy, 2, 2, 0, c_white, 1);
}
