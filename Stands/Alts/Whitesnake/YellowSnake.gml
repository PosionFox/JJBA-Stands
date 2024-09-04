
#define GiveYellowSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "YellowSnake"
    sprite_index = global.sprYellowSnake;
    color = 0x36f2fb;
    UpdateRarity(Rarity.Legendary);
    saveKey = "jjYellowSnake";
}
return _s;
