
#define OnResourceSpawn(_ins)

var _c = irandom(100);

if (_c <= 3)
{
    if (_ins.object_index == objTree)
    {
        _ins.sprite_index = global.sprRokakakaTree;
        _ins.mask_index = global.sprRokakaka;
        _ins.isRoka = true;
    }
}
