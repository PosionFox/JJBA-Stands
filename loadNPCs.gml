
global.npcPucci = NPCCreate(undefined, "Pucci");
global.pucciSpawned = false;
global.pucciSpawnX = undefined;
global.pucciSpawnY = undefined;
global.pucciRef = noone;

global.questPucciBlueprintCompleted = false;
NPCQuestCreate(global.npcPucci, "PucciQuestBlueprint");
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "FetchBones",
    [tr("questPucci1Talk1"), tr("questPucci1Talk2")],
    "PucciReward", undefined, undefined
);
NPCQuestAddState(global.npcPucci, "PucciQuestBlueprint", "PucciReward",
    [tr("questPucci1Talk3"), tr("questPucci1Talk4")],
    undefined, [Item.Bone, 24], undefined
);

NPCQuestCreate(global.npcPucci, "PucciQuestDiscs");
NPCQuestAddState(global.npcPucci, "PucciQuestDiscs", "FetchBones",
    [tr("questPucci2Talk1"), tr("questPucci2Talk2")],
    "PucciReward", undefined, undefined
);
NPCQuestAddState(global.npcPucci, "PucciQuestDiscs", "PucciReward",
    [tr("questPucci2Talk3"), tr("questPucci2Talk4")],
    undefined, [Item.Bone, 100], undefined
);

#define QuestPucciBlueprintComplete

DropItem(x, y, global.jjsRuneBundle, 1);
DropItem(x, y, global.jjsDiscBlueprint, 1);
repeat (10) { FireEffect(c_white, c_purple); }
DespawnPucci();

#define QuestPucciDiscsComplete

var _pool = [
    [global.jjsBlankDisc, 3],
    [global.jjsRuneBundle, 2],
    //[global.jjsWeatherReportDisc, 1]
];
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
    hp = 100;
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
    color = 0xfcdbcb;
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

#define LoadNPCs(_map)

// enrico pucci
global.pucciSpawned = _map[? "jjsPucciSpawned"];
global.pucciSpawnX = _map[? "jjsPucciX"];
global.pucciSpawnY = _map[? "jjsPucciY"];
if (room == rmGame and global.pucciSpawned)
{
    SpawnPucci(global.pucciSpawnX, global.pucciSpawnY);
}
