
#define KnifeBarrage(method, skill) //attacks

var _dis = point_distance(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _xx = objPlayer.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = objPlayer.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > objPlayer.x ? 1 : -1;

attackStateTimer += 1 / room_speed;
if (distance_to_point(_xx, _yy) < 2)
{
    if (attackStateTimer >= 0.1)
    {
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var xx = x + random_range(-8, 8);
        var yy = y + random_range(-8, 8);
        var ddir = _dir + random_range(-2, 2);
        var _p = ProjectileCreate(xx, yy);
        with (_p)
        {
            despawnTime = room_speed * 5;
            damage = other.skills[skill, StandSkill.Damage];
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprKnife;
        }
        attackStateTimer = 0;
    }
    skills[skill, StandSkill.ExecutionTime] += 1 / room_speed;
}

if (keyboard_check_pressed(ord(skills[skill, StandSkill.Key])))
{
    if (skills[skill, StandSkill.ExecutionTime] > 0)
    {
        FireCD(skill);
    }
    else
    {
        ResetCD(skill);
    }
    state = StandState.Idle;
}

#define GunShot(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

var _p = ProjectileCreate(objPlayer.x, objPlayer.y);
with (_p)
{
    audio_play_sound(global.sndGunShot, 0, false);
    baseSpd = 10;
    sprite_index = global.sprBtdVoidTrace;
    image_blend = c_yellow;
    mask_index = global.sprKnife;
    despawnTime = room_speed * 5;
    damage = other.skills[skill, StandSkill.Damage];
    direction = _dir;
    canMoveInTs = false;
    GlowOrderCreate(self, 0.1, c_yellow);
}
FireCD(skill)
state = StandState.Idle;

#define TimestopTwAu(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwAuTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(5); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define GiveTheWorldAU //stand

var _name = "The World AU";
var _sprite = global.sprTheWorldAU;
var _color = 0x36c7fb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 4.0;
_stats[StandStat.AttackRange] = 20;
_stats[StandStat.BaseSpd] = 0.5;

var _skills = StandSkillInit(_stats);

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = KnifeBarrage;
_skills[sk, StandSkill.Damage] = 1 + (objPlayer.level * 0.02) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = "knife barrage:\nlaunches a barrage of knifes.\ndmg: " + DMG;

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = StrongPunch;
_skills[sk, StandSkill.Damage] = 4 + (objPlayer.level * 0.1) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 7;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.\ndmg: " + DMG;

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = GunShot;
_skills[sk, StandSkill.Damage] = 5 + (objPlayer.level * 0.2) + objPlayer.dmg;
_skills[sk, StandSkill.Icon] = global.sprSkillGunShot;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "gunshot:\nfires a single projectile forwards.\ndmg: " + DMG;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTwAu;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 25;
_skills[sk, StandSkill.Desc] = "it's my time!:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_name, _sprite, _stats, _skills, _color);
with (_s)
{
    summonSound = global.sndTwSummon;
    saveKey = "jjbamTwau";
    discType = global.jjbamDiscTwau;
}
