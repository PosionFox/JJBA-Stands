
#define GiveRedSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "RedSnake"
    sprite_index = global.sprRedSnake;
    color = 0x3232ac;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjRedSnake";
}
return _s;
