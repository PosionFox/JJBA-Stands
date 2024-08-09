
global.jjbamDiscTwr = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWR",
    Localize("standDiscDescription") + "The World Retro",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwrUse),
    5 * 10,
    true
);

#define DiscTwrUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwr);
    exit;
}
GiveTwr(player);

#define TwrBloodDrain(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        var _s = [global.sndTwrBd1, global.sndTwrBd2];
        var _i = irandom(array_length(_s) - 1);
        jj_play_audio(_s[_i], 0, false);
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
            if (enemy_instance_exists())
            {
                var _arg = get_nearest_enemy(x, y);
                onHitEvent = StwDivineBloodCreate;
                onHitEventArg = _arg;
            }
            destroyOnImpact = true;
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TwrBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(GetStandReach(self), _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(GetStandReach(self), _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndTwrBarrage, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.08)
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndTwrBarrage);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndTwrBarrage);
        }
    break;
}
attackStateTimer += DT;

#define TwrStrongPunch(method, skill)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;

switch (attackState)
{
    case 0:
        jj_play_audio(global.sndTwrMuda, 0, false);
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

#define TwrKnifeWall(method, skill)
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y);
StandDefaultPos();

switch (attackState)
{
    case 0:
        var _c = random(1);
        if (_c < 0.5)
        {
            jj_play_audio(global.sndTwrMudada, 0, false);
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
        if modTypeExists("timestop")
        {
            var _snd = jj_play_audio(global.sndKnifeThrow, 5, false);
            audio_sound_pitch(_snd, random_range(0.9, 1.1));
        }
        else
        {
            jj_play_audio(global.sndTwohTp, 0, false);
            EffectWhiteScreen(0.1);
        }
        
        repeat (5)
        {
            var _dmg = GetDmg(skill);
            var _p = ProjectileCreate(player.x, player.y);
            with (_p)
            {
                x += lengthdir_x(irandom_range(-8, 8), _dir + 90);
                y += lengthdir_y(irandom_range(-8, 8), _dir + 90);
                damage = _dmg;
                direction = _dir;
                canMoveInTs = false;
                sprite_index = other.knifeSprite;
            }
        }
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define TwrTimestop(method, skill)

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
        jj_play_audio(global.sndStwTheWorld, 5, false);
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 1.2)
        {
            attackState++;
        }
    break;
    case 2:
        jj_play_audio(global.sndTwrTs, 5, false);
        
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
        jj_play_audio(global.sndStwTokiyotomare, 5, false);
        EndAtk(skill);
    break;
}
attackStateTimer += DT;

#define GiveTwr(_owner) //stand

var _s = GiveTheWorld(_owner);
with (_s)
{
    name = "The World Retro";
    sprite_index = global.sprTWR;
    color = /*#*/0x66a0d9;
    UpdateRarity(Rarity.Mythical);
    saveKey = "jjbamTwr";
    discType = global.jjbamDiscTwr;
    
    knifeSprite = global.sprKnifeStw;
    summonSound = global.sndTwrSummon;
    soundWhenHurt = [global.sndStwHurt1, global.sndStwHurt2, global.sndStwHurt3];
    soundWhenDead = global.sndStwDead;
    soundIdle = [global.sndTwrIdle1, global.sndTwrIdle2];
    
    skills[StandState.SkillCOff, StandSkill.Skill] = TwrBloodDrain;
    skills[StandState.SkillA, StandSkill.Skill] = TwrBarrage;
    skills[StandState.SkillB, StandSkill.Skill] = TwrStrongPunch;
    skills[StandState.SkillC, StandSkill.Skill] = TwrKnifeWall;
    skills[StandState.SkillD, StandSkill.Skill] = TwrTimestop;
}
return _s;
