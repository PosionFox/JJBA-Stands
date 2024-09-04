
#define GiveBlueSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "BlueSnake"
    sprite_index = global.sprBlueSnake;
    color = 0xe16e5b;
    UpdateRarity(Rarity.Rare);
    saveKey = "jjBlueSnake";
}
return _s;
