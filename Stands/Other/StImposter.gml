
global.jjbamDiscSus = ItemCreate(
    undefined,
    "DISC:SUS",
    "The label says: Imposter",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    69,
    0,
    0,
    [],
    ScriptWrap(DiscSusUse),
    5 * 10,
    true
);

#define DiscSusUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscSus);
    exit;
}
GiveImposter(player);

#define MeetingCall(m, s)
var _dmg = GetDmg(s);

if (instance_exists(ENEMY))
{
    audio_play_sound(global.sndAmogButton, 5, false);
    with (ENEMY)
    {
        with (other)
        {
            PunchCreate(other.x, other.y, random(360), _dmg, 10);
        }
    }
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define Kill(m, s)
var _dmg = GetDmg(s);

switch (attackState)
{
    case 0:
        if (instance_exists(ENEMY))
        {
            var _n = instance_nearest(x, y, ENEMY);
            if (distance_to_object(_n) < 64)
            {
                audio_play_sound(global.sndAmogMurder, 5, false);
                player.x = _n.x;
                player.y = _n.y;
                attackState++;
            }
            else
            {
                ResetAtk(s);
            }
        }
        else
        {
            ResetAtk(s);
        }
    break;
    case 1:
        if (attackStateTimer >= 0.5)
        {
            attackState++;
        }
    break;
    case 2:
        if (instance_exists(ENEMY))
        {
            var _n = instance_nearest(x, y, ENEMY);
            if (distance_to_object(_n) < 64)
            {
                _n.hp -= _dmg;
                EndAtk(s);
            }
            else
            {
                ResetAtk(s);
            }
        }
        else
        {
            ResetAtk(s);
        }
    break;
}
attackStateTimer += DT;

#define GiveImposter(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = KnifeBarrage;
_skills[sk, StandSkill.Icon] = global.sprSkillTripleKnifeThrow;
_skills[sk, StandSkill.Damage] = 3;
_skills[sk, StandSkill.DamageScale] = 0.3;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.MaxExecutionTime] = 0.2;
_skills[sk, StandSkill.Desc] = @"knifes:
tosses a few knifes.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = MeetingCall;
_skills[sk, StandSkill.Icon] = global.sprSkillMeetingCall;
_skills[sk, StandSkill.Damage] = 2;
_skills[sk, StandSkill.DamageScale] = 0.5;
_skills[sk, StandSkill.MaxCooldown] = 10;
_skills[sk, StandSkill.Desc] = @"meeting call:
presses a button that damages enemies.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = Kill;
_skills[sk, StandSkill.Icon] = global.sprSkillKill;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 10;
_skills[sk, StandSkill.MaxCooldown] = 30;
_skills[sk, StandSkill.Desc] = @"kill:
teleports to a nearby enemy and heavily damages them.";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "Imposter";
    sprite_index = global.sprImposter;
    color = /*#*/0x0000FF;
    summonSound = global.sndImposterSummon;
    saveKey = "jjbamSus";
    discType = global.jjbamDiscSus;
    isRare = true;
    powerMultiplier = 5;
    rot = 0;
    sprKnife = global.sprKnife;
    
    InstanceAssignMethod(self, "draw", ScriptWrap(ImposterDraw), false);
}

#define ImposterDraw

if (active)
{
    for (var i = 0; i < sprite_get_number(global.sprImposter); i++)
    {
        draw_sprite_ext(global.sprImposter, i, x, y - (1 * i), 1, 1, rot, c_white, 1);
    }
}
rot++;
