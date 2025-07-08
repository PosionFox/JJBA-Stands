
#define OnStructureCraft(_structure, _item, _quantity, _remaining)

if (_item == global.jjsStarChunk)
{
    DropItem(_structure.x, _structure.y, global.jjsStarChunk, 3);
}
