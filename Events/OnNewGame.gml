
#define OnNewGame

global.jjNewGame = true;
InitPlayerVariables();
if instance_exists(STAND) init_trait(STAND);
GiveRandomStand();
