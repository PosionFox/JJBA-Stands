
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
}

#define newClass(class)

return array_clone(class);

#define load_seasonals

Christmas();

#define get_steam_mod_version

var params = "itemcount=1&publishedfileids[0]=2597172322";
global.jjHTTPPost = http_post_string("https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/", params);

#define Main

global.jjVersion = "0.7.0";
global.jjHTTPPost = undefined;
global.jjSteamVersion = undefined;
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
global.jjsMenuRuneMaxIndex = 8;
// settings
global.jjSettAudioVolume = 1.0;
global.jjSettStandTalkIdle = true;
global.jjSettProjShadows = true;
global.jjSettProjCollisions = false;
global.jjsSettLevelUpSound = true;
global.jjsSettLevelUpParticle = true;
global.jjsSettCustomModMenuSounds = true;
global.jjsSettDisplayEmptyRunes = true;

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


