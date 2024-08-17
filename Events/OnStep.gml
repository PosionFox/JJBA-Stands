
#define OnStep

if (instance_exists(player))
{
    with (player)
    {
        attack_direction = point_direction(x, y, mouse_x, mouse_y);
    }
    
    if (bool("myStand" in player) and instance_exists(player.myStand))
    {
        RunRunesUpdate(STAND);
        RunRunesHealing(player, STAND);
    }
    
    if (keyboard_check_pressed(ord("M")))
    {
        global.jjShowMenu = !global.jjShowMenu;
    }
    if (keyboard_check_pressed(vk_escape))
    {
        global.jjShowMenu = false;
    }
}

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
