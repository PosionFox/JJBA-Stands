
#define SpovaStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = player.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpovaOra, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
        break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 3);
        _p.onHitSound = global.sndStrongPunch;
        EndAtk(skill);
        break;
}
attackStateTimer += DT;

#define SpovaStarFinger(method, skill) //attacks

var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

var _xx = player.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = player.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouse_x > player.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndSpovaStaar, 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.15)
        {
            attackState++;
        }
    break;
    case 2:
        audio_play_sound(global.sndSpovaFinger, 0, false);
        var _p = ProjectileCreate(x, y);
        with (_p)
        {
            subtype = "starFinger";
            owner = STAND;
            sprite_index = global.sprStarPlatinumFinger;
            image_blend = STAND.color;
            damage = GetDmg(skill);
            stationary = true;
            canDespawnInTs = true;
            destroyOnImpact = false;
            direction = _dir;
            despawnFade = false;
            despawnTime = 1;
            fingerSize = 0;
            
            InstanceAssignMethod(self, "step", ScriptWrap(StarFingerStep), false);
            InstanceAssignMethod(self, "draw", ScriptWrap(StarFingerDraw), false);
        }
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 2.2)
        {
            attackState++;
        }
    break;
    case 4:
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define SpovaTimestop(method, s)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        angleTarget = 25;
        audio_play_sound(global.sndSpovaTs, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.9)
        {
            attackState++;
        }
    break;
    case 2:
        angleTargetSpd = 0.3;
        angleTarget = -25;
        
        var ts = TimestopCreate(5 + (0.1 * player.level));
        ts.resumeSound = global.sndSpovaTsResume;
        attackState++;
    break;
    case 3:
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define GiveSpova //stand

var _s = GiveStarPlatinum();
with (_s)
{
    name = "Star Platinum OVA";
    sprite_index = global.sprSPOVA;
    color = /*#*/0xe4cd5f;
    isRare = true;
    saveKey = "jjbamSpova";
    discType = global.jjbamDiscSpova;
    
    summonSound = global.sndSpovaStarPlat;
    soundWhenHurt = [global.sndSpovaHurt1, global.sndSpovaHurt2, global.sndSpovaHurt3];
    soundWhenDead = global.sndSpovaDead;
    
    skills[StandState.SkillB, StandSkill.Skill] = SpovaStrongPunch;
    skills[StandState.SkillC, StandSkill.Skill] = SpovaStarFinger;
    skills[StandState.SkillD, StandSkill.Skill] = SpovaTimestop;
}
return _s;