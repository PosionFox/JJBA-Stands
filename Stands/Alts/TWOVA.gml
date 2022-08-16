
global.jjbamDiscTwova = ItemCreate(
    undefined,
    "DISC:TWOVA",
    "The label says: The World OVA",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscTwovaUse),
    5 * 10,
    true
);

#define DiscTwovaUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscTwova);
    exit;
}
GiveTwova();

#define TwovaBloodDrain(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        var _s = [global.sndTwrBd1, global.sndTwrBd2];
        var _i = irandom(array_length(_s) - 1);
        audio_play_sound(_s[_i], 0, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.3)
        {
            attackState++;
        }
    break;
    case 2:
        var _p = PunchCreate(x, y, _dir, GetDmg(skill), 0);
        with (_p)
        {
            var _arg = noone;
            if (instance_exists(ENEMY))
            {
                _arg = instance_nearest(x, y, ENEMY);
            }
            onHitEvent = StwDivineBloodCreate;
            onHitEventArg = _arg;
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TwovaStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(stats[StandStat.AttackRange], _dir);
var _yy = player.y + lengthdir_y(stats[StandStat.AttackRange], _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndTwrMuda, 0, false);
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

#define TwovaKnifeWall(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
StandDefaultPos();

switch (attackState)
{
    case 0:
        var _c = random(1);
        if (_c < 0.5)
        {
            audio_play_sound(global.sndTwrMudada, 0, false);
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer > 0.2)
        {
            attackState++;
        }
    break;
    case 2:
        var _snd = audio_play_sound(global.sndStwKnifeThrow2, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        
        repeat (5)
        {
            var _p = ProjectileCreate(player.x, player.y);
            with (_p)
            {
                x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
                y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
                damage = GetDmg(skill);
                direction = _dir;
                canMoveInTs = false;
                sprite_index = other.knifeSprite;
            }
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TwovaTimestop(method, skill)

xTo = player.x;
yTo = player.y - 16;

switch (attackState)
{
    case 0:
        var _tsExists = modTypeExists("timestop");

        if (_tsExists)
        {
            instance_destroy(modTypeFind("timestop"));
        }
        angleTarget = 25;
        audio_play_sound(global.sndStwTheWorld, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        audio_play_sound(global.sndTwrTs, 5, false);
        
        var ts = TimestopCreate(9 + (0.05 * player.level));
        ts.resumeSound = global.sndStwTsResume;
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 1.6)
        {
            attackState++;
        }
    break;
    case 4:
        audio_play_sound(global.sndStwTokiyotomare, 5, false);
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define GiveTwova //stand

var _s = GiveTheWorld();
with (_s)
{
    name = "The World OVA";
    sprite_index = global.sprTWR;
    color = /*#*/0x66a0d9;
    isRare = true;
    saveKey = "jjbamTwova";
    discType = global.jjbamDiscTwova;
    
    knifeSprite = global.sprKnifeStw;
    summonSound = global.sndTwrSummon;
    soundWhenHurt = [global.sndStwHurt1, global.sndStwHurt2, global.sndStwHurt3];
    soundWhenDead = global.sndStwDead;
    soundIdle = [global.sndTwrIdle1, global.sndTwrIdle2];
    
    skills[StandState.SkillCOff, StandSkill.Skill] = TwovaBloodDrain;
    skills[StandState.SkillB, StandSkill.Skill] = TwovaStrongPunch;
    skills[StandState.SkillC, StandSkill.Skill] = TwovaKnifeWall;
    skills[StandState.SkillD, StandSkill.Skill] = TwovaTimestop;
}
return _s;
