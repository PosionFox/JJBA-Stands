
global.npcPucci = NPCCreate(undefined, "Pucci");
global.pucciSpawned = false;
global.pucciRef = noone;

global.questPucciBlueprintCompleted = false;
NPCQuestCreate(global.npcPucci, "PucciQuestBlueprint");
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "FetchBones",
    ["i came here for research purposes", "i need you to collect something for me"],
    "PucciReward", undefined, undefined
);
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "PucciReward",
    ["good job", "take this, i don't need it anymore"],
    undefined, [Item.Bone, 24], undefined
);

NPCQuestCreate(global.npcPucci, "PucciQuestDiscs");
NPCQuestAddState(global.npcPucci, "PucciQuestDiscs", "FetchBones",
    ["i'm back", "i need more samples"],
    "PucciReward", undefined, undefined
);
NPCQuestAddState(global.npcPucci, "PucciQuestDiscs", "PucciReward",
    ["well done", "here's your reward"],
    undefined, [Item.Bone, 100], undefined
);

#define QuestPucciBlueprintComplete

DropItem(x, y, global.jjDiscBlueprint, 1);
repeat (10) { FireEffect(c_white, c_purple); }
DespawnPucci();

#define QuestPucciDiscsComplete

var _p = [
    global.jjbamDiscSp,
    global.jjbamDiscStw,
    global.jjbamDiscKq,
    global.jjbamDiscSf,
    global.jjbamDiscGe,
];
repeat (2)
{
    var _c = irandom(array_length(_p) - 1);
    DropItem(x, y, _p[_c], 1);
}
DropItem(x, y, global.jjbamDisc, 1);
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
    
    if (global.questPucciBlueprintCompleted == false)
    {
        NPCSetQuest("PucciQuestBlueprint");
        NPCSetState("FetchBones");
        NPC2QuestControllerCreate(self, "PucciReward", ScriptWrap(QuestPucciBlueprintComplete));
    }
    else
    {
        NPCSetQuest("PucciQuestDiscs");
        NPCSetState("FetchBones");
        NPC2QuestControllerCreate(self, "PucciReward", ScriptWrap(QuestPucciDiscsComplete));
    }
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

