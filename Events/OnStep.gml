
#define OnStep
// destroy spriteless npcs
if (instance_exists(MNPC))
{
    with (MNPC)
    {
        if (sprite_index == -1)
        {
            //sprite_index = sprSmoke;
            instance_destroy(self);
        }
    }
}
