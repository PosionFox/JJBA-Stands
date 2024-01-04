
#define OnLoad

InitPlayerVariables();
init_player_traits();
LoadData();

// grimoires boss fix
if (room == rmGame)
{
    grimoiresID = ModFind("Grimoires");
    if (grimoiresID != -1)
    {
        if (HasSkill(Skill.Summoning))
        {
            var _lecturn = ModGlobalGet(grimoiresID, "Lecturn");
            var _grimSlime = ModGlobalGet(grimoiresID, "SlimeGrimoire");
            var _grimSkull = ModGlobalGet(grimoiresID, "SkullGrimoire");
            var _grimBeet = ModGlobalGet(grimoiresID, "BeetGrimoire");
            var _grimToxic = ModGlobalGet(grimoiresID, "ToxicGrimoire");
            if (!StructureHasItem(_lecturn, _grimSlime)) StructureAddItem(_lecturn, _grimSlime);
            if (!StructureHasItem(_lecturn, _grimSkull)) StructureAddItem(_lecturn, _grimSkull);
            if (!StructureHasItem(_lecturn, _grimBeet)) StructureAddItem(_lecturn, _grimBeet);
            if (!StructureHasItem(_lecturn, _grimToxic)) StructureAddItem(_lecturn, _grimToxic);
        }
    }
}