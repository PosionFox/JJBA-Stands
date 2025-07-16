
global.jjsStandWorkshop = StructureCreate(
    undefined,
    "jjsStandWorkshop",
    "Customize your Stand",
    StructureType.Base,
    global.sprTheWorldAU,
    undefined,
    undefined,
    1,
    true,
    undefined,
    false,
    BuildMenuCategory.Magical,
    undefined,
    false
);

global.jjsStructureDiosCoffin = StructureCreate(
    undefined,
    "jjsStructureDiosCoffin",
    "",
    StructureType.Base,
    global.sprDiosCoffin,
    undefined,
    [
        Item.Wood, 100,
        Item.OnyxRelic, 10
    ],
    2,
    true,
    [
        global.jjsEgyptianCrown
    ],
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);
StructureEdit(global.jjsStructureDiosCoffin, StructureData.Name, tr("diosCoffinName"));
StructureEdit(global.jjsStructureDiosCoffin, StructureData.Description, tr("diosCoffinDescription"));

global.jjsShardsTable = StructureCreate(
    undefined,
    "jjsShardsTable",
    "",
    StructureType.Base,
    global.sprShardsTable,
    undefined,
    [
        Item.Wood, 100,
        global.jjsStarChunk, 4
    ],
    1,
    true,
    [
        global.jjsCommonShard,
        global.jjsUncommonShard,
        global.jjsRareShard,
        global.jjsEpicShard,
        global.jjsLegendaryShard,
        global.jjsMythicalShard,
        global.jjsCelestialShard,
        global.jjsUltimateShard,
        global.jjsBizarreMass,
        global.jjsCommonConcentratedArrow,
        global.jjsUncommonConcentratedArrow,
        global.jjsRareConcentratedArrow,
        global.jjsEpicConcentratedArrow,
        global.jjsLegendaryConcentratedArrow,
        global.jjsMythicalConcentratedArrow,
        global.jjsCelestialConcentratedArrow,
        global.jjsUltimateConcentratedArrow,
        global.jjsBizarreArrow
    ],
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);
StructureEdit(global.jjsShardsTable, StructureData.Name, tr("shardsTableName"));
StructureEdit(global.jjsShardsTable, StructureData.Description, tr("shardsTableDescription"));

#define SkillStandWorkshop

if (instance_exists(objPlayer))
{
    if ("skCustomStands" in objPlayer)
    {
        if (objPlayer.skCustomStands == true)
        {
            exit;
        }
    }
}

var _o = ModObjectSpawn(256, room_height - 256, -10000)
with (_o)
{
    sprite_index = sprSkillBorderMagic;
    image_speed = 0;
    
    selected = false;
    scale = 1;
    charge = 0;
    
    instance_activate_object(objPlayer);
    cash = objPlayer.coins;
    instance_deactivate_object(objPlayer);
    cost = 100000;
    
    InstanceAssignMethod(self, "step", ScriptWrap(SkillStandWorkshopStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(SkillStandWorkshopDraw), false);
}

#define SkillStandWorkshopStep

image_angle = lerp(image_angle, 0, 0.1);
image_xscale = lerp(image_xscale, scale, 0.1);
image_yscale = lerp(image_yscale, scale, 0.1);

if (selected)
{
    WorldControl.x = lerp(WorldControl.x, x, 0.2);
    WorldControl.y = lerp(WorldControl.y, y, 0.2);
}

if (mouse_check_button(mb_left))
{
    if (cash >= cost and selected and position_meeting(mouse_x, mouse_y, self))
    {
        charge += 1 / room_speed;
        image_angle += random_range(-4, 4);
        if (charge >= 3)
        {
            instance_activate_object(objPlayer);
            objPlayer.coins -= cost;
            instance_deactivate_object(objPlayer);
            charge = 0;
            instance_activate_object(objPlayer);
            if (instance_exists(objPlayer))
            {
                objPlayer.skCustomStands = true;
            }
            ScriptCall(ScriptWrap(SaveData));
            Trace(objPlayer.skCustomStands);
            instance_deactivate_object(objPlayer);
            selected = false;
            ExplosionEffect(x, y);
            instance_destroy(self);
        }
    }
}

if (mouse_check_button_pressed(mb_left))
{
    if (position_meeting(mouse_x, mouse_y, self))
    {
        scale = 1.5;
        selected = true;
    }
    else
    {
        scale = 1;
        charge = 0;
        selected = false;
    }
}

#define SkillStandWorkshopDraw

draw_self();
draw_sprite_ext(global.sprSkillCharisma, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite(sprCoin, 0, x - (2 + (18 * image_xscale)), y - (18 + (10 * image_yscale)));
draw_text_transformed(x + 10, y - (18 + (4 * image_xscale)), "100k", image_xscale - 0.5, image_yscale - 0.5, 0);
if (selected)
{
    draw_text_transformed(x, y + 42, "stand customization", image_xscale - 1, image_yscale - 1, 0);
}

#define OpenStandWorkshop

var xx = 0;
var yy = 0;
if (instance_exists(player))
{
    xx = player.x;
    yy = player.y;
}
var _o = ModObjectSpawn(xx, yy, -1000);
with (_o)
{
    type = "StandWorkshop";
    
    x1 = CAM.x;
    x2 = CAM.x;
    y1 = CAM.y;
    y2 = CAM.y;
    selectedNewSkill = noone;
    replaced_skill = noone;
    scroll = 0;
    
    current_skills = [];
    for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
    {
        var _button = StandWorkshopButton(i);
        _button.depth = depth - 1;
        _button.owner = self;
        _button.icon = STAND.skills[i, StandSkill.Icon];
        _button.color = STAND.color;
        _button.colorAlt = STAND.colorAlt;
        array_push(current_skills, _button);
    }
    
    available_skills = [];
    var _skslen = array_length(global.jjsStandWorkshopStorage);
    for (var i = 0; i < _skslen; i++)
    {
        if (global.jjsStandWorkshopStorage[i] != undefined)
        {
            var _skill_data;
            var _skill_button = StandWorkshopSkillDrag();
            _skill_button.depth = depth - 2;
            _skill_button.owner = self;
            if (is_string(global.jjsStandWorkshopStorage[i]))
            {
                Trace(global.jjsStandWorkshopStorage[i]);
                _skill_data = json_parse(global.jjsStandWorkshopStorage[i]);
                if _skill_data[? "skill_name"] != undefined _skill_button.skill = script_get_index(_skill_data[? "skill_name"]);
                if _skill_data[? "icon"] != undefined _skill_button.icon = _skill_data[? "icon"];
                if _skill_data[? "color"] != undefined _skill_button.color = _skill_data[? "color"];
                if _skill_data[? "color_alt"] != undefined _skill_button.colorAlt = _skill_data[? "color_alt"];
            }
            array_push(available_skills, _skill_button);
            json_destroy(_skill_data);
        }
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopStep), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandWorkshopDrawGUI), false);
}

#define CloseStandWorkshop

var _sw = modTypeFind("StandWorkshop");
    if (instance_exists(_sw))
    {
    for (var i = 0; i < array_length(current_skills); i++)
    {
        instance_destroy(current_skills[i]);
    }
    for (var i = 0; i < array_length(available_skills); i++)
    {
        instance_destroy(available_skills[i]);
    }
    instance_destroy(self);
    exit;
}

#define StandWorkshopStep

var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

x1 = lerp(x1, 0, 0.2);
x2 = lerp(x2, display_get_gui_width() - 1, 0.2);
y1 = lerp(y1, 0, 0.2);
y2 = lerp(y2, display_get_gui_height() - 1, 0.2);

var _btlen = array_length(current_skills); // current skills
for (var i = 0; i < _btlen; i++)
{
    current_skills[i].uix = _cx + (96 * i) - (42 * _btlen);
    current_skills[i].uiy = _cy - 128;
}

var _len = array_length(available_skills); // available skills
for (var i = 0; i < _len; i++)
{
    available_skills[i].uix = _cx + (96 * (i mod 8)) - (42 * 8);
    available_skills[i].uiy = (_cy + 128 - scroll) + (96 * (i div 8));
}

// if (keyboard_check_pressed(ord("K")))
// {
//     repeat (8)
//     {
//         for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
//         {
//             var _skill = [];
//             array_push(_skill, STAND.skills[i, StandSkill.Skill]);
//             array_push(_skill, STAND.skills[i, StandSkill.Icon]);
//             array_push(available_skills, _skill);
//         }
        
//         for (var i = 0; i < array_length(available_skills); i++)
//         {
//             instance_destroy(available_skills[i]);
//         }
//         available_skills = [];
        
//         for (var i = 0; i < array_length(available_skills); i++)
//         {
//             var _skillB = StandWorkshopSkillDrag();
//             _skillB.owner = self;
//             _skillB.skill = available_skills[i, 0];
//             _skillB.icon = available_skills[i, 1];
//             array_push(available_skills, _skillB);
//         }
//     }
// }

if (mouse_wheel_up())
{
    scroll -= 8;
}
if (mouse_wheel_down())
{
    scroll += 8;
}
scroll = clamp(scroll, 0, (_len div 8) * 96);

if (instance_exists(replaced_skill))
{
    STAND.skills[replaced_skill.skillId, StandSkill.Skill] = selectedNewSkill.skill;
    STAND.skills[replaced_skill.skillId, StandSkill.Icon] = selectedNewSkill.icon;
    STAND.skills[replaced_skill.skillId, StandSkill.Custom] = true;
    
    for (var i = 0; i < array_length(current_skills); i++)
    {
        if (instance_exists(current_skills[i])) instance_destroy(current_skills[i]);
    }
    current_skills = [];
    for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
    {
        var _button = StandWorkshopButton(i);
        _button.depth = depth - 1;
        _button.owner = self;
        _button.icon = STAND.skills[i, StandSkill.Icon];
        _button.color = STAND.color;
        _button.colorAlt = STAND.colorAlt;
        array_push(current_skills, _button);
    }
    
    selectedNewSkill = noone;
    replaced_skill = noone;
}

if (keyboard_check_pressed(vk_escape) or !instance_exists(player) or !instance_exists(STAND))
{
    CloseStandWorkshop();
}

#define StandWorkshopDrawGUI

var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_alpha(0.5);
draw_set_color(STAND.color);
draw_rectangle(x1, y1, x2, y2, true);
draw_set_color(image_blend);
draw_set_alpha(image_alpha);

var _xx = _cx - 384;
var _yy = _cy;
var _w = 768;
var _h = 256;
draw_rectangle_color(_xx - 4, _yy - 4, _xx + _w + 4, _yy + _h + 4, c_dkgray, c_dkgray, c_black, c_black, false);
draw_rectangle_color(_xx, _yy, _xx + _w, _yy + _h, c_black, c_black, c_dkgray, c_dkgray, false);

draw_set_halign(fa_middle);
draw_text(_cx, _cy, "-drag and drop the abilites you want from below-");
draw_set_halign(fa_left);

var _len = array_length(available_skills); // draw available skills
for (var i = _len - 1; i >= 0; i--)
{
    var _sb = available_skills[i];
    if (_sb.drag or _sb.uiy > _cy + 16 and _sb.uiy < _cy + 240)
    {
        _sb.can_draw = true;
    }
    else
    {
        _sb.can_draw = false;
    }
    
    if (_sb.scale > 0.02)
    {
        draw_sprite_general(global.sprSkillTemplate, 0, 0, 0, 32, 32, _sb.uix - 16 * _sb.image_xscale, _sb.uiy - 16 * _sb.image_yscale, _sb.image_xscale * _sb.scale, _sb.image_yscale * _sb.scale, _sb.image_angle, _sb.color, _sb.color, _sb.colorAlt, _sb.colorAlt, _sb.image_alpha);
        draw_sprite_general(_sb.icon, 0, 0, 0, 32, 32, _sb.uix - 16 * _sb.image_xscale, _sb.uiy - 16 * _sb.image_yscale, _sb.image_xscale * _sb.scale, _sb.image_yscale * _sb.scale, _sb.image_angle, _sb.colorAlt, _sb.colorAlt, _sb.color, _sb.color, _sb.image_alpha);
    }
}

_xx = _gw - 224;
_yy = _cy;
_w = 768;
_h = 256;

var _vsh = draw_vscroll(_xx, _yy, 256, 16, ((_len div 8) * 96), scroll);
if (_vsh != undefined)
{
    scroll = _vsh;
}

var _bs = draw_button_square(_cy + 576, _cy - 288, 256, 32, "!sacrifice stand!");
if (_bs)
{
    var _storage_full = true;
    var _skslen = array_length(global.jjsStandWorkshopStorage);
    for (var i = 0; i < _skslen; i++)
    {
        if (global.jjsStandWorkshopStorage[i] == undefined)
        {
            _storage_full = false;
            var _new_skill = ds_map_create();
            _new_skill[? "skill_name"] = string(script_get_name(STAND.skills[StandState.SkillA, StandSkill.Skill]));
            _new_skill[? "icon"] = STAND.skills[StandState.SkillA, StandSkill.Icon];
            _new_skill[? "damage"] = STAND.skills[StandState.SkillA, StandSkill.Damage];
            _new_skill[? "damage_scale"] = STAND.skills[StandState.SkillA, StandSkill.DamageScale];
            _new_skill[? "damage_player_stat"] = STAND.skills[StandState.SkillA, StandSkill.DamagePlayerStat];
            _new_skill[? "max_cooldown"] = STAND.skills[StandState.SkillA, StandSkill.MaxCooldown];
            _new_skill[? "max_execution_time"] = STAND.skills[StandState.SkillA, StandSkill.MaxExecutionTime];
            _new_skill[? "color"] = real(STAND.color);
            _new_skill[? "color_alt"] = real(STAND.colorAlt);
            _new_skill[? "custom"] = true;
            global.jjsStandWorkshopStorage[i] = json_stringify(_new_skill);
            json_destroy(_new_skill);
            RemoveStand(player);
            break;
        }
    }
    if (_storage_full)
    {
        Trace("skills storage full!");
    }
}

// var _mx = device_mouse_x_to_gui(0);
// var _my = device_mouse_y_to_gui(0);
// draw_text(_mx, _my, string(_mx));
// draw_text(_mx, _my + 32, string(_my));
// var xo = 64;
// var yo = 256;
// var mx = device_mouse_x_to_gui(0);
// var my = device_mouse_y_to_gui(0);
// for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
// {
//     draw_sprite(global.sprSkillTemplate, 0, xo + (32 * i), yo);
//     draw_sprite(objPlayer.myStand.skills[i, StandSkill.Icon], 0, 64 + (32 * i), yo);
//     draw_sprite(global.sprSkillHoldTemplate, 0, xo + (32 * i), yo + 32);
//     draw_sprite(objPlayer.myStand.skills[i, StandSkill.IconAlt], 0, 64 + (32 * i), yo + 32);
// }

#define StandWorkshopButton(_id)

var _o = ModObjectSpawn(CAM.x, CAM.y, 0);//-1000000);
with (_o)
{
    owner = noone;
    type = "StandWorkshopButton";
    icon = global.sprSkillTemplate;
    skillId = _id;
    uix = 0;
    uiy = 0;
    image_xscale = 2;
    image_yscale = 2;
    color = c_white;
    colorAlt = c_ltgray;
    
    hover = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopButtonStep), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandWorkshopButtonDrawGUI), false);
}
return _o;

#define StandWorkshopButtonStep

if (hover)
{
    image_xscale = 4;
    image_yscale = 4;
}
else
{
    image_xscale = 2;
    image_yscale = 2;
}

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
if (point_in_rectangle(_mx, _my, uix - 32, uiy - 32, uix + 32, uiy + 32))
{
    hover = true;
    
    if (mouse_check_button_released(mb_left))
    {
        if (owner.selectedNewSkill != noone)
        {
            owner.replaced_skill = self;
        }
    }
}
else
{
    hover = false;
}

#define StandWorkshopButtonDrawGUI

draw_sprite_general(global.sprSkillTemplate, 0, 0, 0, 32, 32, uix - 16 * image_xscale, uiy - 16 * image_yscale, image_xscale, image_yscale, image_angle, colorAlt, colorAlt, color, color, image_alpha);
draw_sprite_general(icon, 0, 0, 0, 32, 32, uix - 16 * image_xscale, uiy - 16 * image_yscale, image_xscale, image_yscale, image_angle, color, color, colorAlt, colorAlt, image_alpha);
// draw_text(uix, uiy, string(uix));
// draw_text(uix, uiy + 32, string(uiy));

#define StandWorkshopSkillDrag

var _o = ModObjectSpawn(CAM.x, CAM.y, -1);
with (_o)
{
    owner = noone;
    type = "StandWorkshopSkill";
    uix = 0;
    uiy = 0;
    image_xscale = 2;
    image_yscale = 2;
    color = c_white;
    colorAlt = c_white;
    
    skill = StandBarrage;
    icon = global.sprSkillBarrage;
    can_draw = false;
    
    drag = false;
    hover = false;
    scale = 1;
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopSkillDragStep), false);
}
return _o;

#define StandWorkshopSkillDragStep

if (can_draw)
{
    scale = lerp(scale, 1, 0.2);
}
else
{
    scale = lerp(scale, 0, 0.2);
    exit;
}

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (hover)
{
    image_xscale = 3;
    image_yscale = 3;
}
else
{
    image_xscale = 2;
    image_yscale = 2;
}

if (drag)
{
    uix = _mx;
    uiy = _my;
}

if (point_in_rectangle(_mx, _my, uix - 32, uiy - 32, uix + 32, uiy + 32))
{
    hover = true;
    if (mouse_check_button_pressed(mb_left) and skill != noone and can_draw)
    {
        owner.selectedNewSkill = self;
        drag = true;
    }
    if (mouse_check_button_released(mb_left))
    {
        if (drag)
        {
            drag = false;
        }
    }
}
else
{
    hover = false;
}


