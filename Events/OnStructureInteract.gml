
#define OnStructureInteract(type, structure, inst)

if (structure == global.jjsStandWorkshop)
{
    if (instance_exists(player) and instance_exists(STAND))
    {
        OpenStandWorkshop();
    }
    else
    {
        Trace("the structure refuses to interact with you.");
    }
}
