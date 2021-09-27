
#define HorizontalSlash(method, skill) //attacks

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _p = ProjectileCreate(owner.x, owner.y);
with (_p)
{
    sprite_index = global.sprHorizontalSlash;
    despawnTime = room_speed * 0.1;
    distance = 16;
    direction = _dir;
    stationary = true;
    destroyOnImpact = false;
}
FireCD(skill);
state = StandState.Idle;

#define GiveAnubis //stand

var _name = "Anubis";
var _sprite = global.sprAnubis;
var _punchSprite = global.sprTheWorldPunch;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 8;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.9;

var _skills = StandSkillInit(_stats);

var sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = HorizontalSlash;

StandBuilder(_name, _sprite, _stats, _skills, _punchSprite);

SaveStand("jjbamAnubis");
