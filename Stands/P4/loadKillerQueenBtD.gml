
global.jjbamDiscKqbtd = ItemCreate(
    undefined,
    "DISC:KQBTD",
    "The label says: KQ Bites the Dust",
    global.sprDisc,
    ItemType.Consumable,
    ItemSubType.Potion,
    0,
    0,
    0,
    [],
    ScriptWrap(DiscKqbtdUse),
    5 * 10,
    true
);

#define DiscKqbtdUse

if (instance_exists(STAND))
{
    GainItem(global.jjbamDiscKqbtd);
    exit;
}
GiveKillerQueenBtD(player);

#define TripleCoin(method, skill) //attacks
if (modTypeCount("coinBomb") >= 9)
{
    ResetCD(skill);
    state = StandState.Idle;
    exit;
}
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);

audio_play_sound(sndCoin2, 0, false);
CoinBombCreate(objPlayer.x, objPlayer.y, _dir - 45);
CoinBombCreate(objPlayer.x, objPlayer.y, _dir);
CoinBombCreate(objPlayer.x, objPlayer.y, _dir + 45);
FireCD(skill);
state = StandState.Idle;

#define StrayCat(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

switch (attackState)
{
    case 0:
        audio_play_sound(global.sndStrayCat, 1, false);
        attackState++;
    break;
    case 1:
        attackStateTimer += DT;
        if (attackStateTimer >= 0.8)
        {
            attackState++;
        }
    break;
    case 2:
        ScBubbleCreate(x, y);
        FireCD(skill)
        state = StandState.Idle;
    break;
}

#define PlaceThirdBomb(method, skill)
var _dir = point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y);
xTo = objPlayer.x + lengthdir_x(8, _dir);
yTo = objPlayer.y + lengthdir_y(8, _dir);

BombEffect(x, y);
var _o = ModObjectSpawn(x, y, 0);
with (_o)
{
    type = "thirdBomb";
    warpX = objPlayer.x;
    warpY = objPlayer.y;
    prevHp = objPlayer.hp;
    prevEnergy = objPlayer.energy;
}
skills[skill, StandSkill.Icon] = global.sprSkillBtD;
skills[skill, StandSkill.Skill] = BitesTheDust;
skills[skill, StandSkill.MaxCooldown] = 2;
FireCD(skill);
state = StandState.Idle;

#define BitesTheDust(method, skill)

attackStateTimer += 1 / room_speed;
switch (attackState)
{
    case 0:
        if (!instance_exists(parEnemy))
        {
            ResetCD(skill);
            state = StandState.Idle;
            exit;
        }
        audio_play_sound(global.sndBitesTheDust, 5, false);
        visible = false;
        with (parEnemy)
        {
            BtDStareCreate(self);
        }
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 6.5)
        {
            attackState++;
        }
    break;
    case 2:
        if (instance_exists(parEnemy))
        {
            with (parEnemy)
            {
                ExplosionCreate(x, y, 32, false);
                hp -= (hpMax * 0.4) + 5;
            }
        }
        BtDVoidCreate();
        attackState++;
    break;
    case 3:
        if (attackStateTimer >= 14)
        {
            attackState++;
        }
    break;
    case 4:
        var _w = modTypeFind("thirdBomb");
        objPlayer.x = _w.warpX;
        objPlayer.y = _w.warpY;
        objPlayer.hp = _w.prevHp;
        objPlayer.energy = _w.prevEnergy;
        instance_destroy(_w);
        instance_destroy(modTypeFind("BtDVoid"));
        with (objModEmpty)
        {
            if ("type" in self)
            {
                if (type == "BtDStare")
                {
                    instance_destroy(self);
                }
            }
        }
        objPlayer.invulFrames = 0;
        visible = true;
        skills[skill, StandSkill.Icon] = global.sprSkillThirdBomb;
        skills[skill, StandSkill.Skill] = PlaceThirdBomb;
        skills[skill, StandSkill.MaxCooldown] = 40;
        FireCD(skill);
        state = StandState.Idle;
    break;
}
xTo = objPlayer.x;
yTo = objPlayer.y - 16;

#define ScBubbleCreate(_x, _y) //attacks properties

var _o = ModObjectSpawn(_x, _y, 0)
with (_o)
{
    type = "ScBubble";
    sprite_index = global.sprScBubble;
    image_xscale = 0;
    image_yscale = 0;
    direction = point_direction(x, y, mouse_x, mouse_y);
    speed = 0.5;
    life = 8;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ScBubbleStep), false);
    InstanceAssignMethod(self, "destroy", ScriptWrap(ScBubbleDestroy), false);
}

#define ScBubbleStep

depth = -y;

var _xs, _ys;
_xs = (1 + abs(cos(current_time / 1000))) * 0.5;
_ys = (1 + abs(sin(current_time / 1000))) * 0.5;
image_xscale = lerp(image_xscale, _xs, 0.1);
image_yscale = lerp(image_yscale, _ys, 0.1);
image_alpha = lerp(image_alpha, 0.5, 0.1);

var pd = point_direction(x, y, mouse_x, mouse_y);
var dd = angle_difference(direction, pd);
direction -= min(abs(dd), 2) * sign(dd);

life -= 1 / room_speed;
if (life <= 0)
{
    instance_destroy(self);
}

#define ScBubbleDestroy

audio_play_sound(global.sndDetonateBomb, 0, false);

with (parEnemy)
{
    var _p = modTypeFind("ScBubble");
    if (distance_to_object(_p) < 32)
    {
        hp -= (hpMax * 0.04) + 5;
    }
}

ExplosionEffect(x, y);
ExplosionCreate(x, y, 32, true);
instance_destroy(self);

#define BtDStareCreate(_target)

var _o = ModObjectSpawn(_target.x, _target.y, _target.depth - 1);
with (_o)
{
    type = "BtDStare";
    sprite_index = global.sprBtdStare;
    image_alpha = 0;
    image_xscale = 0;
    image_yscale = 0;
    target = _target;
    
    alpha = 0;
    size = 0;
    
    timer = 1;
    counts = 0;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BtDStareStep), false);
}

#define BtDStareStep

image_alpha = lerp(image_alpha, alpha, 0.2);
image_xscale = lerp(image_xscale, size, 0.2);
image_yscale = lerp(image_yscale, size, 0.2);

timer -= 1 / room_speed;
if (timer <= 0 and counts < 3)
{
    alpha += 0.3;
    size += 0.3;
    timer = 1;
    counts++;
}

if (!instance_exists(target))
{
    instance_destroy(self);
}
else
{
    x = target.x;
    y = target.y - abs(target.sprite_width * 2);
}

#define BtDVoidCreate

var _o = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
with (_o)
{
    type = "BtDVoid";
    depth = -10;
    
    maxPoints = 8;
    point = array_create(maxPoints, 1);
    
    InstanceAssignMethod(self, "step", ScriptWrap(BtDVoidStep), false);
    InstanceAssignMethod(self, "draw", ScriptWrap(BtDVoidDraw), false);
    var _f = ModObjectSpawn(objPlayer.x, objPlayer.y, 0);
    with (_f)
    {
        type = "BtDVoidFade";
        depth = -1000;
        
        rectAlpha = 0;
        
        InstanceAssignMethod(self, "step", ScriptWrap(BtDVoidFadeStep), false);
        InstanceAssignMethod(self, "draw", ScriptWrap(BtDVoidFadeDraw), false);
    }
}

#define BtDVoidStep

if (instance_exists(objPlayer))
{
    x = objPlayer.x;
    y = objPlayer.y;
    objPlayer.invulFrames = 10;
    objPlayer.h = 0;
    objPlayer.v = 0;
}

for (var i = 0; i < maxPoints; i++)
{
    point[i] *= 1 + random(0.1);
}
var _o = ModObjectSpawn(x, y, depth - 1);
with (_o)
{
    sprite_index = global.sprBtdVoidTrace;
    direction = random(360);
    image_angle = direction;
    image_xscale = random(3);
    speed = random_range(10, 20);
    timer = 2;
    
    InstanceAssignMethod(self, "step", ScriptWrap(BtDVoidTrace), false);
}

#define BtDVoidDraw

draw_set_color(c_black);
draw_primitive_begin(pr_trianglefan);
for (var i = 0; i < maxPoints; i++)
{
    var _xx = x + lengthdir_x(point[i], i * (360 / maxPoints));
    var _yy = y + lengthdir_y(point[i], i * (360 / maxPoints));
    draw_vertex(_xx, _yy);
}
draw_primitive_end();
draw_set_color(image_blend);

#define BtDVoidTrace

timer -= 1 / room_speed;
if (timer <= 0) { instance_destroy(self); }

#define BtDVoidFadeStep

if (modTypeExists("BtDVoid"))
{
rectAlpha += (1 / room_speed) * 0.15;
}
else
{
    rectAlpha -= (1 / room_speed);
    if (rectAlpha <= 0)
    {
        instance_destroy(self);
    }
}

#define BtDVoidFadeDraw

draw_set_alpha(rectAlpha);
draw_rectangle(objPlayer.x- 500, objPlayer.y - 500, objPlayer.x + 500, objPlayer.y + 500, false);
draw_set_alpha(image_alpha);

#define GiveKillerQueenBtD(_owner) //stand

var _skills = StandSkillInit();

var sk;
sk = StandState.SkillAOff;
_skills[sk, StandSkill.Skill] = DetonateBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillDetonate;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.Desc] = @"detonate bomb:
explodes any bombs already placed.";

sk = StandState.SkillBOff;
_skills[sk, StandSkill.Skill] = TripleCoin;
_skills[sk, StandSkill.Icon] = global.sprSkillCoinBomb;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = @"the wealthy:
tosses three coins forward, these can be detonated on demand.";

sk = StandState.SkillDOff;
_skills[sk, StandSkill.Skill] = ShaSummon;
_skills[sk, StandSkill.Icon] = global.sprSkillSHA;
_skills[sk, StandSkill.MaxCooldown] = 20;
_skills[sk, StandSkill.Desc] = @"killer queen's second bomb:
summons sha in combat, chasing and exploding enemies on its own.";

sk = StandState.SkillA;
_skills[sk, StandSkill.Skill] = StandBarrage;
_skills[sk, StandSkill.Damage] = 1;
_skills[sk, StandSkill.DamageScale] = 0.02;
_skills[sk, StandSkill.Icon] = global.sprSkillBarrage;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = @"barrage:
launches a barrage of punches.";

sk = StandState.SkillB;
_skills[sk, StandSkill.Skill] = PlaceBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillFirstBomb;
_skills[sk, StandSkill.MaxCooldown] = 5;
_skills[sk, StandSkill.Desc] = @"killer queen's first bomb:
places a bomb on the nearest enemy or ground.";

sk = StandState.SkillC;
_skills[sk, StandSkill.Skill] = StrayCat;
_skills[sk, StandSkill.Icon] = global.sprSkillStrayCat;
_skills[sk, StandSkill.MaxCooldown] = 12;
_skills[sk, StandSkill.Desc] = @"stray cat:
releases an explosive bubble that can be controlled.";

sk = StandState.SkillD;
_skills[sk, StandSkill.Skill] = PlaceThirdBomb;
_skills[sk, StandSkill.Icon] = global.sprSkillThirdBomb;
_skills[sk, StandSkill.MaxCooldown] = 2;
_skills[sk, StandSkill.MaxExecutionTime] = 20;
_skills[sk, StandSkill.Desc] = @"killer queen's third bomb:
places a special bomb on the ground.

(after cast) bites the dust:
detonates the special bomb damaging all enemies nearby,
returns the user to the original position
where they placed the bomb in the first place while also
healing the user for the amount of damage lost afterwards.
";

var _s = StandBuilder(_owner, _skills);
with (_s)
{
    name = "KQ: Bites The Dust";
    sprite_index = global.sprKillerQueenBtD;
    color = 0xba7bd7;
    summonSound = global.sndKqbtdSummon;
    saveKey = "jjbamKqbtd";
    discType = global.jjbamDiscKqbtd;
}
