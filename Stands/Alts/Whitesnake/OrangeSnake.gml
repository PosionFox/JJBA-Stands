
#define GiveOrangeSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "OrangeSnake"
    sprite_index = global.sprOrangeSnake;
    color = 0x2671df;
    colorAlt = c_dkgray;
    UpdateRarity(Rarity.Celestial);
    saveKey = "jjOrangeSnake";
}
return _s;
