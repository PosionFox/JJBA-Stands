
#define OnStructureInteract(type, structure, inst)

if (structure == global.jjsStandWorkshop)
{
    if ("myStand" in player)
    {
        if (instance_exists(player))
        {
            OpenStandWorkshop();
        }
    }
}
