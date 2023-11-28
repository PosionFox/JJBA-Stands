
global.jjModGrimoiresID = ModFind("Grimoires");
if (global.jjModGrimoiresID == -1)
{
    Trace("grimoires not found...");
    exit;
}

Trace("grimoires found...");

global.jjLecturn = ModGlobalGet(global.jjModGrimoiresID, "Lecturn");

global.sprDioGrimoire = sprite_add("CrossModding/Grimoires/DioGrimoire.png", 1, false, false, 6, 8);
global.jjDioSpawnGrimoire = ItemCreate(
    undefined,
    Localize("dioGrimoireName"),
    Localize("dioGrimoireDescription"),
    global.sprDioGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    1000,
    0,
    0,
    [
        Item.RoyalClothing, 5,
        global.jjEgyptianCrown, 3,
        Item.StarFragment, 10
    ],
    ScriptWrap(DioGrimoireUse),
    60 * 15,
    true
);

StructureAddItem(global.jjLecturn, global.jjDioSpawnGrimoire);

#define DioGrimoireUse

GainItem(global.jjDioSpawnGrimoire);
if (TimeControl.lightState == 0 or TimeControl.lightState == 3)
{
    if (modSubtypeExists("DIO"))
    {
        exit;
    }
    else
    {
        EnemyDioSpawn();
    }
}
