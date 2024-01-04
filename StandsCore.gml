
#define StandSkillDrawGUI

if (!runDrawGUI) { exit; }

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;


//draw_text(128, 160, string(TimeControl.timer)); // debug
//draw_text(128, 192, string(TimeControl.lightState)); // debug
// 3 is night and 0 is dawn

var xx = 168;
var yy = _height - 200;

// tier
var _tx = xx;
var _ty = yy - 64;
var _ss = random_range(0.85, 1.15);
var _spr = global.sprStarTier;
var _c = rarity.color;

draw_sprite_ext(_spr, 0, _tx - 4, _ty, _ss, _ss, 0, _c, 0.8);

var gx = device_mouse_x_to_gui(0);
var gy = device_mouse_y_to_gui(0);
if (point_in_rectangle(gx, gy, _tx - 16, _ty - 16, _tx + 16, _ty + 16))
{
    draw_text(gx + 8, gy, string(rarity.name) + " (" + string(rarity.probability) + "%)");
}

// draw runes
var _rlen = array_length(runes);
for (var i = 0; i < _rlen; i++)
{
    if (runes[i] == noone)
    {
        draw_circle_color(xx - 128 + (32 * i), yy - 32, 8, c_black, c_black, false);
    }
    else
    {
        draw_sprite(runes[i].sprite, 0, xx - 128 + (32 * i), yy - 32);
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(owner.trait.color);
draw_text(32, _height - 186, string_lower(string(owner.trait.name)));
draw_set_color(c_white);
draw_text(32, _height - 138, string_lower(string(name)));
draw_line_color(32, _height - 144, 32 + 255, _height - 144, color, c_black);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_text(24, _height - 84, string_lower(player.summonKeybind));

var _start = StandState.SkillAOff;
var _end = StandState.SkillDOff;
if (active)
{
    _start = StandState.SkillA;
    _end = StandState.SkillD;
}

for (var i = _start; i <= _end; i++)
{
    var xx = 64 + (64 * ((i - 1) mod 4));
    var yy = (_height - 96);
    
    // tap
    if (skills[i, StandSkill.Skill] != AttackHandler)
    {
        var _s = global.sprSkillTemplate;
        if (color_get_value(color) < 80) { _s = global.sprSkillTemplateWhite; }
        draw_sprite_ext(_s, 0, xx, yy, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.Icon], 0, xx, yy, 2, 2, 0, color, 1);
        if (skills[i, StandSkill.Cooldown] > 0)
        {
            var cyy = (skills[i, StandSkill.Cooldown] / skills[i, StandSkill.MaxCooldown]) * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, yy + 10, string(skills[i, StandSkill.Cooldown]));
        }
        
        draw_text(xx + 8, _height - 120, string_lower(skills[i, StandSkill.Key]));
    }
    // hold
    if (skills[i, StandSkill.SkillAlt] != AttackHandler)
    {
        var _s = global.sprSkillHoldTemplate;
        if (color_get_value(color) < 80) { _s = global.sprSkillHoldTemplateWhite; }
        draw_sprite_ext(global.sprSkillHoldTemplate, 0, xx, yy + 64, 2, 2, 0, c_white, 1);
        draw_sprite_ext(skills[i, StandSkill.IconAlt], 0, xx, yy + 64, 2, 2, 0, color, 1);
        var _hold = (skills[i, StandSkill.Hold] / skills[i, StandSkill.MaxHold]) * 2;
        draw_sprite_ext(global.sprSkillHold, 0, xx, yy + 64, 2, _hold, 0, color, 0.8);
        if (skills[i, StandSkill.CooldownAlt] > 0)
        {
            var cyy = (skills[i, StandSkill.CooldownAlt] / skills[i, StandSkill.MaxCooldownAlt]) * 2;
            draw_sprite_ext(global.sprSkillCooldown, 0, xx, yy + 64, 2, cyy, 0, c_white, 0.8);
            draw_text(xx + 8, yy + 74, string(skills[i, StandSkill.CooldownAlt]));
        }
    }
    //show tooltip
    var gx = device_mouse_x_to_gui(0);
    var gy = device_mouse_y_to_gui(0);
    if (point_in_rectangle(gx, gy, xx - 32, yy - 32, xx + 32, yy + 32) and skills[i, StandSkill.Desc] != "")
    {
        //var dmg = skills[i, StandSkill.Damage] + (player.level * skills[i, StandSkill.DamageScale]);
        var desc = skills[i, StandSkill.Desc];
        var txt = desc;
        if (skills[i, StandSkill.Damage] != 0)
        {
            txt += "\n\n" + Localize("dmgDisplay") + ": " + string(GetDmg(i)) + " + " + string(player.dmg);
        }
        if (skills[i, StandSkill.DamageAlt] != 0)
        {
            txt += "\n" + Localize("dmgDisplay") + " alt: " + string(GetDmgAlt(i)) + " + " + string(player.dmg);
        }
        draw_set_color(c_dkgray);
        draw_rectangle(gx, (yy - 64) - string_height(txt), gx + string_width(txt), (yy - 64), false);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(gx + 9, ((yy - 64) - string_height(txt)) + 8, txt);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    }
}

xx = 168;
yy = _height - 200;
// draw energy bar
if (max_energy > 0)
{
    var _color = make_color_rgb(0, abs(sin(current_time / 1000)) * 254, abs(sin(current_time / 1000)) * 254);
    draw_line_width_color(xx - 134, yy + 134, (xx - 134) + ((energy / max_energy) * 250), yy + 134, abs(sin(current_time / 1000)) * 5, _color, _color);
}

#define StandSkillRunCD(s)

for (var i = StandState.LEN - 1; i > 0; i--)
{
    if (s[@ i, StandSkill.Cooldown] > 0)
    {
        s[@ i, StandSkill.Cooldown] -= DT * CDMultiplier;
    }
    if (s[@ i, StandSkill.CooldownAlt] > 0)
    {
        s[@ i, StandSkill.CooldownAlt] -= DT * CDMultiplier;
    }
}

#define StandSkillDefaultCDs

StandSkillRunCD(skills);

#define StandSkillManage

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    if (state == StandState.Idle and active == skills[i, StandSkill.ActiveOnly])
    {
        if (owner.hp != 0 and !instance_exists(objPlayerMenu))
        {
            if (keyboard_check(ord(skills[i, StandSkill.Key]))/* or InputCheckDown(skills[i, StandSkill.GpBtn])*/)
            {
                if (max_energy > 0)
                {
                    if (energy >= skills[i, StandSkill.EnergyCost] and skills[i, StandSkill.SkillAlt] != AttackHandler)
                    {
                        skills[i, StandSkill.Hold] += DT;
                        skills[i, StandSkill.Hold] = clamp(skills[i, StandSkill.Hold], 0, skills[i, StandSkill.MaxHold]);
                        if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold] and !altAttack)
                        {
                            altAttack = true;
                            var _s = audio_play_sound(sndCoin1, 1, false);
                            audio_sound_pitch(_s, 1.5);
                        }
                    }
                }
                else
                {
                    if (skills[i, StandSkill.CooldownAlt] <= 0 and skills[i, StandSkill.SkillAlt] != AttackHandler)
                    {
                        skills[i, StandSkill.Hold] += DT;
                        skills[i, StandSkill.Hold] = clamp(skills[i, StandSkill.Hold], 0, skills[i, StandSkill.MaxHold]);
                        if (skills[i, StandSkill.Hold] >= skills[i, StandSkill.MaxHold] and !altAttack)
                        {
                            altAttack = true;
                            var _s = audio_play_sound(sndCoin1, 1, false);
                            audio_sound_pitch(_s, 1.5);
                        }
                    }
                }
            }
            if (keyboard_check_released(ord(skills[i, StandSkill.Key]))/* or InputCheckPressed(skills[i, StandSkill.GpBtn])*/)
            {
                if (max_energy > 0)
                {
                    if (energy >= skills[i, StandSkill.EnergyCost])
                    {
                        if (!altAttack and skills[i, StandSkill.Cooldown] <= 0)
                        {
                            state = i;
                        }
                        else if (altAttack)
                        {
                            state = i;
                        }
                        skills[i, StandSkill.Hold] = 0;
                        energy -= skills[i, StandSkill.EnergyCost];
                    }
                }
                else
                {
                    if (!altAttack and skills[i, StandSkill.Cooldown] <= 0)
                    {
                        state = i;
                    }
                    else if (altAttack)
                    {
                        state = i;
                    }
                    skills[i, StandSkill.Hold] = 0;
                }
            }
        }
    }
}

if (state != StandState.Idle)
{
    height = lerp(height, 0, 0.2);
    for (var i = 1; i < StandState.LEN; i++)
    {
        if (state == i)
        {
            if (altAttack)
            {
                script_execute(skills[i, StandSkill.SkillAlt], state, undefined);
            }
            else
            {
                script_execute(skills[i, StandSkill.Skill], state, undefined);
            }
            if (skills[i, StandSkill.ExecutionTime] >= skills[i, StandSkill.MaxExecutionTime]) {
                FireCD(i);
                state = StandState.Idle;
            }
        }
    }
}

script_execute(runCDsMethod);

#define StandDefaultSummon

if (state == StandState.Idle)
{
    if (keyboard_check_pressed(ord(player.summonKeybind)) and owner.freeze < 1)
    {
        active = !active;
        if (active)
        {
            if (!audio_is_playing(summonSound) and summonSound != noone and playSummonSound == true)
            {
                audio_play_sound(summonSound, 0, false);
            }
        }
    }
}

#define StandDefaultPos

var xPos = mouseXSide;
if (instance_exists(owner))
{
    xTo = owner.x - (xPos * 16);
    yTo = owner.y - 8;
}

#define StandDefaultStep

depth = -y;

if (!instance_exists(objPlayerMenu))
{
    script_execute(summonMethod);
}

if (instance_exists(owner))
{
    mouseXSide = sign(owner.facing);
}

x = lerp(x, xTo, spd);
y = lerp(y, yTo, spd);
image_alpha = lerp(image_alpha, alphaTarget, 0.1);
image_angle = lerp(image_angle, angleTarget * image_xscale, 0.1);
image_xscale = lerp(image_xscale, scaleX, scaleXSpd);
image_yscale = lerp(image_yscale, scaleY, scaleYSpd);

if (active)
{
    if (state == StandState.Idle)
    {
        scaleX = mouseXSide;
        image_xscale = mouseXSide;
        alphaTarget = 1;
        if (runIdlePos)
        {
            script_execute(idlePos);
        }
        height = 2 + (cos(current_time / 1000) * 2);
    }
    var _e = EffectStandAuraCreate(x, y - height, auraParticleSprite, color);
    _e.rotation = auraParticleRotation;
}
else
{
    scaleX = 0;
    alphaTarget = 0;
    xTo = owner.x;
    yTo = owner.y;
}

if (soundIdleTimer <= 0)
{
    var _sound = soundIdle;
    if (_sound != undefined)
    {
        if (is_array(_sound))
        {
            var i = irandom(array_length(_sound) - 1);
            audio_play_sound(_sound[i], 0, false);
        }
        else
        {
            audio_play_sound(_sound, 0, false);
        }
        soundIdleTimer = irandom_range(60, 120);
    }
}
soundIdleTimer -= DT;

if (instance_exists(owner))
{
    if (owner.freeze < 1)
    {
        StandSkillManage();
    }
}

max_energy = GetRunesMaxEnergy(self);
if (max_energy > 0)
{
    energy += max_energy * 0.0005;
    energy = clamp(energy, 0, max_energy);
}

#define StandDefaultDraw

if (active)
{
    draw_sprite_ext(sprShadow, 0, x, y + 2, min(1, abs(image_xscale / (height * 0.2))), min(1, abs(image_yscale / (height * 0.2))), 0, c_white, image_alpha * 0.5);
}
draw_sprite_ext(sprite_index, image_index, x, y - height, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

#define StandSkillInit()

var _arr;
var _s;

for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
{
    _s = i;
    _arr[_s, StandSkill.ActiveOnly] = i > StandState.SkillDOff;
    // tap
    _arr[_s, StandSkill.Skill] = AttackHandler;
    _arr[_s, StandSkill.Icon] = global.sprSkillSkip;
    _arr[_s, StandSkill.Damage] = 0;
    _arr[_s, StandSkill.DamageScale] = 0;
    _arr[_s, StandSkill.DamagePlayerStat] = true;
    _arr[_s, StandSkill.MaxCooldown] = 1;
    _arr[_s, StandSkill.Cooldown] = 0;
    // hold
    _arr[_s, StandSkill.SkillAlt] = AttackHandler;
    _arr[_s, StandSkill.IconAlt] = global.sprSkillSkip;
    _arr[_s, StandSkill.DamageAlt] = 0;
    _arr[_s, StandSkill.DamageScaleAlt] = 0;
    _arr[_s, StandSkill.DamagePlayerStatAlt] = true;
    _arr[_s, StandSkill.MaxCooldownAlt] = 1;
    _arr[_s, StandSkill.CooldownAlt] = 0;
    // both
    _arr[_s, StandSkill.Key] = "";
    _arr[_s, StandSkill.GpBtn] = Input.DPad;
    _arr[_s, StandSkill.MaxHold] = 0.5;
    _arr[_s, StandSkill.Hold] = 0;
    _arr[_s, StandSkill.MaxExecutionTime] = 5;
    _arr[_s, StandSkill.ExecutionTime] = 0;
    _arr[_s, StandSkill.Desc] = "";
}
_arr[StandState.SkillAOff, StandSkill.GpBtn] = Input.LB;
_arr[StandState.SkillBOff, StandSkill.GpBtn] = Input.LT;
_arr[StandState.SkillCOff, StandSkill.GpBtn] = Input.RB;
_arr[StandState.SkillDOff, StandSkill.GpBtn] = Input.RT;
_arr[StandState.SkillA, StandSkill.GpBtn] = _arr[StandState.SkillAOff, StandSkill.GpBtn];
_arr[StandState.SkillB, StandSkill.GpBtn] = _arr[StandState.SkillBOff, StandSkill.GpBtn];
_arr[StandState.SkillC, StandSkill.GpBtn] = _arr[StandState.SkillCOff, StandSkill.GpBtn];
_arr[StandState.SkillD, StandSkill.GpBtn] = _arr[StandState.SkillDOff, StandSkill.GpBtn];

_arr[StandState.SkillAOff, StandSkill.Key] = player.abilityKeybind1;
_arr[StandState.SkillBOff, StandSkill.Key] = player.abilityKeybind2;
_arr[StandState.SkillCOff, StandSkill.Key] = player.abilityKeybind3;
_arr[StandState.SkillDOff, StandSkill.Key] = player.abilityKeybind4;
_arr[StandState.SkillA, StandSkill.Key] = _arr[StandState.SkillAOff, StandSkill.Key];
_arr[StandState.SkillB, StandSkill.Key] = _arr[StandState.SkillBOff, StandSkill.Key];
_arr[StandState.SkillC, StandSkill.Key] = _arr[StandState.SkillCOff, StandSkill.Key];
_arr[StandState.SkillD, StandSkill.Key] = _arr[StandState.SkillDOff, StandSkill.Key];

_arr[StandState.SkillAOff, StandSkill.EnergyCost] = 25;
_arr[StandState.SkillBOff, StandSkill.EnergyCost] = 50;
_arr[StandState.SkillCOff, StandSkill.EnergyCost] = 75;
_arr[StandState.SkillDOff, StandSkill.EnergyCost] = 100;
_arr[StandState.SkillA, StandSkill.EnergyCost] = 25;
_arr[StandState.SkillB, StandSkill.EnergyCost] = 50;
_arr[StandState.SkillC, StandSkill.EnergyCost] = 75;
_arr[StandState.SkillD, StandSkill.EnergyCost] = 100;

return _arr;

#define StandBuilder(_owner, _skills)

if (!instance_exists(_owner))
{
    if (instance_exists(player))
    {
        _owner = player;
    }
    if (instance_exists(STAND))
    {
        exit;
    }
}
if !bool("myStand" in _owner)
{
    _owner.myStand = noone;
}

RemoveStand(_owner);

// init
var _stand = ModObjectSpawn(_owner.x, _owner.y, 0);
with (_stand)
{
    // properties
    type = "stand";
    name = "unknown";
    owner = _owner;
    targets = [ENEMY, MOBJ];
    sprite_index = global.sprStarPlatinum;
    xTo = _owner.x;
    yTo = _owner.y;
    height = 0;
    rarity = {
        tier : Rarity.Common,
        name : Localize("commonName"),
        color : c_white,
        probability : 1
    };
    UpdateRarity(rarity.tier);
    saveKey = "jjbamStandless";
    discType = noone;
    color = c_white;
    colorAlt = c_white;
    summonSound = global.sndStandSummon;
    playSummonSound = true;
    auraParticleSprite = global.sprStandParticle;
    auraParticleRotation = 0;
    // state
    CDMultiplier = 1;
    attackState = 0;
    attackStateTimer = 0;
    active = false;
    state = StandState.Idle;
    mouseXSide = sign(owner.image_xscale);
    alphaTarget = 0;
    angleTarget = 0;
    angleTargetSpd = 0.1;
    scale = 1;
    scaleX = 1;
    scaleXSpd = 0.1;
    scaleY = 1;
    scaleYSpd = 0.1;
    target = noone;
    altAttack = false;
    soundIdle = undefined;
    soundIdleTimer = irandom_range(60, 120);
    soundWhenHurt = undefined;
    soundWhenDead = undefined;
    runIdlePos = true;
    idlePos = StandDefaultPos;
    summonMethod = StandDefaultSummon;
    runCDsMethod = StandSkillDefaultCDs;
    runDrawGUI = true;
    // stats
    powerMultiplier = GetPowerMultiplier(rarity.tier);
    spd = 0.5;
    stand_reach = 8;
    attack_reach = 1;
    crit_chance = 0;
    runes = [noone, noone, noone];
    max_energy = 0;
    energy = max_energy;
    // skills
    skills = array_clone(_skills);
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandDefaultStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(StandDefaultDraw), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandSkillDrawGUI), false);
    _owner.myStand = self;
}
return _stand;

#define GetPowerMultiplier(_rarity)

switch(_rarity)
{
    case Rarity.Common: return 1; break;
    case Rarity.Uncommon: return 2; break;
    case Rarity.Rare: return 4; break;
    case Rarity.Epic: return 8; break;
    case Rarity.Legendary: return 16; break;
    case Rarity.Mythical: return 32; break;
    case Rarity.Ascended: return 64; break;
    case Rarity.Ultimate: return 128; break;
    case Rarity.Event: return 256; break;
}

#define GetRarityName(_rarity)

switch(_rarity)
{
    case Rarity.Common: return Localize("commonName"); break;
    case Rarity.Uncommon: return Localize("uncommonName"); break;
    case Rarity.Rare: return Localize("rareName"); break;
    case Rarity.Epic: return Localize("epicName"); break;
    case Rarity.Legendary: return Localize("legendaryName"); break;
    case Rarity.Mythical: return Localize("mythicalName"); break;
    case Rarity.Ascended: return Localize("ascendedName"); break;
    case Rarity.Ultimate: return Localize("ultimateName"); break;
    case Rarity.Event: return Localize("eventName"); break;
}

#define GetRarityColor(_rarity)

switch(_rarity)
{
    case Rarity.Common: return c_white; break;
    case Rarity.Uncommon: return c_lime; break;
    case Rarity.Rare: return c_blue; break;
    case Rarity.Epic: return c_purple; break;
    case Rarity.Legendary: return c_yellow; break;
    case Rarity.Mythical: return c_red; break;
    case Rarity.Ascended: return c_orange; break;
    case Rarity.Ultimate: return c_fuchsia; break;
    case Rarity.Event: return c_aqua; break;
}

#define GetRarityWeight(_rarity)

switch(_rarity)
{
    case Rarity.Common: return global.common_arrow_weight; break;
    case Rarity.Uncommon: return global.uncommon_arrow_weight; break;
    case Rarity.Rare: return global.rare_arrow_weight; break;
    case Rarity.Epic: return global.epic_arrow_weight; break;
    case Rarity.Legendary: return global.legendary_arrow_weight; break;
    case Rarity.Mythical: return global.mythical_arrow_weight; break;
    case Rarity.Ascended: return global.ascended_arrow_weight; break;
    case Rarity.Ultimate: return global.ultimate_arrow_weight; break;
    case Rarity.Event: return 0; break;
}

#define UpdateRarity(_rarity)

rarity.tier = _rarity;
powerMultiplier = GetPowerMultiplier(_rarity);
rarity.name = GetRarityName(_rarity);
rarity.color = GetRarityColor(_rarity);
rarity.probability = (GetRarityWeight(_rarity) / get_total_weight(global.arrow_ability_pool)) * 100;

#define RemoveStand(_owner)

with (MOBJ)
{
    if bool("type" in self)
    {
        if (type == "timestop")
        {
            instance_destroy(self);
        }
    }
}
if (instance_exists(_owner) and instance_exists(_owner.myStand))
{
    RunesRemove(_owner);
    with (_owner.myStand)
    {
        state = StandState.Idle;
        for (var i = StandState.SkillAOff; i < StandState.SkillD; i++)
        {
            ResetCD(i);
        }
        instance_destroy(self);
    }
    _owner.myStand = noone;
}

#define GetStandReach(_stand)

return (stand_reach * GetRunesStandReach(_stand));
