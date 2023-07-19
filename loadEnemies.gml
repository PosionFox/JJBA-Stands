
global.enemyDio = EnemyCreate(
    undefined,
    "DIO",
    EnemyType.Base,
    2,
    10000,
    400,
    500,
    16,
    32,
    ScriptWrap(EnemyDioInit)
);

#define EnemyDioInit

sprIdle = global.sprTheWorld;
sprWalk = global.sprAnubis;
audio_play_sound(global.sndDioSpawn, 5, false);
