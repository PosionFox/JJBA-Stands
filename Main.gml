
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
}

#define newClass(class)

return array_clone(class);

#define printVersion

Trace("jjbas v0.6.0b");

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




