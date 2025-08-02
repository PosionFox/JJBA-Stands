
#define GiveYellowSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "YellowSnake"
    sprite_index = global.sprYellowSnake;
    color = Color.Yellow;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjYellowSnake";
}
return _s;
