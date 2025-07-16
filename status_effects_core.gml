
#define StatusEffect(_args, _target)

var _o = ModObjectSpawn(x, y, 0);
with (_o)
{
    type = "status";
    target = _target;
    destroy_when_target_empty = true;
    life = 5;
    damage = 0;
    
    
    InstanceAssignMethod(self, "step", ScriptWrap(StatusEffectStep), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(StatusEffectDestroy), false);
}
return _o;

#define StatusEffectStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;

if (destroy_when_target_empty and !instance_exists(target))
{
    life = 0;
}

if (!instance_exists(target)) exit;

depth = target.depth - 2;

if (damage > 0)
{
    target.hp -= damage;
}

#define StatusEffectDestroy



#define StatusEffectTargetHas(_target, _subtype)

var _has = false;
with (MOBJ)
{
    if (bool("type" in self) and type == "status" and subtype == _subtype and target == _target) _has = true;
}
return _has;

#define StatusEffectTargetGet(_target, _subtype)

var _has = false;
with (MOBJ)
{
    if (bool("type" in self) and type == "status" and subtype == _subtype and target == _target) _has = self;
}
return _has;