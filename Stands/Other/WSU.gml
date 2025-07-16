
#define GiveWsu(_owner)

var _s = GiveWhiteSnake(_owner);
with (_s)
{
    name = "WhiteSnake Ultimate"
    sprite_index = global.sprWhiteSnakeUltimate;
    color = 0xfcdbcb;
    colorAlt = 0x342022;
    UpdateRarity(Rarity.Ultimate);
    auraParticleSprite = global.sprStandParticle5;
    saveKey = "jjbamWsu";
}
return _s;
