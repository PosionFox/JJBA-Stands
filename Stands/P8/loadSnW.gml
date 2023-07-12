
global.jjbamDiscSnw = ItemCreate(
    undefined,
    "DISC:SnW",
    "The label says: Soft and Wet",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    416,
    0,
    0,
    [],
    ScriptWrap(DiscSnwUse),
    5 * 10,
    true
);

#define DiscSnwUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSnw);
    exit;
}
GiveSoftAndWet(player);

#define BubbleBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
image_xscale = mouse_x > owner.x ? 1 : -1;

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndBubble, 10, false);
        attackState++;
    break;
    case 1:
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.16)
            {
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = ProjectileCreate(xx, yy);
                with (_p)
                {
                    damage = GetDmg(s);
                    direction = _dir;
                    direction += random_range(-4, 4);
                    canMoveInTs = false;
                    sprite_index = global.sprBubble;
                    onHitSound = global.sndBubblePop;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            audio_stop_sound(global.sndBubble);
            EndAtk(s);
        }
        if (skills[s, StandSkill.ExecutionTime] >= skills[s, StandSkill.MaxExecutionTime])
        {
            audio_stop_sound(global.sndBubble);
        }
    break;
}
attackStateTimer += DT;

#define spawntest(m, s)

EndAtk(s);

#define GiveSoftAndWet(_owner)

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = spawntest;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillJosephKnife;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = "joseph knife:\nsend out a knife that causes bleed on impact.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = StopSign;
_skills[sk, StandSkill.Damage] = 7;
_skills[sk, StandSkill.DamageScale] = 0.15;
_skills[sk, StandSkill.Icon] = global.sprSkillStopSign;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = "stop sign:\nstrike with a stop sign.";

sk = StandState.SkillCOff;
_skills[sk, StandSkill.Skill] = TwBloodDrain;
_skills[sk, StandSkill.Icon] = global.sprSkillDivineBlood;
_skills[sk, StandSkill.MaxCooldown] = 15;
_skills[sk, StandSkill.Desc] = "blood drain:\ndrain the target's health and heals the user.";

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1.3;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 3;
_skills[sk, StandSkill.Desc] = "barrage:\nlaunches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = BubbleBarrage;
_skills[sk, StandSkill.Damage] = 0.5;
_skills[sk, StandSkill.DamageScale] = 0.1;
_skills[sk, StandSkill.Icon] = global.sprSkillStrongPunch;
_skills[sk, StandSkill.MaxCooldown] = 8;
_skills[sk, StandSkill.Desc] = "strong punch:\ncharges and launches a strong punch.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = TwKnifeWall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillKnifeBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = "knife wall:\nsends out a burst of knifes.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = TwTimestop;
_skills[sk, StandSkill.Icon] = global.sprSkillTimestop;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = "time, stop!:\nstops the time, most enemies are not allowed to move\nand makes your projectiles freeze in place.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Soft and Wet";
    sprite_index = global.sprSoftAndWet;
    color = 0xffffff
    summonSound = global.sndTwSummon;
    discType = global.jjbamDiscSnw;
    
    knifeSprite = global.sprKnife;
    stopSign = ModObjectSpawn(x, y, depth);
    with (stopSign)
    {
        sprite_index = global.sprStopSign;
        visible = false;
    }
    saveKey = "jjbamSnw";
    InstanceAssignMethod(self, "destroy", ScriptWrap(TheWorldDestroy), true);
}
return _s;
