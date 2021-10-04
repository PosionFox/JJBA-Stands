
#define StarFinger(method, skill) //attacks

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

var _xx = owner.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = owner.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

if (distance_to_point(_xx, _yy) <= 1)
{
    if (!modSubtypeExists("starFinger"))
    {
        var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * (owner.level * 0.5);
        
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            sprite_index = global.sprStarPlatinumFinger;
            damage = _dmg;
            stationary = true;
            canDespawnInTs = true;
            destroyOnImpact = false;
            direction = _dir;
            despawnTime = room_speed * 0.7;
            fingerSize = 0;
            InstanceAssignMethod(self, "draw", ScriptWrap(StarFingerDraw), false);
        }
    }
    else
    {
        with (objModEmpty)
        {
            if ("subtype" in self)
            {
                if (subtype == "starFinger")
                {
                    fingerSize = lerp(fingerSize, 120, 0.1);
                    var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
                    direction = _dir;
                    
                    var x2 = owner.x + lengthdir_x(fingerSize, direction);
                    var y2 = owner.y + lengthdir_y(fingerSize, direction);
                    var _col = collision_line(owner.x, owner.y, x2, y2, parEnemy, false, true);
                    var _colTs = collision_line(owner.x, owner.y, x2, y2, objModEmpty, false, true);
                    
                    if (_col)
                    {
                        with (_col)
                        {
                            if (array_find_index(other.instancesHit, id) == -1)
                            {
                                var _dir = point_direction(x, y, other.x, other.y) - 180;
                                h -= lengthdir_x(other.knockback, _dir);
                                v -= lengthdir_y(other.knockback, _dir);
                                hp -= other.damage;
                                array_push(other.instancesHit, id);
                                if (other.destroyOnImpact)
                                {
                                    instance_destroy(other);
                                }
                            }
                        }
                    }
                    if (_colTs)
                    {
                        with (_colTs)
                        {
                            if ("type" in self)
                            {
                                if (type == "TsEnemy")
                                {
                                    damageStack += 0.1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

#define TimestopSp(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndSpTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(5); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define StarFingerDraw //attacks properties

//draw_set_color(c_purple);
var ox = owner.myStand.x;
var oy = owner.myStand.y;
var w = fingerSize / sprite_get_width(sprite_index);

var xx = ox + lengthdir_x(w, direction);
var yy = oy + lengthdir_y(w, direction);
draw_sprite_ext(sprite_index, 0, xx, yy, w, 1, image_angle, image_blend, image_alpha);
//draw_line_width(x, y, owner.myStand.x, owner.myStand.y, 2);
//draw_set_color(image_blend);

#define GiveStarPlatinum //stand

var _name = "Star Platinum";
var _sprite = global.sprStarPlatinum;
var _color = 0x8a4276;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5.5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.SkillAlt] = StandBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxHold] = 0;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSp;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndSpSummon;

objPlayer.myStand.saveKey = "jjbamSp";
objPlayer.myStand.discType = global.jjbamDiscSp;
