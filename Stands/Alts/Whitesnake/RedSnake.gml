
#define GiveRedSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "RedSnake"
    sprite_index = global.sprRedSnake;
    color = 0x3232ac;
    colorAlt = c_dkgray;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjRedSnake";
}
return _s;
