
#define OnStep

if (instance_exists(player))
{
    with (player)
    {
        attack_direction = point_direction(x, y, mouse_x, mouse_y);
    }
    
    if (bool("myStand" in player) and instance_exists(player.myStand))
    {
        player.myStand.look_x = mouse_x;
        player.myStand.look_y = mouse_y;
        RunRunesUpdate(STAND);
        RunRunesHealing(player, STAND);
    }
    
    if (keyboard_check_pressed(ord("M")))
    {
        global.jjShowMenu = !global.jjShowMenu;
        if (global.jjShowMenu)
        {
            jj_play_audio(global.sndMenuOpen, 5, false);
            if (global.jjNewGame)
            {
                global.jjMenuCurrent = "info";
                global.jjMenuSubCurrent = "default";
                global.jjNewGame = false;
            }
        }
        else
        {
            global.jjsMenuRuneDeleteMode = false;
        }
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
