
#define OnStep
// destroy spriteless npcs
if (instance_exists(MNPC))
{
    with (MNPC)
    {
        if (npc == noone)
        {
            //sprite_index = sprSmoke;
            instance_destroy(self);
        }
    }
}
