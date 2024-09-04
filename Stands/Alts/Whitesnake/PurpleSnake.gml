
#define GivePurpleSnake(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "PurpleSnake"
    sprite_index = global.sprPurpleSnake;
    color = 0x8a4276;
    UpdateRarity(Rarity.Epic);
    saveKey = "jjPurpleSnake";
}
return _s;
