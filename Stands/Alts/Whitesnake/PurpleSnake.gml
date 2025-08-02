
#define GivePurpleSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "PurpleSnake"
    sprite_index = global.sprPurpleSnake;
    color = Color.Purple;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Epic);
    saveKey = "jjPurpleSnake";
}
return _s;
