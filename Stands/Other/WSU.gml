
#define GiveWsu(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "WhiteSnake Ultimate"
    sprite_index = global.sprWhiteSnakeUltimate;
    color = Color.DimWhite;
    colorAlt = Color.DarkBlue;
    UpdateRarity(Rarity.Ultimate);
    auraParticleSprite = global.sprStandParticle5;
    saveKey = "jjbamWsu";
}
return _s;
