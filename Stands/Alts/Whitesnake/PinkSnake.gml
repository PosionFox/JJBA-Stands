
#define GivePinkSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "PinkSnake"
    sprite_index = global.sprPinkSnake;
    color = Color.Pink;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Ultimate);
    saveKey = "jjPinkSnake";
}
return _s;
