
#define GiveGreenSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "GreenSnake"
    sprite_index = global.sprGreenSnake;
    color = 0x30be6a;
    UpdateRarity(Rarity.Uncommon);
    saveKey = "jjGreenSnake";
}
return _s;
