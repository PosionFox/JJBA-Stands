
#define KceScalpelSlash(m, s)
var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

jj_play_audio(global.sndKnifeThrow, 5, false);
KcePlayRandomScream();
var _dmg = GetDmg(s);
var o = ProjectileCreate(owner.x, owner.y);
with (o)
{
    damage = _dmg;
    sprite_index = global.sprScalpelSwing;
    mask_index = global.sprHitbox32x32;
    direction = _dir;
    stationary = true;
    distance = 16;
    destroyOnImpact = false;
    onHitEvent = SlashNearest;
    
    InstanceAssignMethod(self, "step", ScriptWrap(ScalpelSlashStep));
}
EndAtk(s);

#define KceScalpelThrow(m, s)

var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);

switch (attackState)
{
    case 0:
        var _snd = jj_play_audio(global.sndKnifeThrow, 5, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            damage = _dmg;
            baseSpd = 7;
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprScalpel;
        }
        KcePlayRandomScream();
        attackState++;
    break;
    case 1:
        if (attackStateTimer >= 0.15) attackState++;
    break;
    case 2:
        var _snd = jj_play_audio(global.sndKnifeThrow, 5, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _dmg = GetDmg(s);
        var _p = ProjectileCreate(owner.x, owner.y);
        with (_p)
        {
            damage = _dmg;
            baseSpd = 7;
            direction = _dir;
            direction += random_range(-4, 4);
            canMoveInTs = false;
            sprite_index = global.sprScalpel;
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT;

#define KceTimeSkip(m, s)

if (!WaterCollision(mouse_x, mouse_y) and !modTypeExists("timeErase"))
{
    jj_play_audio(global.sndKceTeleport, 5, false);
    EffectPlayerAfterimageCreate(owner.x, owner.y);
    EffectTimeSkipCreate();
    player.x = mouse_x;
    player.y = mouse_y;
    EndAtk(s);
}
else
{
    ResetAtk(s);
}

#define KceBarrage(method, s) //attacks

switch (attackState)
{
    case 0:
        if (enemy_instance_exists())
        {
            var _n = get_nearest_enemy(mouse_x, mouse_y);
            if (distance_to_object(_n) < 64)
            {
                KcePlayRandomScream();
                jj_play_audio(global.sndKcTp, 5, false);
                EffectPlayerAfterimageCreate(owner.x, owner.y);
                EffectTimeSkipCreate();
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
        var _target = noone;
        var _dis = point_distance(owner.x, owner.y, mouse_x, mouse_y);
        var _dir = point_direction(owner.x, owner.y, mouse_x, mouse_y);
        if (enemy_instance_exists())
        {
            _target = get_nearest_enemy(owner.x, owner.y);
            _dis = point_distance(owner.x, owner.y, _target.x, _target.y);
            _dir = point_direction(owner.x, owner.y, _target.x, _target.y);
        }
        xTo = owner.x + lengthdir_x(8, _dir + random_range(-4, 4));
        yTo = owner.y + lengthdir_y(8, _dir + random_range(-4, 4));
        image_xscale = mouse_x > owner.x ? 1 : -1;
        
        attackStateTimer += DT;
        if (distance_to_point(xTo, yTo) < 2)
        {
            if (attackStateTimer >= 0.12 / GetStandSpeed(self))
            {
                var _snd = jj_play_audio(global.sndPunchAir, 0, false);
                var _sHit = choose(global.sndKcAttack1, global.sndKcAttack2, global.sndKcAttack3, global.sndKcAttack4, global.sndKcAttack5);
                audio_sound_pitch(_snd, random_range(0.9, 1.1));
                var xx = x + random_range(-4, 4);
                var yy = y + random_range(-8, 8);
                var _p = PunchSwingCreate(xx, yy, _dir, 45, GetDmg(s));
                with (_p)
                {
                    onHitSound = _sHit;
                    onHitSoundOverlap = true;
                    knockback = 0;
                }
                attackStateTimer = 0;
            }
            skills[s, StandSkill.ExecutionTime] += DT;
        }
        
        if (keyboard_check_pressed(ord(skills[s, StandSkill.Key])))
        {
            if (skills[s, StandSkill.ExecutionTime] > 0)
            {
                FireCD(s);
            }
            else
            {
                ResetCD(s);
            }
            state = StandState.Idle;
        }
    break;
}

#define KceChop(m, s)

var _dis = point_distance(player.x, player.y, mouse_x, mouse_y);
var _dir = point_direction(player.x, player.y, mouse_x, mouse_y)

var _xx = player.x + lengthdir_x(GetStandReach(self), _dir);
var _yy = player.y + lengthdir_y(GetStandReach(self), _dir);
xTo = _xx;
yTo = _yy;
image_xscale = mouseXSide;

switch (attackState)
{
    case 0:
        angleTarget = -10 * image_xscale;
        if (attackStateTimer >= 0.4)
        {
            KcePlayRandomScream();
            attackState++;
        }
    break;
    case 1:
        var _snd = jj_play_audio(global.sndPunchAir, 0, false);
        audio_sound_pitch(_snd, random_range(0.9, 1.1));
        var _p = PunchSwingCreate(x, y, _dir, 45, GetDmg(s));
        _p.onHitSound = global.sndKcAttack5;
        attackState++;
    break;
    case 2:
        angleTarget = 10 * image_xscale;
        if (attackStateTimer >= 0.6)
        {
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define KceHeavyChop(m, s)

switch (attackState)
{
    case 0:
        if (enemy_instance_exists())
        {
            var _n = get_nearest_enemy(mouse_x, mouse_y);
            if (distance_to_object(_n) < (armChopRange * GetStandRange(self)))
            {
                x = _n.x;
                y = _n.y;
                KcePlayRandomScream();
                jj_play_audio(global.sndKcGrowl, 5, false);
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
        var _t = owner;
        armChopShow = true;
        if (enemy_instance_exists())
        {
            _t = get_nearest_enemy(x, y);
        }
        else
        {
            armChopShow = false;
            ResetAtk(s);
        }
        if (distance_to_object(owner) > (armChopRange * GetStandRange(self)))
        {
            armChopShow = false;
            ResetAtk(s);
        }
        xTo = _t.x - 8;
        yTo = _t.y - 8;
        height = attackStateTimer * 3;
        angleTarget = attackStateTimer * 5;
        if (attackStateTimer > 3)
        {
            var _dir = point_direction(x, y, _t.x, _t.y);
            var _p = PunchSwingCreate(x, y, _dir, 45, GetDmg(s) + (_t.hpMax * 0.1));
            with (_p)
            {
                onHitSound = global.sndKcArmChop;
                onHitSoundOverlap = true;
                knockback = 2;
            }
            var _c = EffectCircleCreate(_t.x, _t.y, 32, 4);
            _c.color = c_red;
            _c.lifeMulti = 2;
            repeat (10)
            {
                EffectArmChopCreate(_t.x, _t.y).lifeMulti = 2;
            }
            attackState++;
        }
    break;
    case 2:
        height = 2;
        angleTarget = -45;
        angleTargetSpd = 0.5;
        if (attackStateTimer > 3.2)
        {
            armChopShow = false;
            EndAtk(s);
        }
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define KceEpitaph(m, s)

epitaphActive = true;
epitaphTimer = 10 * GetStandTotalPower(self);
var _e = EffectCircleCreate(x, y, 32, 4);
_e.color = colorAlt;
jj_play_audio(global.sndKcEpitaph, 5, false)
EndAtk(s);

#define KceTimeErase(m, s)

xTo = owner.x;
yTo = owner.y - 8;

switch (attackState)
{
    case 0:
        jj_play_audio(teSound, 5, false);
        attackState++;
    break;
    case 1:
        WorldControl.x += random_range(-2, 2);
        WorldControl.y += random_range(-2, 2);
        if (attackStateTimer >= 1)
        {
            attackState++;
        }
    break;
    case 2:
        EffectTimeSkipCreate();
        var o = ModObjectSpawn(x, y, -100000);
        with (o)
        {
            type = "timeErase";
            daBass = jj_play_audio(other.teBassSound, 5, false);
            endSound = other.teEndSound;
            surf = 0;
            
            xscale = 1;
            yscale = 1;
            color = c_fuchsia;
            alpha = 1;
            life = 13;
            
            InstanceAssignMethod(self, "step", ScriptWrap(TimeEraseStep));
            InstanceAssignMethod(self, "draw", ScriptWrap(TimeEraseDraw));
        }
        EndAtk(s);
    break;
}
attackStateTimer += DT * GetStandSpeed(self);

#define GiveKce(_owner) //stand

var _s = GiveKingCrimson(_owner);
with (_s)
{
    sprite_index = global.sprKCE;
    name = "King Crimson Enderman";
    color = 0xba7bd7;
    colorAlt = 0x342022;
    UpdateRarity(Rarity.Ascended);
    saveKey = "jjbamKce";
    
    soundWhenHurt = [
        global.sndKceHurt1,
        global.sndKceHurt2,
        global.sndKceHurt3,
        global.sndKceHurt4
    ];
    soundWhenDead = global.sndKceDeath;
    auraParticleSprite = global.sprStandParticle2;
    summonSound = [
        global.sndKceIdle1,
        global.sndKceIdle2,
        global.sndKceIdle3,
        global.sndKceIdle4,
        global.sndKceIdle5
    ];
    teBassSound = global.sndKceStare;
    
    skills[StandState.SkillAOff, StandSkill.Skill] = KceScalpelSlash;
    skills[StandState.SkillBOff, StandSkill.Skill] = KceScalpelThrow;
    skills[StandState.SkillA, StandSkill.Skill] = KceBarrage;
    skills[StandState.SkillB, StandSkill.Skill] = KceChop;
    skills[StandState.SkillB, StandSkill.SkillAlt] = KceHeavyChop;
    skills[StandState.SkillC, StandSkill.Skill] = KceTimeSkip;
    skills[StandState.SkillD, StandSkill.Skill] = KceEpitaph;
    skills[StandState.SkillD, StandSkill.SkillAlt] = KceTimeErase;
}
return _s;

#define KcePlayRandomScream

var _screams = [
    global.sndKceScream1,
    global.sndKceScream2,
    global.sndKceScream3,
    global.sndKceScream4,
]
var _s = irandom(array_length(_screams) - 1);
jj_play_audio(_screams[_s], 5, false);
