
#define GiveSpookyWorld //stand

var _s = GiveTheWorld();
with (_s)
{
    name = "Spooky World";
    sprite_index = global.sprSpookyWorld;
    color = 0x322022;
    
    saveKey = "jjbamSw";
    discType = global.jjbamDiscSw;
}
return _s;
