
#define GravityShiftAttract(_, s)

GravityShiftCreate(owner);
jj_play_audio(global.sndCmGravityShiftAttract, 5, false);
EndAtk(s);

#define GravityShiftRepel(_, s)

var _g = GravityShiftCreate(owner);
with (_g)
{
    force = -0.5;
}
jj_play_audio(global.sndCmGravityShiftRepel, 5, false);
EndAtk(s);

#define GravityShiftCreate(_owner)

if (modTypeExists("GravityShift"))
{
    var _gf = modTypeFind("GravityShift");
    instance_destroy(_gf);
    
    with (ENEMY)
    {
        var _e = EffectCircleCreate(x, y, 32, 4);
        _e.color = other.color;
        hp -= 5 + (hpMax * 0.1);
    }
    with (MOBJ)
    {
        if (bool("type" in self) and type == "Enemy")
        {
            var _e = EffectCircleCreate(x, y, 32, 4);
            _e.color = other.color;
            hp -= 5 + (hpMax * 0.1);
        }
    }
    jj_play_audio(global.sndCmGravityShiftCollapse, 5, false);
    exit;
}

EffectScreenWarpCreate();
var _o = ModObjectSpawn(_owner.x, _owner.y, -100000);
with (_o)
{
    type = "GravityShift";
    owner = _owner;
    life = 20;
    radius = 0;
    alpha = 1;
    force = 0.5;
    
    InstanceAssignMethod(self, "step", ScriptWrap(GravityShiftStep));
    InstanceAssignMethod(self, "draw", ScriptWrap(GravityShiftDraw));
}
return _o;

#define GravityShiftStep

if (life <= 0)
{
    instance_destroy(self);
    exit;
}
life -= DT;
alpha = min(life, 1);
radius += DT * 255;

with (ENEMY)
{
    var _dir = point_direction(x, y, other.owner.x, other.owner.y);
    x += lengthdir_x(other.force, _dir);
    y += lengthdir_y(other.force, _dir);
}
with (MOBJ)
{
    if (bool("type" in self) and type == "Enemy")
    {
        var _dir = point_direction(x, y, other.owner.x, other.owner.y);
        x += lengthdir_x(other.force, _dir);
        y += lengthdir_y(other.force, _dir);
    }
}

#define GravityShiftDraw

draw_set_alpha(0.5 * alpha);
draw_circle_color(player.x, player.y, radius, c_lime, c_green, false);
draw_set_alpha(image_alpha);

#define GiveCMoon(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = GroundSlam;
_skills[sk, StandSkill.Damage] = 5;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = AttackHandler;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = GravityShiftRepel;
_skills[sk, StandSkill.Icon] = global.sprSkillGravityShiftRepel;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.SkillAlt] = GravityShiftAttract;
_skills[sk, StandSkill.IconAlt] = global.sprSkillGravityShiftAttract;
_skills[sk, StandSkill.MaxCooldownAlt] = 30;

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "C-Moon";
    sprite_index = global.sprCMoon;
    color = 0x30be6a;
    summonSound = global.sndCmSummon;
    saveKey = "jjbamCmn";
}
return _s;
