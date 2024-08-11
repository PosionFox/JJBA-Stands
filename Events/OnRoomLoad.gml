
#define OnRoomLoad

switch (room)
{
    case rmSkillGrid:
        //SkillStandWorkshop();
    break;
    case rmGame:
        //SpawnPucci(room_width/2, room_height/2);
    break;
}

if (room != rmGame)
{
    if (instance_exists(player))
    {
        InitPlayerVariables();
        if instance_exists(STAND) init_trait(STAND);
        //var _map = ModSaveDataFetch();
        //LoadStand(_map);
        LoadData();
    }
}


