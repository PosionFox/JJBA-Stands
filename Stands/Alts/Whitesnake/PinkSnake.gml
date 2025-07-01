
#define GivePinkSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "PinkSnake"
    sprite_index = global.sprPinkSnake;
    color = 0xba7bd7;
    colorAlt = c_dkgray;
    UpdateRarity(Rarity.Ultimate);
    saveKey = "jjPinkSnake";
}
return _s;
