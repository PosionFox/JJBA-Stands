
#define EventHandler



#define InitPlayerVariables

if (instance_exists(player))
{
    if !("myStand" in player)
    {
        STAND = noone;
    }
    if !("skCustomStands" in player)
    {
        player.skCustomStands = false;
    }
    if !bool("summonKeybind" in player) { player.summonKeybind = "Q" }
    if !bool("abilityKeybind1" in player) { player.abilityKeybind1 = "R" }
    if !bool("abilityKeybind2" in player) { player.abilityKeybind2 = "F" }
    if !bool("abilityKeybind3" in player) { player.abilityKeybind3 = "C" }
    if !bool("abilityKeybind4" in player) { player.abilityKeybind4 = "G" }
}

#define newClass(class)

return array_clone(class);

#define printVersion

Trace("jjbas v0.6.0");

#define Main

printVersion();

global.timeIsFrozen = false;

loadSprites();
loadSounds();
loadItems();
loadStands();
loadStructures();
loadNPCs();
loadCommands();




