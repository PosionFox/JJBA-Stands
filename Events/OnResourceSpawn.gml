
#define OnResourceSpawn(_ins)

var _c = random(1);

if (_c <= 0.03)
{
    if (_ins.object_index == objTree)
    {
        _ins.sprite_index = global.sprRokakakaTree;
        _ins.mask_index = global.sprRokakaka;
        _ins.isRoka = true;
    }
}
