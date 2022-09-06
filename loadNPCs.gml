
global.npcPucci = NPCCreate(undefined, "Pucci");
global.pucciSpawned = false;
global.pucciRef = noone;


#define SpawnPucci(_x, _y)

var o = ModNPCSpawn(_x, _y, 0, global.npcPucci);
with (o)
{
    sprite_index = global.sprKingCrimson;
    type = "pucci";
}
global.pucciSpawned = true;
global.pucciRef = o;

#define DespawnPucci

instance_destroy(global.pucciRef);
global.pucciSpawned = false;
global.pucciRef = noone;
