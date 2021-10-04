
#define TripleKnifeThrow(method, skill)

for (var i = 1; i <= 3; i++)
{
    var _dir = (point_direction(owner.x, owner.y, mouse_x, mouse_y) - 16) + (i * 8);
    var _dmg = (skills[skill, StandSkill.Damage] * 0.1) * owner.level;
    
    var _p = ProjectileCreate(owner.x, owner.y);
    with (_p)
    {
        var _snd = audio_play_sound(global.sndKnifeThrow, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        despawnTime = room_speed * 5;
        damage = _dmg;
        direction = _dir;
        canMoveInTs = false;
        sprite_index = global.sprKnife;
    }
}
FireCD(skill);
state = StandState.Idle;

#define TimestopTw(method, skill)

var _tsExists = modTypeExists("timestop");

if (_tsExists)
{
    instance_destroy(modTypeFind("timestop"));
}

if (!_tsExists)
{
    audio_play_sound(global.sndTwTs, 5, false);
    var _ts = ModObjectSpawn(x, y, -1000);
    with (_ts) { TimestopCreate(9); }
    _ts.owner = self;
    InstanceAssignMethod(_ts, "step", ScriptWrap(TimestopStep), false);
    InstanceAssignMethod(_ts, "draw", ScriptWrap(TimestopDraw), false);
    InstanceAssignMethod(_ts, "destroy", ScriptWrap(TimestopDestroy), false);
    FireCD(skill);
}
state = StandState.Idle;

#define GiveTheWorld //stand

var _name = "The World";
var _sprite = global.sprTheWorld;
var _color = 0x36f2fb;

var _stats;
_stats[StandStat.Range] = 50;
_stats[StandStat.AttackDamage] = 5;
_stats[StandStat.AttackRange] = 10;
_stats[StandStat.BaseSpd] = 0.6;

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
_skills[sk, StandSkill.Skill] = TripleKnifeThrow;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.MaxCooldown] = 3;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TimestopTw;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.MaxExecutionTime] = 1;

StandBuilder(_name, _sprite, _stats, _skills, _color);
objPlayer.myStand.summonSound = global.sndTwSummon;

objPlayer.myStand.saveKey = "jjbamTw";
objPlayer.myStand.discType = global.jjbamDiscTw;
