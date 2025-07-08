
#define OnDig(_x, _y)

if (_x >= 968 and _y <= 1144 and _y >= 200)
{
    if (place_meeting(_x, _y, objDigSpot))
    {
        if (random(1) < 0.25)
        {
            var _pool = [
                global.jjsHolyHeart,
                global.jjsHolyLeftArm,
                global.jjsHolyRightArm,
                global.jjsHolyLeftEye,
                global.jjsHolyRightEye,
                global.jjsHolySpine,
                global.jjsHolyRibCage,
                global.jjsHolyLeftEar,
                global.jjsHolyRightEar,
                global.jjsHolyLeftLeg,
                global.jjsHolyRightLeg,
                global.jjsHolySkull
            ]
            
            var _item = irandom(array_length(_pool) - 1);
            DropItem(_x, _y, _pool[_item], 1);
        }
    }
}
