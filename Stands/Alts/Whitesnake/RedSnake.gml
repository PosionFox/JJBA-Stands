
#define GiveRedSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "RedSnake"
    sprite_index = global.sprRedSnake;
    color = Color.Red;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjRedSnake";
}
return _s;
