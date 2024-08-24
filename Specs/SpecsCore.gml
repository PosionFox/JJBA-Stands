
enum SpecState
{
    Idle,
    Attack
}

enum SpecSkill
{
    A,
    B
}

enum SpecSkillData
{
    Skill,
    Icon,
    Damage
}

#define EndSpecAtk(skill)

attackState = 0;
attackStateTimer = 0;
currentAttack = undefined;
currentSkill = undefined;
state = SpecState.Idle;

#define SpecSkillsInit()

var _arr;

_arr[SpecSkill.A, SpecSkillData.Skill] = AttackHandler;
_arr[SpecSkill.A, SpecSkillData.Icon] = global.sprSkillBarrage;

_arr[SpecSkill.B, SpecSkillData.Skill] = AttackHandler;
_arr[SpecSkill.B, SpecSkillData.Icon] = global.sprSkillStrongPunch;

return _arr;

#define SpecBuild(_user, _skills)

if (instance_exists(_user.spec))
{
    instance_destroy(_user.spec);
}

var _spec = ModObjectSpawn(_user.x, _user.y, _user.depth)
with (_spec)
{
    state = SpecState.Idle;
    type = "spec";
    name = "unknown";
    owner = _user;
    targets = [ENEMY, MOBJ, NATURAL, CRITTER];
    color = c_white;
    
    barrageData = {
        time : 0,
        sound : noone,
        hitSound : noone,
        hitEvent : noone,
        hitEventArgs : noone
    };
    
    attackState = 0;
    attackStateTimer = 0;
    skills = _skills;
    currentAttack = undefined;
    currentSkill = undefined;
    
    InstanceAssignMethod(self, "step", ScriptWrap(SpecStep));
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(SpecDrawGUI));
    _user.spec = self;
}
return _spec;

#define SpecStep

if (instance_exists(owner))
{
    x = owner.x;
    y = owner.y;
}

if (instance_exists(STAND))
{
    if (state == SpecState.Idle and STAND.state == StandState.Idle)
    {
        if (keyboard_check_pressed(ord(player.specKeybind1)))
        {
            currentAttack = skills[SpecSkill.A, SpecSkillData.Skill];
            currentSkill = SpecSkill.A;
            state = SpecState.Attack;
        }
        if (keyboard_check_pressed(ord(player.specKeybind2)))
        {
            currentAttack = skills[SpecSkill.B, SpecSkillData.Skill];
            currentSkill = SpecSkill.B;
            state = SpecState.Attack;
        }
    }
}
else
{
    if (state == SpecState.Idle)
    {
        if (keyboard_check_pressed(ord(player.specKeybind1)))
        {
            currentAttack = skills[SpecSkill.A, SpecSkillData.Skill];
            currentSkill = SpecSkill.A;
            state = SpecState.Attack;
        }
        if (keyboard_check_pressed(ord(player.specKeybind2)))
        {
            currentAttack = skills[SpecSkill.B, SpecSkillData.Skill];
            currentSkill = SpecSkill.B;
            state = SpecState.Attack;
        }
    }
}

if (currentAttack != undefined)
{
    script_execute(currentAttack, currentSkill, undefined);
}

#define SpecDrawGUI

draw_sprite(skills[SpecSkill.A, SpecSkillData.Icon], 0, 32, 256);
draw_sprite(skills[SpecSkill.B, SpecSkillData.Icon], 0, 64, 256);
