
global.npcPucci = NPCCreate(undefined, "Pucci");
global.pucciSpawned = false;
global.pucciRef = noone;

NPCQuestCreate(global.npcPucci, "PucciQuestBlueprint");
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "FetchBones",
    ["i came here for research purposes", "i need you to collect something for me"],
    "PucciReward", undefined, undefined
);
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "PucciReward",
    ["good job", "takes this, i don't need it anymore"],
    undefined, [Item.Bone, 12], undefined
);

#define QuestPucciComplete

DropItem(x, y, global.jjDiscBlueprint, 1);
repeat (10) { FireEffect(c_white, c_purple); }
DespawnPucci();

#define SpawnPucci(_x, _y)

if (!is_number(_x)) { _x = room_width / 2; }
if (!is_number(_y)) { _y = room_height / 2; }

var o = ModNPCSpawn(_x, _y, 0, global.npcPucci);
with (o)
{
    repeat (10) { FireEffect(c_white, c_purple); }
    type = "npc";
    subtype = "pucci";
    sprite_index = global.sprEnricoPucci;
    image_speed = 0.35;
    NPCSetQuest("PucciQuestBlueprint");
    NPCSetState("FetchBones");
    
    NPC2QuestControllerCreate(self, "PucciReward", ScriptWrap(QuestPucciComplete));
}
var _skills = StandSkillInit();
var _stand = StandBuilder(o, _skills);
with (_stand)
{
    sprite_index = global.sprWhiteSnake;
    color = /*#*/0xfcdbcb;
    summonMethod = EventHandler;
    active = true;
    runDrawGUI = false;
}

global.pucciSpawned = true;
global.pucciRef = o;

#define DespawnPucci

RemoveStand(global.pucciRef);
instance_destroy(global.pucciRef);
global.pucciSpawned = false;
global.pucciRef = noone;


