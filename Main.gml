
#define EventHandler



#define InitPlayerVariables

if (instance_exists(player))
{
    if !bool("myStand" in player)
    {
        player.myStand = noone;
    }
    if (!bool("spec" in player))
    {
        player.spec = noone;
    }
    if !bool("summonKeybind" in player) { player.summonKeybind = "Q" }
    if !bool("abilityKeybind1" in player) { player.abilityKeybind1 = "R" }
    if !bool("abilityKeybind2" in player) { player.abilityKeybind2 = "F" }
    if !bool("abilityKeybind3" in player) { player.abilityKeybind3 = "C" }
    if !bool("abilityKeybind4" in player) { player.abilityKeybind4 = "G" }
    
    if !bool("specKeybind1" in player) { player.specKeybind1 = "V" }
    if !bool("specKeybind2" in player) { player.specKeybind2 = "B" }
    
    // controller
    InputReassign(Input.A, 0, gp_face1, "gamepad");
    InputReassign(Input.B, 0, gp_face2, "gamepad");
    InputReassign(Input.X, 0, gp_face3, "gamepad");
    InputReassign(Input.Y, 0, gp_face4, "gamepad");
    InputReassign(Input.Interact, 0, gp_face1, "gamepad");
    InputReassign(Input.Menu, 0, gp_face2, "gamepad");
    if !bool("standModeKeymap" in player) { player.standModeKeymap = gp_select }
    if !bool("altModeKeymap" in player) { player.altModeKeymap = gp_shoulderlb }
    if !bool("summonKeymap" in player) { player.summonKeymap = gp_stickl }
    if !bool("lockonKeymap" in player) { player.lockonKeymap = gp_stickr }
    if !bool("abilityKeymap1" in player) { player.abilityKeymap1 = gp_face1 }
    if !bool("abilityKeymap2" in player) { player.abilityKeymap2 = gp_face2 }
    if !bool("abilityKeymap3" in player) { player.abilityKeymap3 = gp_face3 }
    if !bool("abilityKeymap4" in player) { player.abilityKeymap4 = gp_face4 }
}

#define newClass(class)

return array_clone(class);

#define load_seasonals

Christmas();

#define get_steam_mod_version

var params = "itemcount=1&publishedfileids[0]=2597172322";
global.jjsSteamVersionHTTP = http_post_string("https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/", params);

#define get_mod_changelog

global.jjsModChangelogHTTP = http_get("https://raw.githubusercontent.com/PosionFox/JJBA-Stands/v0.7.0/changelog.txt");

#define Main

global.jjVersion = "0.7.0";
global.jjsSteamVersionHTTP = undefined;
global.jjsModChangelogHTTP = undefined;
global.jjSteamVersion = undefined;
global.jjsModChangelog = undefined;
global.jjsModChangelogSurf = -1;
global.jjsModChangelogScroll = 0;
global.jjsStandStorageVersion = 2;
global.jjStandSlots = array_create(512, undefined); // stand storage
global.timeIsFrozen = false;    // unused
global.jjNewGame = false;

global.jjsStandWorkshopVersion = 1;
global.jjsStandWorkshopUnlocked = false;
global.jjsStandWorkshopStorage = array_create(64, undefined);

#region mod menu

global.jjShowMenu = false;
global.jjMenuCurrent = "main";
global.jjMenuSubCurrent = "default";
global.jjMenuHover = undefined;
global.jjsMenuWaitingInput = undefined;
// storage
global.jjMenuStorageSlots = undefined; // unused?
global.jjMenuStorageNames = array_create(512, undefined);
global.jjMenuMinIndex = 0;
global.jjMenuMaxIndex = 8;
// rune storage
global.jjsMenuRuneDeleteMode = false;
global.jjsMenuRuneMinIndex = 0;
global.jjsMenuRuneMaxIndex = 16;
// settings
global.jjSettAudioVolume = 1.0;
global.jjSettStandTalkIdle = true;
global.jjSettProjShadows = true;
global.jjSettProjCollisions = false;
global.jjsSettLevelUpSound = true;
global.jjsSettLevelUpParticle = true;
global.jjsSettCustomModMenuSounds = true;
global.jjsSettDisplayEmptyRunes = true;
global.jjsSettShowStandAura = true;
global.jjsSettGuiVisibility = 1;
global.jjsSettBackgroundStandColors = false;

#endregion

global.ordinary_rarity_weight = 16;
global.tragic_rarity_weight = 64;
global.common_rarity_weight = 256;
global.uncommon_rarity_weight = 128;
global.rare_rarity_weight = 64;
global.epic_rarity_weight = 32;
global.legendary_rarity_weight = 16;
global.mythical_rarity_weight = 8;
global.celestial_rarity_weight = 4;
global.ultimate_rarity_weight = 2;
global.bizarre_rarity_weight = 1;

json_lib();
localization_core();
loadSprites();
cosmetics();
loadSounds();
loadItems();
RunesCore();
Shards();
loadEnemies();
loadSpawns();
loadStands();
loadStructures();
LoadGear();
loadNPCs();
load_seasonals();
loadCommands();
LoadOtherMods();

get_steam_mod_version();
get_mod_changelog();

