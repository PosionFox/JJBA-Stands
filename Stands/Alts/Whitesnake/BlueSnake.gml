
#define GiveBlueSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "BlueSnake"
    sprite_index = global.sprBlueSnake;
    color = Color.Blue;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Rare);
    saveKey = "jjBlueSnake";
}
return _s;
