
#define OnStructureInteract(type, structure, inst)

if (structure == global.jjbamStandWorkshop)
{
    if ("myStand" in player)
    {
        if (instance_exists(player))
        {
            OpenStandWorkshop();
        }
    }
}
