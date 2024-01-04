
global.jjbamStandWorkshop = StructureCreate(
    undefined,
    "Stand Workshop",
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

global.jjStructureDiosCoffin = StructureCreate(
    undefined,
    Localize("diosCoffinName"),
    Localize("diosCoffinDescription"),
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
        global.jjEgyptianCrown
    ],
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);

global.jjShardsTable = StructureCreate(
    undefined,
    Localize("shardsTableName"),
    Localize("shardsTableDescription"),
    StructureType.Base,
    global.sprShardsTable,
    undefined,
    [
        Item.Wood, 100,
        Item.StarFragment, 1
    ],
    1,
    true,
    [
        global.jjCommonConcentratedArrow,
        global.jjUncommonConcentratedArrow,
        global.jjRareConcentratedArrow,
        global.jjEpicConcentratedArrow,
        global.jjLegendaryConcentratedArrow,
        global.jjMythicalConcentratedArrow,
        global.jjAscendedConcentratedArrow,
        global.jjUltimateConcentratedArrow
    ],
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);

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
if (instance_exists(objPlayer))
{
    xx = objPlayer.x;
    yy = objPlayer.y;
}
var _o = ModObjectSpawn(xx, yy, -1000);
with (_o)
{
    type = "StandWorkshop";
    
    x1 = WorldControl.x;
    x2 = WorldControl.x;
    y1 = WorldControl.y;
    y2 = WorldControl.y;
    selectedNewSkill = noone;
    scroll = 0;
    
    buttons = [];
    for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
    {
        var _button = StandWorkshopButton(i);
        _button.owner = self;
        array_push(buttons, _button);
    }
    
    availableSkills = [];
    
    skillButtons = [];
    for (var i = 0; i < array_length(availableSkills); i++)
    {
        var _skillB = StandWorkshopSkillDrag();
        _skillB.owner = self;
        _skillB.skill = availableSkills[i, 0];
        _skillB.icon = availableSkills[i, 1];
        array_push(skillButtons, _skillB);
    }
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopStep), false);
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(StandWorkshopDrawGUI), false);
}

#define StandWorkshopStep

x1 = lerp(x1, 0, 0.2);
x2 = lerp(x2, display_get_gui_width() - 1, 0.2);
y1 = lerp(y1, 0, 0.2);
y2 = lerp(y2, display_get_gui_height() - 1, 0.2);

if (keyboard_check_pressed(vk_escape) or !instance_exists(objPlayer) or !instance_exists(objPlayer.myStand))
{
    for (var i = 0; i < array_length(buttons); i++)
    {
        instance_destroy(buttons[i]);
    }
    for (var i = 0; i < array_length(skillButtons); i++)
    {
        instance_destroy(skillButtons[i]);
    }
    instance_destroy(self);
    exit;
}

for (var i = 0; i < array_length(buttons); i++)
{
    buttons[i].x = (WorldControl.x - 112) + (32 * i);
    buttons[i].y = WorldControl.y - 32;
}

var _len = array_length(skillButtons);
for (var i = 0; i < _len; i++)
{
    skillButtons[i].x = (WorldControl.x - 112) + (32 * (i mod 8));
    skillButtons[i].y = ((WorldControl.y + 16) - scroll) + (32 * (i div 8));
}

if (keyboard_check_pressed(ord("K")))
{
    for (var i = StandState.SkillAOff; i <= StandState.SkillD; i++)
    {
        var _skill = [];
        array_push(_skill, objPlayer.myStand.skills[i, StandSkill.Skill]);
        array_push(_skill, objPlayer.myStand.skills[i, StandSkill.Icon]);
        array_push(availableSkills, _skill);
    }
    
    for (var i = 0; i < array_length(skillButtons); i++)
    {
        instance_destroy(skillButtons[i]);
    }
    skillButtons = [];
    
    for (var i = 0; i < array_length(availableSkills); i++)
    {
        var _skillB = StandWorkshopSkillDrag();
        _skillB.owner = self;
        _skillB.skill = availableSkills[i, 0];
        _skillB.icon = availableSkills[i, 1];
        array_push(skillButtons, _skillB);
    }
}

if (mouse_wheel_up())
{
    scroll += 4;
}
if (mouse_wheel_down())
{
    scroll -= 4;
}
scroll = clamp(scroll, 0, (array_length(availableSkills) * 4) - 32)

#define StandWorkshopDrawGUI

var w = display_get_gui_width();
var h = display_get_gui_height();

draw_set_alpha(0.5);
draw_set_color(objPlayer.myStand.color);
draw_rectangle(x1, y1, x2, y2, true);
draw_set_color(image_blend);
draw_set_alpha(image_alpha);

draw_set_halign(fa_middle);
draw_text(w * 0.5, h * 0.5, "drag and drop the abilites you want from below");
draw_set_halign(fa_left);

var _len = array_length(availableSkills);
draw_set_color(c_ltgray);
draw_line_width(w - 64, h * 0.5, w - 64, (h * 0.5) + 100, 2);
draw_set_color(objPlayer.myStand.color);
draw_circle(w - 64, (h * 0.5) + (scroll / (_len * 4)) * 100, 5, false);
draw_set_color(image_blend);

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

var _o = ModObjectSpawn(WorldControl.x, WorldControl.y, -1000000);
with (_o)
{
    owner = noone;
    type = "StandWorkshopButton";
    skillId = _id;
    sprite_index = global.sprSkillTemplate;
    image_xscale = 0.5;
    image_yscale = 0.5;
    
    hover = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopButtonStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(StandWorkshopButtonDraw), false);
}
return _o;

#define StandWorkshopButtonStep

if (hover)
{
    image_xscale = 0.8;
    image_yscale = 0.8;
}
else
{
    image_xscale = 0.5;
    image_yscale = 0.5;
}

if (position_meeting(mouse_x, mouse_y, self))
{
    hover = true;
    
    if (mouse_check_button_released(mb_left))
    {
        if (owner.selectedNewSkill != noone)
        {
            objPlayer.myStand.skills[skillId, StandSkill.Skill] = owner.selectedNewSkill.skill;
            objPlayer.myStand.skills[skillId, StandSkill.Icon] = owner.selectedNewSkill.icon;
        }
    }
}
else
{
    hover = false;
}

#define StandWorkshopButtonDraw

draw_self();
draw_sprite_ext(objPlayer.myStand.skills[skillId, StandSkill.Icon], 0, x, y, image_xscale, image_yscale, image_angle, objPlayer.myStand.color, image_alpha);

#define StandWorkshopSkillDrag

var _o = ModObjectSpawn(WorldControl.x, WorldControl.y, -1000001);
with (_o)
{
    owner = noone;
    type = "StandWorkshopSkill";
    sprite_index = global.sprSkillTemplate;
    image_xscale = 0.5;
    image_yscale = 0.5;
    
    skill = noone;
    icon = global.sprSkillBarrage;
    
    drag = false;
    
    InstanceAssignMethod(self, "step", ScriptWrap(StandWorkshopSkillDragStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(StandWorkshopSkillDragDraw), false);
}
return _o;

#define StandWorkshopSkillDragStep

if (y < WorldControl.y + 16 or y > WorldControl.y + 64)
{
    visible = false;
}
else
{
    visible = true;
}

if (drag)
{
    x = mouse_x;
    y = mouse_y;
}

if (mouse_check_button_pressed(mb_left) and skill != noone and visible)
{
    if (position_meeting(mouse_x, mouse_y, self))
    {
        owner.selectedNewSkill = self;
        drag = true;
    }
}
if (mouse_check_button_released(mb_left))
{
    if (drag)
    {
        owner.selectedNewSkill = noone;
        drag = false;
    }
}

#define StandWorkshopSkillDragDraw

draw_self();
draw_sprite_ext(icon, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);




