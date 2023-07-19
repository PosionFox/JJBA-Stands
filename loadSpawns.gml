
global.spawnDio = SpawnCreate(undefined, SpawnType.Enemy, global.enemyDio, ScriptWrap(SpawnDioEligible));


#define SpawnDioEligible

#define SpawnDio

var _snapshotGrid = ResourceSnapshot();
ResourceSpawn(_snapshotGrid, global.spawnDio);
ds_grid_destroy(_snapshotGrid);
