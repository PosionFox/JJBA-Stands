
#define SteelBall(m, s)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
if (balls >= 1)
{
    SteelBallCreate(x, y, _dir, skills[s, StandSkill.Damage]);
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
    var _o = SteelBallCreate(x, y, _dir + irandom_range(-25, 25), skills[s, StandSkill.Damage]);
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

#define GiveSpin //stand

var _name = "Spin";
var _sprite = global.sprSteelBallProj;
var _color = 0x36c76a;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4.0;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = SteelBall;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.3) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = "steel ball:\nlaunch a steel ball with spin energy.\nrequires 1 steel ball\ndmg: " + DMG;

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = GuidedSteelBall;
_skills[sk, StandSkill.Damage] = 2 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 1;
_skills[sk, StandSkill.Desc] = "guided steel ball:\nlaunch a guided steel ball.\nif two steel balls collide their damage increases.\ndmg: " + DMG;

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = SkinHarden;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = "skin harden!:\nhardens your skin decreasing damage taken.";

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    saveKey = "jjbamSpin";
    
    balls = 2;
    
    InstanceAssignMethod(self, "drawGUI", ScriptWrap(SpinDrawGUI));
}
