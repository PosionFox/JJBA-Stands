
#define GiveOrangeSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "OrangeSnake"
    sprite_index = global.sprGreenSnake;
    color = 0x2671df;
    UpdateRarity(Rarity.Ascended);
    saveKey = "jjOrangeSnake";
}
return _s;
