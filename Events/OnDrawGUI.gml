
#define OnDrawGUI

if (!instance_exists(player)) exit;

if (global.jjShowMenu and !instance_exists(objPlayerMenu))
{
    player.freeze = 5;
    
    var _color1 = Color.DarkBlue;
    var _color2 = Color.Magenta;
    if (instance_exists(STAND) and global.jjsSettBackgroundStandColors)
    {
        _color1 = STAND.color;
        _color2 = STAND.colorAlt;
    }
    
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    
    var _rx1 = _cx - 512;
    var _ry1 = _cy - 256;
    var _rx2 = _cx + 512;
    var _ry2 = _cy + 256;
    
    draw_rectangle_color(_rx1 - 4, _ry1 - 4, _rx2 + 4, _ry2 + 4, _color2, _color2, _color1, _color1, false);
    draw_rectangle_color(_rx1, _ry1, _rx2, _ry2, _color1, _color1, _color2, _color2, false);
    
    switch (global.jjMenuCurrent)
    {
        case "main":
            menu_main_draw(_cx, _cy);
        break;
        case "info":
            menu_info_draw(_cx, _cy);
        break;
        case "stats":
            menu_stats_draw(_cx, _cy);
        break;
        case "storage":
            menu_storage_draw(_cx, _cy);
        break;
        case "runes":
            menu_runes_draw(_cx, _cy);
        break;
        case "variants":
            menu_variants_draw(_cx, _cy);
        break;
        case "evolutions":
            menu_evolutions_draw(_cx, _cy);
        break;
        case "settings":
            menu_settings_draw(_cx, _cy);
        break;
    }
}
else
{
    var _dw = display_get_gui_width();
    var _dh = display_get_gui_height();
    var _tx = "m";
    if (global.jjNewGame) _tx = "!";
    var _sx = 32 + (sin(current_time / 100) * 8 * global.jjNewGame);
    var _sy = 32 + (sin(current_time / 100) * 8 * global.jjNewGame);
    var _bm = draw_button_square_alpha(_dw - _sx - 72, _dh - _sy - 22, _sx, _sy, _tx, 0.75);
    if (_bm)
    {
        global.jjShowMenu = true;
        jj_play_audio(global.sndMenuOpen, 5, false);
        if (global.jjNewGame)
        {
            global.jjMenuCurrent = "info";
            global.jjMenuSubCurrent = "default";
            global.jjNewGame = false;
        }
    }
}

//draw_text(mouse_x, mouse_y, string(global.jjMenuHover));

#define menu_main_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _mtxt = "mod menu";
draw_text_color(_cx, _ry1 + string_height(_mtxt), _mtxt, c_white, c_white, c_ltgray, c_ltgray, 1);

switch (global.jjMenuSubCurrent)
{
    case "default":
        var _bc = draw_button_square(_rx1, _ry1, 128, 32, "close");
        if (_bc)
        {
            global.jjShowMenu = false;
        }
        
        var _mbtns = ["info", "stats", "storage", "runes", "variants", "evolutions", "settings"]
        var _mlen = array_length(_mbtns);
        
        for (var i = 0; i < _mlen; i++)
        {
            var _b = draw_button_square(_cx - 128, _cy - 208 + (64 * i), 256, 32, _mbtns[i]);
            if (_b)
            {
                global.jjMenuCurrent = _mbtns[i];
                global.jjMenuHover = undefined;
            }
        }
        
        var _mv = "jjba stands v" + string(global.jjVersion);
        draw_text(_rx1 + 8 + string_width(_mv) / 2, _ry2, _mv);
        var _sv = "steam date version " + string(global.jjSteamVersion) + " (dmy)";
        var _bx = _rx2 + 8 - string_width(_sv) / 2;
        var _by = _ry2;
        draw_text(_bx, _by, _sv);
        
        var _bc = draw_button_square(_rx2 - 128, _ry1, 128, 32, "changelog");
        if (_bc)
        {
            global.jjMenuSubCurrent = "changelog";
        }
    break;
    case "changelog":
        draw_text_color(_cx, _ry1 + 64, "changelog (online)", c_white, c_white, c_yellow, c_yellow, 1);
        
        var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
        if (_bb)
        {
            global.jjMenuSubCurrent = "default";
        }
        
        if (!surface_exists(global.jjsModChangelogSurf))
        {
            global.jjsModChangelogSurf = surface_create(996, 440);
        }
        if (global.jjsModChangelog != undefined)
        {
            var _txt = global.jjsModChangelog;
            draw_set_valign(fa_top);
            surface_set_target(global.jjsModChangelogSurf);
            draw_clear_alpha(c_white, 0);
            draw_text_ext(522, 40 - global.jjsModChangelogScroll, _txt, 24, 896);
            surface_reset_target();
            draw_surface(global.jjsModChangelogSurf, _rx1, _ry1 + 72);
            var _vsc = draw_vscroll(_rx2 - 28, _ry1 + 28, 457, 32, string_height(_txt) * 1.1, global.jjsModChangelogScroll);
            if (_vsc != undefined)
            {
                global.jjsModChangelogScroll = _vsc;
            }
        }
        if (surface_exists(global.jjsModChangelogSurf))
        {
            surface_free(global.jjsModChangelogSurf);
        }
    break;
}

#define menu_info_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
    global.jjMenuSubCurrent = "default";
}

var _title = tr("mm_info_welcome");
draw_text_color(_cx, _ry1 + string_height(_title), _title, c_white, c_white, c_yellow, c_yellow, 1);

var _infos = ["intro", "stands", "controls", "stats", "storage", "evolution", "traits", "runes", "more"];
var _ilen = array_length(_infos);

for (var i = 0; i < _ilen; i++)
{
    var _b = draw_button_square(_rx1 + (146 * (i mod 7)), _ry2 - 74 + (42 * (i div 7)), 138, 32, _infos[i]);
    if (_b)
    {
        global.jjMenuSubCurrent = _infos[i];
    }
}

switch (global.jjMenuSubCurrent)
{
    case "default":
        draw_text_color(_cx, _ry1 + 64, "hello!", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text(_cx, _cy, "you can learn about the mod here!\n\nclick the 'intro' button at the bottom left to get started.");
    break;
    case "intro":
        draw_text_color(_cx, _ry1 + 64, "intro", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text(_cx, _cy, tr("mm_info_intro"));
    break;
    case "stands":
        draw_text_color(_cx, _ry1 + 64, "how to get a stand", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text(_cx, _cy,
@"you can try any of the following options:

-start a new game
-craft a suspicious arrow in a forge and use it
-dig up(digging spot) and use a holy part from the desert"
        );
        draw_sprite_ext(sprMainMenuPlay, 0, _rx1 + 160, _ry2 - 128, 2, 2, 0, c_white, 1);
        draw_sprite_ext(global.sprArrow, 0, _cx, _ry2 - 128, 4, 4, 0, c_white, 1);
        draw_sprite_ext(global.sprHolyLeftArm, 0, _rx2 - 160, _ry2 - 128, 4, 4, 0, c_white, 1);
    break;
    case "controls":
        draw_text_color(_cx, _ry1 + 64, "how to use your stand", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"you can summon or dismiss your stand by pressing q,
some abilities can only be executed while your stand is active and vice versa.
the default keybinds for using your stand's abilities are:
r, f, c and g
some stands have abilities that can be performed by holding the respective ability keybind.
you can remap your keybinds in the controls settings menu
or with the jjremapkeybind command.", 24, 1000);
    break;
    case "stats":
        draw_text_color(_cx, _ry1 + 64, "stand stats", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"every stand has 6 unique stats.
destructive power which affects your stand damage.
speed which affects the velocity of your attacks.
range which affects how far your stand and attacks go.
stamina which affects how frequently you can use abilities.
precision which affects how likely your stand is to land a critical hit.
and lastly
development potential which affects how fast your stand levels up.
every time you level up, your stand gains a stat point which you can assign to one of your first 5 stats,
you can also decrease a stat to gain stat points and invest them into a different stat.", 24, 1000);
    break;
    case "storage":
        draw_text_color(_cx, _ry1 + 64, "stand storage", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"you cannot possess more than one stand at a time.
you will have to store your current stand in the stand storage to get a new one.

you can open the storage from here by clicking the back button at the top left and then the storage button from the main mod menu!", 24, 1000);
    break;
    case "evolution":
        draw_text_color(_cx, _ry1 + 64, "how to evolve your stand", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"some stands are capable of evolving into a stronger form.
if you just started a new game, you can check your available evolutions by clicking the evolutions button in the main mod menu.", 24, 1000);
        draw_arrow(_rx1 + 160, _ry2 - 128, _rx2 - 160 - 32, _ry2 - 128, 64);
        draw_sprite_ext(global.sprShadowTheWorld, 0, _rx1 + 160, _ry2 - 128, 4, 4, 0, c_white, 1);
        draw_sprite_ext(global.sprTheWorld, 0, _rx2 - 160, _ry2 - 128, 4, 4, 0, c_white, 1);
    break;
    case "traits":
        draw_text_color(_cx, _ry1 + 64, "stand traits", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"every stand has a trait.
most traits are pretty straightforward, they increase your damage or your health regeneration.
some traits may be more complex, like giving you the ability to reflect damage taken.", 24, 1000);
        var _cmn = GetRarityColor(Rarity.Common);
        var _cll = GetRarityColor(Rarity.Celestial);
        var _ult = GetRarityColor(Rarity.Ultimate);
        draw_text_color(_rx1 + 160, _ry2 - 128, "fit", _cmn, _cmn, _cmn, _cmn, 1);
        draw_text_color(_cx, _ry2 - 128, "mirror", _cll, _cll, _cll, _cll, 1);
        draw_text_color(_rx2 - 160, _ry2 - 128, "hercules", _ult, _ult, _ult, _ult, 1);
    break;
    case "runes":
        draw_text_color(_cx, _ry1 + 64, "stand runes", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"every stand may have up to 3 runes at a time.
similar to traits, runes enhance you or your stand, the key difference being that you can have up to 3 runes at a time instead of just one 1 trait.

the only current method to get runes is by defeating dio.", 24, 1000);
        draw_sprite_ext(global.sprBlankRune, 0, _rx1 + 160, _ry2 - 128, 4, 4, 0, c_white, 1);
        draw_sprite_ext(global.sprRuneMending, 0, _rx1 + 160, _ry2 - 128, 4, 4, 0, GetRarityColor(Rarity.Uncommon), 1);
        draw_sprite_ext(global.sprBlankRune, 0, _cx, _ry2 - 128, 4, 4, 0, c_white, 1);
        draw_sprite_ext(global.sprRuneMight, 0, _cx, _ry2 - 128, 4, 4, 0, GetRarityColor(Rarity.Legendary), 1);
        draw_sprite_ext(global.sprBlankRune, 0, _rx2 - 160, _ry2 - 128, 4, 4, 0, c_white, 1);
        draw_sprite_ext(global.sprRuneEnergize, 0, _rx2 - 160, _ry2 - 128, 4, 4, 0, GetRarityColor(Rarity.Ultimate), 1);
    break;
    case "more":
        draw_text_color(_cx, _ry1 + 64, "and more!", c_white, c_white, c_aqua, c_aqua, 1);
        draw_text_ext(_cx, _cy,
@"this covers the basics, but there are a lot more features, new items, new enemies, new structures, npcs.

have fun!", 24, 1000);
    draw_sprite_ext(global.sprBtdStare, 0, _cx, _ry2 - 128, 2, 2, 0, c_white, 1);
    break;
}

#define menu_stats_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
}

var _bst = draw_button_square(_rx2 - 128, _ry1, 128, 32, "storage");
if (_bst)
{
    global.jjMenuCurrent = "storage";
}

if (instance_exists(STAND))
{
    draw_text_color(_cx, _ry1 + 16, string_lower(string(STAND.name)), STAND.color, STAND.colorAlt, STAND.color, STAND.colorAlt, 1);
    
    var _sx = _rx1 + 8;
    var _sy = _ry1 + 64;
    
    var _stats = [
        ["power", STAND.destructive_power, "destructive_power", Color.Power, STAND.mod_destructive_power],
        ["speed", STAND.spd, "spd", Color.Speed, STAND.mod_spd],
        ["range", STAND.range, "range", Color.Range, STAND.mod_range],
        ["stamina", STAND.stamina, "stamina", Color.Stamina, STAND.mod_stamina],
        ["precision", STAND.precision, "precision", Color.Precision, STAND.mod_precision]
    ]
    
    for (var i = 0; i < array_length(_stats); i++)
    {
        // var _quality = "?";
        // var _stp = _stats[i][1];
        // if (_stp < 3) _quality = "sss";
        // if (_stp < 2.75) _quality = "ss";
        // if (_stp < 2.5) _quality = "s+";
        // if (_stp < 2.25) _quality = "s";
        // if (_stp < 2) _quality = "a+";
        // if (_stp < 1.75) _quality = "a";
        // if (_stp < 1.5) _quality = "b";
        // if (_stp < 1.25) _quality = "c";
        // if (_stp < 1) _quality = "d";
        // if (_stp < 0.75) _quality = "e";
        // if (_stp < 0.55) _quality = "f";
        // var _txt = string(_stats[i][0]) + ": " + string(round(_stats[i][1] * 100)) + "% (" + string(_quality) + ")";
        var _txt = string(_stats[i][0]) + ": " + string(round(_stats[i][1] * 100)) + "%";
        if (_stats[i][4] > 0) _txt += " +" + string(round(_stats[i][4] * 100));
        draw_set_halign(fa_left);
        var _bgap = 40;
        var _spac = 80;
        var _col = _stats[i][3];
        draw_text_color(_sx, _sy + (_spac * i) + 12, _txt, _col, _col, _col, _col, 1);
        //draw_rectangle_color(_sx - 56, _sy + (48 * i) + 24, _sx + 56, _sy + (48 * i) + 24 + 16, c_white, c_white, _stats[i][3], _stats[i][3], false);
        
        draw_set_halign(fa_center);
        if (draw_button_circle(_sx + 8 + (_bgap * 0), _sy + (_spac * i) + 34, 10, "--", true))
        {
            if (variable_instance_get(STAND, _stats[i][2]) > 0.5)
            {
                variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) - 0.01);
                STAND.stat_points++;
            }
        }
        if (draw_button_circle(_sx + 8 + (_bgap * 1), _sy + (_spac * i) + 34, 10, "-", false))
        {
            if (variable_instance_get(STAND, _stats[i][2]) > 0.5)
            {
                variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) - 0.01);
                STAND.stat_points++;
            }
        }
        if (draw_button_circle(_sx + 8 + (_bgap * 2), _sy + (_spac * i) + 34, 10, "+", false))
        {
            if (STAND.stat_points > 0)
            {
                variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) + 0.01);
                STAND.stat_points--;
            }
        }
        if (draw_button_circle(_sx + 8 + (_bgap * 3), _sy + (_spac * i) + 34, 10, "++", true))
        {
            if (STAND.stat_points > 0)
            {
                variable_instance_set(STAND, _stats[i][2], variable_instance_get(STAND, _stats[i][2]) + 0.01);
                STAND.stat_points--;
            }
        }
    }
    
    var _rnx = _rx2 - 144;
    var _rny = _ry1 + 64;
    draw_text_color(_rnx, _rny, "rune modifiers", Color.Rune, Color.Rune, Color.Rune, Color.Rune, 1);
    var _modfs = [
        ["damage", GetRunesDamage(STAND)],
        ["critical chance", GetRunesCritChance(STAND)],
        ["reach", GetRunesStandReach(STAND)],
        ["extension", GetRunesExtension(STAND)],
        ["energy", GetRunesMaxEnergy(STAND)],
        ["healing", GetRunesHealing(STAND)],
    ];
    var _smodfs = [];
    var _ii = 0;
    for (var i = 0; i < array_length(_modfs); i++)
    {
        if (_modfs[i][1] > 1)
        {
            var _val = (_modfs[i][1] - 1) * 100;
            if (_val > 100) { _val = _modfs[i][1]; }
            draw_text(_rnx, _rny + 48 + (32 * _ii), _modfs[i][0] + ": " + string(_val) + "%");
            _ii++;
        }
    }
    
    draw_set_halign(fa_left);
    draw_text_color(_rx1 + 8, _ry2 - 32, "potential: " + string(STAND.development_potential * 100) + "%", Color.Potential, Color.Potential, Color.Potential, Color.Potential, 1);
    draw_set_halign(fa_right);
    var _total_power = (GetStandTotalPower(STAND) * 100);
    draw_text_color(_rx2 - 8, _ry2 - 40, "total power: " + string(_total_power) + "%", Color.Power, Color.Speed, Color.Range, Color.Stamina, 1);
    draw_text_color(_rx2 - 8, _ry2 - 16, "stat points: " + string(STAND.stat_points), c_white, c_white, c_white, c_white, 1);
    draw_set_halign(fa_left);
    
    var _stx = _cx;
    var _sty = _cy;
    //draw_sprite(global.sprStatsUI, 0, _stx, _sty);
    draw_circle_color(_stx, _sty, 224, STAND.color, 0x1a1117, false);
    draw_hexagon_stats(_stx, _sty, [
        [STAND.destructive_power, Color.Power],
        [STAND.development_potential, Color.Potential],
        [STAND.precision, Color.Precision],
        [STAND.stamina, Color.Stamina],
        [STAND.range, Color.Range],
        [STAND.spd, Color.Speed],
        [STAND.destructive_power, Color.Power]
    ]);
}
else
{
    draw_text(_cx, _cy, "no stand");
}

#define menu_storage_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
}

var _bs = draw_button_square(_rx2 - 128, _ry1, 128, 32, "stats");
if (_bs)
{
    global.jjMenuCurrent = "stats";
}

var _stx = _cx;
draw_text(_stx, _ry1 + 24, "stand storage:");

var _bLeft = draw_button_square(_stx - 320 - 32, _cy, 32, 32, "-");
var _bRight = draw_button_square(_stx + 320, _cy, 32, 32, "+");
var _bLeftPlus = draw_button_square(_stx - (320 + 64 + 32), _cy, 32, 32, "--");
var _bRightPlus = draw_button_square(_stx + (320 + 64), _cy, 32, 32, "++");

var _arr_len = array_length(global.jjStandSlots);

draw_text(_stx, _ry1 + 40, string(global.jjMenuMaxIndex) + "/" + string(_arr_len));

if (_bLeft)
{
    global.jjMenuMinIndex -= 8;
    global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
    global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
    global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
}
if (_bRight)
{
    global.jjMenuMinIndex += 8;
    global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
    global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
    global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
}
if (_bLeftPlus)
{
    global.jjMenuMinIndex -= 16;
    global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
    global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
    global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
}
if (_bRightPlus)
{
    global.jjMenuMinIndex += 16;
    global.jjMenuMaxIndex = global.jjMenuMinIndex + 8;
    global.jjMenuMinIndex = clamp(global.jjMenuMinIndex, 0, _arr_len - 8);
    global.jjMenuMaxIndex = clamp(global.jjMenuMaxIndex, 8, _arr_len);
}

for (var i = global.jjMenuMinIndex; i < global.jjMenuMaxIndex; i++)
{
    var _text = "text";
    var _cr1 = c_white;
    var _cr2 = c_white;
    if (global.jjStandSlots[i] == undefined)
    {
        _text = "";
    }
    else
    {
        if (is_array(global.jjMenuStorageNames[i]))
        {
            _text = string(global.jjMenuStorageNames[i][0]);
            _cr1 = real(global.jjMenuStorageNames[i][1]);
            _cr2 = real(global.jjMenuStorageNames[i][2]);
        }
        else
        {
            _text = string(global.jjMenuStorageNames[i]);
        }
    }
    
    var _b = draw_storage_button(_stx - 256, _ry1 + 48 + (58 * (i - global.jjMenuMinIndex)), 512, 48, string_lower(_text), _cr1, _cr2);
    if (_b)
    {
        if (global.jjStandSlots[i] == undefined and instance_exists(STAND))
        {
            if (STAND.rarity.tier != Rarity.WIP)
            {
                global.jjStandSlots[i] = ConstructStandData(STAND);
                global.jjMenuStorageNames[i] = [STAND.name, STAND.color, STAND.colorAlt];
                RemoveStand(player);
            }
        }
        else if (global.jjStandSlots[i] != undefined and !instance_exists(STAND))
        {
            var _standData = global.jjStandSlots[i];
            global.jjStandSlots[i] = undefined;
            global.jjMenuStorageNames[i] = undefined;
            DeconstructStandData(_standData);
        }
    }
}

#define menu_runes_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
    global.jjsMenuRuneDeleteMode = false;
}

var _be = draw_button_square(_rx2 - 160, _ry1, 160, 32, "delete mode");
if (_be)
{
    global.jjsMenuRuneDeleteMode = !global.jjsMenuRuneDeleteMode;
}

var _title = "rune storage";
draw_text(_cx, _ry1 + string_height(_title), _title);

var _bLeft = draw_button_square(_cx - 320 - 32, _cy + 32, 32, 32, "-");
var _bRight = draw_button_square(_cx + 320, _cy + 32, 32, 32, "+");
var _bLeftPlus = draw_button_square(_cx - (320 + 64 + 32), _cy + 32, 32, 32, "--");
var _bRightPlus = draw_button_square(_cx + (320 + 64), _cy + 32, 32, 32, "++");

var _arr_len = array_length(global.jjsRuneSlots);

draw_text(_cx, _ry1 + 40, string(global.jjsMenuRuneMaxIndex) + "/" + string(_arr_len));

var _mv1 = 16;
var _mv2 = 32;

if (_bLeft)
{
    global.jjsMenuRuneMinIndex -= _mv1;
    global.jjsMenuRuneMaxIndex = global.jjsMenuRuneMinIndex + _mv1;
    global.jjsMenuRuneMinIndex = clamp(global.jjsMenuRuneMinIndex, 0, _arr_len - _mv1);
    global.jjsMenuRuneMaxIndex = clamp(global.jjsMenuRuneMaxIndex, _mv1, _arr_len);
}
if (_bRight)
{
    global.jjsMenuRuneMinIndex += _mv1;
    global.jjsMenuRuneMaxIndex = global.jjsMenuRuneMinIndex + _mv1;
    global.jjsMenuRuneMinIndex = clamp(global.jjsMenuRuneMinIndex, 0, _arr_len - _mv1);
    global.jjsMenuRuneMaxIndex = clamp(global.jjsMenuRuneMaxIndex, _mv1, _arr_len);
}
if (_bLeftPlus)
{
    global.jjsMenuRuneMinIndex -= _mv2;
    global.jjsMenuRuneMaxIndex = global.jjsMenuRuneMinIndex + _mv1;
    global.jjsMenuRuneMinIndex = clamp(global.jjsMenuRuneMinIndex, 0, _arr_len - 8);
    global.jjsMenuRuneMaxIndex = clamp(global.jjsMenuRuneMaxIndex, _mv1, _arr_len);
}
if (_bRightPlus)
{
    global.jjsMenuRuneMinIndex += _mv2;
    global.jjsMenuRuneMaxIndex = global.jjsMenuRuneMinIndex + _mv1;
    global.jjsMenuRuneMinIndex = clamp(global.jjsMenuRuneMinIndex, 0, _arr_len - _mv1);
    global.jjsMenuRuneMaxIndex = clamp(global.jjsMenuRuneMaxIndex, _mv1, _arr_len);
}

for (var i = global.jjsMenuRuneMinIndex; i < global.jjsMenuRuneMaxIndex; i++)
{
    var _b = draw_button_rune(_cx - 192 + (96 * (i mod 4)), _cy - 128 + (96 * ((i - global.jjsMenuRuneMinIndex) div 4)), 64, 64, global.jjsRuneSlots[i]);
    if (_b)
    {
        if (global.jjsRuneSlots[i] != undefined)
        {
            var _success = RuneEquip(player, global.jjsRuneSlots[i]);
            if (_success) global.jjsRuneSlots[i] = undefined;
        }
    }
}

#define menu_variants_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
}

var _title = "variants";
draw_text(_cx, _ry1 + string_height(_title), _title);

if (instance_exists(STAND) and array_length(STAND.variants) > 0)
{
    var _vlen = array_length(STAND.variants);
    for (var i = 0; i < _vlen; i++)
    {
        var _xx = _cx + (i * 64) - (_vlen * 32);
        var _yy = _cy + 128;
        if (i == 0)
        {
            _xx = _cx;
            _yy = _cy - 128;
        }
        if (STAND.sprite_index == STAND.variants[i][0]) draw_sprite_ext(sprFairyAuraGlow, 0, _xx, _yy, 1, 1, current_time / 100, c_white, 1);
        draw_arrow(_cx, _cy - 128, _xx, _yy, 32);
        draw_sprite_ext(STAND.variants[i][0], 0, _xx, _yy, 2, 2, 0, c_white, 1);
        var _ss = random_range(1.4, 1.6);
        draw_sprite_ext(global.sprStarTier, 0, _xx, _yy - 40, _ss, _ss, 0, GetRarityColor(STAND.variants[i][1]), 1);
    }
}
else
{
    draw_text(_cx, _cy, "no data");
}

#define menu_evolutions_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjMenuCurrent = "main";
}

var _title = "evolution lines";
draw_text(_cx, _ry1 + string_height(_title), _title);

if (instance_exists(STAND))
{
    var _elen = array_length(STAND.evolutions);
    for (var i = 0; i < _elen; i++)
    {
        var _dis = 192;
        var _dir = (i * (360 / _elen));
        var _ax = _cx + lengthdir_x(_dis * 0.9, _dir);
        var _ay = _cy + 32 + lengthdir_y(_dis * 0.9, _dir);
        draw_arrow(_cx, _cy + 32, _ax, _ay, 32);
        var _xx = _cx + lengthdir_x(_dis, _dir);
        var _yy = _cy + 32 + lengthdir_y(_dis, _dir);
        draw_sprite_ext(STAND.evolutions[i][0], 0, _xx, _yy, 2, 2, 0, c_white, 1);
        var _ex = _cx + lengthdir_x(_dis * 0.5, _dir);
        var _ey = _cy + 32 + lengthdir_y(_dis * 0.5, _dir);
        var _condition = STAND.evolutions[i][1];
        if (is_string(_condition))
        {
            draw_text(_ex, _ey - 12, _condition);
        }
        else if (is_array(_condition))
        {
            var _clen = array_length(_condition);
            for (var j = 0; j < _clen; j++)
            {
                draw_sprite_ext(_condition[j], 0, _ex + (j * 24) - (_clen * 8), _ey - 12, 2, 2, 0, c_white, 1);
            }
        }
        else
        {
            draw_sprite_ext(_condition, 0, _ex, _ey - 12, 2, 2, 0, c_white, 1);
        }
        var _ss = random_range(1.4, 1.6);
        draw_sprite_ext(global.sprStarTier, 0, _xx, _yy - 40, _ss, _ss, 0, GetRarityColor(STAND.evolutions[i][2]), 1);
    }
    draw_sprite_ext(STAND.sprite_index, 0, _cx, _cy + 32, 2, 2, 0, c_white, 1);
    if (_elen == 0)
    {
        draw_text(_cx, _cy, "no evolutions available");
    }
}
else
{
    draw_text(_cx, _cy, "no stand");
}

#define menu_settings_draw(_cx, _cy)

var _rx1 = _cx - 512;
var _ry1 = _cy - 256;
var _rx2 = _cx + 512;
var _ry2 = _cy + 256;

var _title = "settings";
draw_text(_cx, _ry1 + string_height(_title), _title);

var _options = ["graphics", "audio", "controls", "debug"];
var _olen = array_length(_options);

for (var i = 0; i < _olen; i++)
{
    var _b = draw_button_square(_rx1 + (146 * (i mod 7)), _ry2 - 32 + (42 * (i div 7)) - (42 * (_olen div 8)), 138, 32, _options[i]);
    if (_b)
    {
        global.jjsMenuWaitingInput = undefined;
        global.jjMenuSubCurrent = _options[i];
    }
}

var _bb = draw_button_square(_rx1, _ry1, 128, 32, "back");
if (_bb)
{
    global.jjsMenuWaitingInput = undefined;
    global.jjMenuCurrent = "main";
    global.jjMenuSubCurrent = "default";
}

switch (global.jjMenuSubCurrent)
{
    case "graphics":
        var _ga = draw_slider(_cx - 64, _cy - 128 + (48 * 0), 128, 32, "gui visibility " + string(round(global.jjsSettGuiVisibility * 100)) + "%", global.jjsSettGuiVisibility);
        if (_ga != undefined)
        {
            global.jjsSettGuiVisibility = _ga;
        }
        
        var _bc = draw_checkbox(_cx + 64, _cy - 128 + (48 * 1), 32, "background stand colors", global.jjsSettBackgroundStandColors);
        if (_bc != undefined)
        {
            global.jjsSettBackgroundStandColors = _bc;
        }
        
        var _cs = draw_checkbox(_cx + 64, _cy - 128 + (48 * 2), 32, "attack shadows", global.jjSettProjShadows);
        if (_cs != undefined)
        {
            global.jjSettProjShadows = _cs;
        }
        
        var _clp = draw_checkbox(_cx + 64, _cy - 128 + (48 * 3), 32, "level up particle", global.jjsSettLevelUpParticle);
        if (_clp != undefined)
        {
            global.jjsSettLevelUpParticle = _clp;
        }
        
        var _cer = draw_checkbox(_cx + 64, _cy - 128 + (48 * 4), 32, "display empty runes", global.jjsSettDisplayEmptyRunes);
        if (_cer != undefined)
        {
            global.jjsSettDisplayEmptyRunes = _cer;
        }
        
        var _cer = draw_checkbox(_cx + 64, _cy - 128 + (48 * 5), 32, "show stand aura", global.jjsSettShowStandAura);
        if (_cer != undefined)
        {
            global.jjsSettShowStandAura = _cer;
        }
    break;
    case "audio":
        var _sv = draw_slider(_cx - 64, _cy - 32 + (48 * 0), 128, 32, "volume " + string(round(global.jjSettAudioVolume * 100)) + "%", global.jjSettAudioVolume);
        if (_sv != undefined)
        {
            global.jjSettAudioVolume = _sv;
            var _snd = global.sndMenuClick;
            if (!global.jjsSettCustomModMenuSounds) _snd = sndUiSelect;
            var _s = audio_play_sound(_snd, 0, false);
            audio_sound_gain(_s, global.jjSettAudioVolume, 0);
        }
        
        var _ct = draw_checkbox(_cx + 64, _cy - 32 + (48 * 1), 32, "stand talk when idle", global.jjSettStandTalkIdle);
        if (_ct != undefined)
        {
            global.jjSettStandTalkIdle = _ct;
        }
        
        var _cls = draw_checkbox(_cx + 64, _cy - 32 + (48 * 2), 32, "level up sound", global.jjsSettLevelUpSound);
        if (_cls != undefined)
        {
            global.jjsSettLevelUpSound = _cls;
        }
        
        var _cms = draw_checkbox(_cx + 64, _cy - 32 + (48 * 3), 32, "custom mod menu sounds", global.jjsSettCustomModMenuSounds);
        if (_cms != undefined)
        {
            global.jjsSettCustomModMenuSounds = _cms;
        }
    break;
    case "controls":
        if (global.jjsMenuWaitingInput != undefined)
        {
            draw_text_color(_cx, _ry1 + 64, "waiting for input!", c_yellow, c_yellow, c_white, c_white, 1);
        }
        if (instance_exists(player) and instance_exists(STAND))
        {
            var _kbs = draw_keybind(_cx + 64, _cy - 160 + (48 * 0), 32, 32, "summon / dismiss stand", player.summonKeybind);
            if (_kbs != false)
            {
                player.summonKeybind = _kbs;
                StandUpdateKeybinds();
            }
            var _kba1 = draw_keybind(_cx + 64, _cy - 160 + (48 * 1), 32, 32, "stand ability 1", player.abilityKeybind1);
            if (_kba1 != false)
            {
                player.abilityKeybind1 = _kba1;
                StandUpdateKeybinds();
            }
            var _kba2 = draw_keybind(_cx + 64, _cy - 160 + (48 * 2), 32, 32, "stand ability 2", player.abilityKeybind2);
            if (_kba2 != false)
            {
                player.abilityKeybind2 = _kba2;
                StandUpdateKeybinds();
            }
            var _kba3 = draw_keybind(_cx + 64, _cy - 160 + (48 * 3), 32, 32, "stand ability 3", player.abilityKeybind3);
            if (_kba3 != false)
            {
                player.abilityKeybind3 = _kba3;
                StandUpdateKeybinds();
            }
            var _kba4 = draw_keybind(_cx + 64, _cy - 160 + (48 * 4), 32, 32, "stand ability 4", player.abilityKeybind4);
            if (_kba4 != false)
            {
                player.abilityKeybind4 = _kba4;
                StandUpdateKeybinds();
            }
            var _kbs1 = draw_keybind(_cx + 64, _cy - 160 + (48 * 5), 32, 32, "specialization ability 1", player.specKeybind1);
            if (_kbs1 != false)
            {
                player.specKeybind1 = _kbs1;
            }
            var _kbs2 = draw_keybind(_cx + 64, _cy - 160 + (48 * 6), 32, 32, "specialization ability 2", player.specKeybind2);
            if (_kbs2 != false)
            {
                player.specKeybind2 = _kbs2;
            }
        }
    break;
    case "debug":
        var _cc = draw_checkbox(_cx - 224, _cy - 32 + (48 * 0), 32, "attack collisions", global.jjSettProjCollisions);
        if (_cc != undefined)
        {
            global.jjSettProjCollisions = _cc;
        }
        
        var _wipt = "work in progress stands,\nwon't override current normal stand\nand cannot be stored.";
        draw_text(_cx + 256, _ry1 + 16 + string_height(_wipt), _wipt);
        
        var _rmv = draw_button_square(_cx + 256, _cy - 112 + (48 * 0), 192, 32, "-remove-");
        if (_rmv)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
            }
        }
        var _wip1 = draw_button_square(_cx + 256, _cy - 112 + (48 * 1), 192, 32, "weather report");
        if (_wip1)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveWeatherReport(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
        var _wip2 = draw_button_square(_cx + 256, _cy - 112 + (48 * 2), 192, 32, "crazy diamond");
        if (_wip2)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveCrazyDiamond(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
        var _wip3 = draw_button_square(_cx + 256, _cy - 112 + (48 * 3), 192, 32, "c-moon");
        if (_wip3)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveCMoon(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
        var _wip4 = draw_button_square(_cx + 256, _cy - 112 + (48 * 4), 192, 32, "tusk");
        if (_wip4)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveTusk(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
        var _wip5 = draw_button_square(_cx + 256, _cy - 112 + (48 * 5), 192, 32, "magician's red");
        if (_wip5)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveMagiciansRed(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
        var _wip6 = draw_button_square(_cx + 256, _cy - 112 + (48 * 6), 192, 32, "heaven's door");
        if (_wip6)
        {
            if (room == rmGame)
            {
                if (instance_exists(STAND))
                {
                    if (STAND.rarity.tier == Rarity.WIP) RemoveStand(player);
                }
                if (!instance_exists(STAND))
                {
                    GiveHeavensDoor(player);
                    with (STAND) UpdateRarity(Rarity.WIP);
                }
            }
        }
    break;
}


