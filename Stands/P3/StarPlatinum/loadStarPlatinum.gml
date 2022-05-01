
#define StarFinger(method, skill) //attacks

var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _xx = objPlayer.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = objPlayer.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

if (distance_to_point(_xx, _yy) <= 1)
{
    if (!modSubtypeExists("starFinger"))
    {
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            sprite_index = global.sprStarPlatinumFinger;
            damage = other.skills[skill, StandSkill.Damage];
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
                    var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
                    direction = _dir;
                    
                    var x2 = objPlayer.x + lengthdir_x(fingerSize, direction);
                    var y2 = objPlayer.y + lengthdir_y(fingerSize, direction);
                    var _col = collision_line(objPlayer.x, objPlayer.y, x2, y2, parEnemy, false, true);
                    var _colTs = collision_line(objPlayer.x, objPlayer.y, x2, y2, objModEmpty, false, true);
                    
                    if (_col)
                    {
                        with (_col)
                        {
                            if (array_find_index(other.instancesHit, id) == -1)
                            {
                                var _s = audio_play_sound(global.sndPunchHit, 0, false);
                                audio_sound_pitch(_s, random_range(0.9, 1.1));
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
var ox = objPlayer.myStand.x;
var oy = objPlayer.myStand.y;
var w = fingerSize / sprite_get_width(sprite_index);

var xx = ox + lengthdir_x(w, direction);
var yy = oy + lengthdir_y(w, direction);
draw_sprite_ext(sprite_index, 0, xx, yy, w, 1, image_angle, image_blend, image_alpha);
//draw_line_width(x, y, objPlayer.myStand.x, objPlayer.myStand.y, 2);
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
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 5;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.\ndmg: " + DMG;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 5 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.SkillAlt] = MeleePull;
_skills[sk, StandSkill.IconAlt] = global.sprSkillMeleePull;
_skills[sk, StandSkill.MaxCooldownAlt] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = @"strong punch:
charges and launches a strong punch.

(hold) melee pull:
pulls the enemy towards you.
dmg: " + DMG;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StarFinger;
_skills[sk, StandSkill.Damage] = 3 + (objPlayer.level * 0.05) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStarFinger;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 0.7;
_skills[sk, StandSkill.Desc] = "star finger:\nstar platinum stretches their finger hitting enemies in the way.\ndmg: " + DMG;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopSp;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestopSp;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.MaxExecutionTime] = 1;
_skills[sk, StandSkill.Desc] = "time stop:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndSpSummon;
    saveKey = "jjbamSp";
    discType = global.jjbamDiscSp;
}
