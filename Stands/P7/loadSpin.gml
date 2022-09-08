
#define SteelBall(m, s)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
if (balls >= 1)
{
    SteelBallCreate(x, y, _dir, GetDmg(s));
    balls--;
    FireCD(s);
    state = StandState.Idle;
}
else
{
    ResetCD(s);
    state = StandState.Idle;
}


#define GuidedSteelBall(m, s)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
if (balls >= 1)
{
    var _o = SteelBallCreate(x, y, _dir + irandom_range(-25, 25), GetDmg(s));
    _o.isGuided = true;
    balls--;
    FireCD(s);
    state = StandState.Idle;
}
else
{
    ResetCD(s);
    state = StandState.Idle;
}

#define SkinHarden(m, s)

FireCD(s);
state = StandState.Idle;

#define SpinDrawGUI

var _width = display_get_gui_width();
var _height = display_get_gui_height() - 40;

for (var i = 0; i < balls; i++)
{
    draw_sprite_ext(global.sprSteelBall, 0, 320 + (32 * i), _height - 88, 2, 2, 0, c_white, 1);
}

#define GiveSpin(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = SteelBall;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.3
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = "steel ball:\nlaunch a steel ball with spin energy.\nrequires 1 steel ball.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = GuidedSteelBall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.2;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = "guided steel ball:\nlaunch a guided steel ball.\nif two steel balls collide their damage increases.";

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = SkinHarden;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = "skin harden!:\nhardens your skin decreasing damage taken.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Spin";
    sprite_index = global.sprSteelBall;
    color = 0x36c76a;
    saveKey = "jjbamSpin";
    
    balls = 2;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(SpinDrawGUI));
}
