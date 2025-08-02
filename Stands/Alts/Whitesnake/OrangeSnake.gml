
#define GiveOrangeSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "OrangeSnake"
    sprite_index = global.sprOrangeSnake;
    color = Color.Orange;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Celestial);
    saveKey = "jjOrangeSnake";
}
return _s;
