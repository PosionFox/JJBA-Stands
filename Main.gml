
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
    if !bool("skCustomStands" in player)
    {
        player.skCustomStands = false;
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
global.jjStandSlots = array_create(512, undefined);
global.timeIsFrozen = false;    // unused
global.jjNewGame = false;
// mod menu
global.jjShowMenu = false;
global.jjMenuCurrent = "main";
global.jjMenuSubCurrent = "default";
global.jjMenuHover = undefined;
global.jjMenuStorageSlots = undefined;
global.jjMenuStorageNames = undefined;
global.jjMenuMinIndex = 0;
global.jjMenuMaxIndex = 8;
// settings
global.jjSettAudioVolume = 1.0;
global.jjSettProjShadows = true;
global.jjSettProjCollisions = false;

localizationEnglish();
localizationSpanish();
loadSprites();
loadSounds();
loadItems();
Runes();
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

