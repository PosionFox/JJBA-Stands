
global.jjsModGrimoiresID = ModFind("Grimoires");
if (global.jjsModGrimoiresID == -1)
{
    Trace("grimoires not found...");
    exit;
}

Trace("grimoires found...");

global.jjsLecturn = ModGlobalGet(global.jjsModGrimoiresID, "Lecturn");

global.sprDioGrimoire = sprite_add("CrossModding/Grimoires/DioGrimoire.png", 1, false, false, 6, 8);

global.jjsDioSpawnGrimoire = ItemCreate(
    undefined,
    "jjsDioSpawnGrimoire",
    "",
    global.sprDioGrimoire,
    ItemType.Consumable,
    ItemSubType.None,
    1000,
    0,
    0,
    [
        Item.RoyalClothing, 5,
        global.jjsEgyptianCrown, 3,
        Item.StarFragment, 10
    ],
    ScriptWrap(DioGrimoireUse),
    60 * 15,
    true
);
ItemEdit(global.jjsDioSpawnGrimoire, ItemData.Name, tr("dioGrimoireName"));
ItemEdit(global.jjsDioSpawnGrimoire, ItemData.Description, tr("dioGrimoireDescription"));

StructureAddItem(global.jjsLecturn, global.jjsDioSpawnGrimoire);

#define DioGrimoireUse

GainItem(global.jjsDioSpawnGrimoire);
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
else
{
    Trace("dio cannot spawn on daytime.");
}
