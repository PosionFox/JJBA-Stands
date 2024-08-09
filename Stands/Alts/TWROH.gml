
global.jjbamDiscTwroh = ItemCreate(
    undefined,
    Localize("standDiscName") + "TWROH",
    Localize("standDiscDescription") + "The World Retro Over Heaven",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    1248,
    0,
    0,
    [],
    ScriptWrap(DiscTwrohUse),
    5 * 10,
    true
);

#define DiscTwrohUse

if (instance_exists(STAND) or room != rmGame)
{
    GainItem(global.jjbamDiscTwroh);
    exit;
}
GiveTwroh(player);

#define TwrohBarrage(m, s)

var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
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
                _p.onHitEvent = TwohBarrageStep;
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

#define GiveTwroh(_owner) //stand

var _s = GiveTWOH(_owner);
with (_s)
{
    name = "The World Retro\nOver Heaven";
    sprite_index = global.sprTWROH;
    color = /*#*/0x50e599;
    UpdateRarity(Rarity.Mythical);
    auraParticleSprite = global.sprStandParticle3;
    saveKey = "jjbamTwroh";
    discType = global.jjbamDiscTwroh;
    summonSound = global.sndTwrSummon;
    soundWhenHurt = [global.sndStwHurt1, global.sndStwHurt2, global.sndStwHurt3];
    
    skills[StandState.SkillA, StandSkill.Skill] = TwrohBarrage;
}
return _s;
