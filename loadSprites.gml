
var p = ""; // path short

#region Items

p = "Resources/Sprites/Items/";
global.sprArrow = sprite_add(p + "Arrow.png", 1, false, false, 8, 8);
global.sprDisc = sprite_add(p + "Disc.png", 1, false, false, 8, 8);
global.sprDiscBlueprint = sprite_add(p + "DiscBlueprint.png", 1, false, false, 8, 8);
global.sprArrowBeetle = sprite_add(p + "ArrowBeetle.png", 1, false, false, 8, 8);
global.sprEternalArrow = sprite_add(p + "EternalArrow.png", 1, false, false, 8, 8);
global.sprHeart = sprite_add(p + "Heart.png", 1, false, false, 8, 8);
global.sprEye = sprite_add(p + "Eye.png", 1, false, false, 8, 8);
global.sprLeftArm = sprite_add(p + "LeftArm.png", 1, false, false, 8, 8);

#endregion

#region Generic

p = "Resources/Sprites/Generic/";
global.sprBulletGUI = sprite_add(p + "BulletGUI.png", 1, false, false, 16, 16);
global.sprRevCylinderGUI = sprite_add(p + "RevCylinderGUI.png", 1, false, false, 16, 16);
global.sprPunchEffect = sprite_add(p + "PunchEffect.png", 6, false, false, 8, 8);
global.sprStandParticle = sprite_add(p + "StandParticle.png", 1, false, false, 1, 1);

// projectiles
p = "Resources/Sprites/Generic/Projectiles/";
global.sprKnife = sprite_add(p + "Knife.png", 1, false, false, 8, 8);
global.sprBullet = sprite_add(p + "Bullet.png", 1, false, false, 1, 1);
global.sprAttackPunch = sprite_add(p + "AttackPunch.png", 1, false, false, 16, 16);

// skills
p = "Resources/Sprites/Generic/Skills/";
global.sprSkillTemplate = sprite_add(p + "SkillTemplate.png", 1, false, false, 16, 16);
global.sprSkillSkip = sprite_add(p + "SkillSkip.png", 1, false, false, 16, 16);
global.sprSkillHoldTemplate = sprite_add(p + "SkillHoldTemplate.png", 1, false, false, 16, 16);
global.sprSkillCooldown = sprite_add(p + "SkillCooldown.png", 1, false, false, 16, 16);
global.sprSkillHold = sprite_add(p + "SkillHold.png", 1, false, false, 16, 16);

global.sprSkillBarrage = sprite_add(p + "SkillBarrage.png", 1, false, false, 16, 16);
global.sprSkillStrongPunch = sprite_add(p + "SkillStrongPunch.png", 1, false, false, 16, 16);
global.sprSkillMeleePull = sprite_add(p + "SkillMeleeGrab.png", 1, false, false, 16, 16);

global.sprSkillGunShot = sprite_add(p + "SkillGunShot.png", 1, false, false, 16, 16);
global.sprSkillBulletVolley = sprite_add(p + "SkillVolleyShot.png", 1, false, false, 16, 16);
global.sprRevolverReload = sprite_add(p + "SkillRevolverReload.png", 1, false, false, 16, 16);

global.sprSkillTimestop = sprite_add(p + "SkillTimestop.png", 1, false, false, 16, 16);

#endregion

#region shadow dio's the world

p = "Resources/Sprites/STW/";
global.sprShadowTheWorld = sprite_add(p + "ShadowTheWorld.png", 1, false, false, 16, 19);
global.sprKnifeStw = sprite_add(p + "KnifeStw.png", 1, false, false, 8, 8);
global.sprStwPunch = sprite_add(p + "StwPunch.png", 1, false, false, 16, 16);
global.sprStwCharisma = sprite_add(p + "StwCharisma.png", 2, false, false, 8, 8);

// skills
global.sprSkillUry = sprite_add(p + "SkillUry.png", 1, false, false, 16, 16);
global.sprSkillSRSE = sprite_add(p + "SkillSRSE.png", 1, false, false, 16, 16);
global.sprSkillDivineBlood = sprite_add(p + "SkillDivineBlood.png", 1, false, false, 16, 16);
global.sprSkillCharisma = sprite_add(p + "SkillCharisma.png", 1, false, false, 16, 16);
global.sprSkillXXI = sprite_add(p + "SkillXXI.png", 1, false, false, 16, 16);
global.sprSkillPunishment = sprite_add(p + "SkillKnifeCoffin.png", 1, false, false, 16, 16);
global.sprSkillStwKnifes = sprite_add(p + "SkillStwKnifes.png", 1, false, false, 16, 16);
global.sprSkillTimestopStw = sprite_add(p + "SkillTimestopStw.png", 1, false, false, 16, 16);
global.sprSkillStwTw = sprite_add(p + "SkillStwTw.png", 1, false, false, 16, 16);

#endregion

#region anubis

p = "Resources/Sprites/Anubis/";
global.sprAnubis = sprite_add(p + "Anubis.png", 1, false, false, 16, 19)
global.sprHorizontalSlash = sprite_add(p + "HorizontalSlash.png", 1, false, false, 16, 16);

#endregion

#region the world

p = "Resources/Sprites/TW/";
global.sprTheWorld = sprite_add(p + "TheWorld.png", 1, false, false, 16, 19);
global.sprTheWorldPunch = sprite_add(p + "TheWorldPunch.png", 1, false, false, 16, 16);
global.sprStopSign = sprite_add(p + "StopSign.png", 1, false, false, 1, 16);

// skills
global.sprSkillJosephKnife = sprite_add(p + "SkillJosephKnife.png", 1, false, false, 16, 16);
global.sprSkillStopSign = sprite_add(p + "SkillStopSign.png", 1, false, false, 16, 16);
global.sprSkillTripleKnifeThrow = sprite_add(p + "SkillTripleKnifeThrow.png", 1, false, false, 16, 16);

#endregion

#region the world alternate universe

p = "Resources/Sprites/TWAU/";
global.sprTheWorldAU = sprite_add(p + "TheWorldAU.png", 1, false, false, 16, 19);

// skills
global.sprSkillKnifeBarrage = sprite_add(p + "SkillKnifeBarrage.png", 1, false, false, 16, 16);

#endregion

#region star platinum

p = "Resources/Sprites/SP/";
global.sprStarPlatinum = sprite_add(p + "StarPlatinum.png", 1, false, false, 16, 19);
global.sprStarPlatinumPunch = sprite_add(p + "StarPlatinumPunch.png", 1, false, false, 16, 16);
global.sprStarPlatinumFinger = sprite_add(p + "StarPlatinumFinger.png", 1, false, false, 1, 1);

// skills
global.sprSkillBarrageSp = sprite_add(p + "SkillBarrageSp.png", 1, false, false, 16, 16);
global.sprSkillStrongPunchSp = sprite_add(p + "SkillStrongPunchSp.png", 1, false, false, 16, 16);
global.sprSkillStarFinger = sprite_add(p + "SkillStarFinger.png", 1, false, false, 16, 16);
global.sprSkillTimestopSp = sprite_add(p + "SkillTimestopSp.png", 1, false, false, 16, 16);

    // star platinum the world
p = "Resources/Sprites/SP/SPTW/";
global.sprSptw = sprite_add(p + "SPTW.png", 1, false, false, 16, 19);

#endregion

#region dirty deeds done dirt cheap

p = "Resources/Sprites/D4C/";
global.sprD4C = sprite_add(p + "D4C.png", 1, false, false, 16, 19);
global.sprD4CPunch = sprite_add(p + "D4CPunch.png", 1, false, false, 16, 16);
global.sprD4CFlag = sprite_add(p + "D4CFlag.png", 1, false, false, 16, 16);

// skills
global.sprSkillCloneSwap = sprite_add(p + "SkillCloneSwap.png", 1, false, false, 16, 16);
global.sprSkillDoubleSlap = sprite_add(p + "SkillDoubleSlap.png", 1, false, false, 16, 16);
global.sprSkillCloneBomb = sprite_add(p + "SkillCloneBomb.png", 1, false, false, 16, 16);
global.sprSkillCloneSummon = sprite_add(p + "SkillCloneSummon.png", 1, false, false, 16, 16);
global.sprSkillDimensionalHop = sprite_add(p + "SkillDimensionalHop.png", 1, false, false, 16, 16);

    // love train
p = "Resources/Sprites/D4C/LT/";
global.sprD4CLT = sprite_add(p + "D4CLT.png", 1, false, false, 16, 19);

// skills
global.sprSkillBulletTime = sprite_add(p + "SkillBulletTime.png", 1, false, false, 16, 16);
global.sprSkillLoveTrain = sprite_add(p + "SkillLoveTrain.png", 1, false, false, 16, 16);

#endregion

#region killer queen

p = "Resources/Sprites/KQ/";
global.sprKillerQueen = sprite_add(p + "KillerQueen.png", 1, false, false, 16, 19);
global.sprCoin = sprite_add(p + "Coin.png", 1, false, false, 16, 16);
global.sprKqPunch = sprite_add(p + "KillerQueenPunch.png", 1, false, false, 16, 16);
global.sprBombEffect = sprite_add(p + "BombEffect.png", 1, false, false, 16, 16);
global.sprSHA = sprite_add(p + "SHA.png", 1, false, false, 16, 16);

// skills
global.sprSkillBarrageKq = sprite_add(p + "SkillBarrageKq.png", 1, false, false, 16, 16);
global.sprSkillFirstBomb = sprite_add(p + "SkillFirstBomb.png", 1, false, false, 16, 16);
global.sprSkillDetonate = sprite_add(p + "SkillDetonate.png", 1, false, false, 16, 16);
global.sprSkillCoinBomb = sprite_add(p + "SkillCoinBomb.png", 1, false, false, 16, 16);
global.sprSkillSHA = sprite_add(p + "SkillSHA.png", 1, false, false, 16, 16);

    // bites the dust
p = "Resources/Sprites/KQ/BTD/";
global.sprKillerQueenBtD = sprite_add(p + "KillerQueenBtD.png", 1, false, false, 16, 19);
global.sprScBubble = sprite_add(p + "Bubble.png", 1, false, false, 16, 16);
global.sprBtdStare = sprite_add(p + "BtDStare.png", 1, false, false, 16, 16);
global.sprBtdVoidTrace = sprite_add(p + "BtDVoidTrace.png", 1, false, false, 16, 1);

// skills
global.sprSkillStrayCat = sprite_add(p + "SkillStrayCat.png", 1, false, false, 16, 16);
global.sprSkillThirdBomb = sprite_add(p + "SkillThirdBomb.png", 1, false, false, 16, 16);
global.sprSkillBtD = sprite_add(p + "SkillBtD.png", 1, false, false, 16, 16);

#endregion

#region gold experience

p = "Resources/Sprites/GE/";
global.sprGoldExperience = sprite_add(p + "GoldExperience.png", 1, false, false, 16, 19);
global.sprGeFrog = sprite_add(p + "GeFrog.png", 1, false, false, 16, 16);
global.sprGeScorpion = sprite_add(p + "GeScorpion.png", 2, false, false, 16, 16);

// skills
global.sprSkillLifeFormPlant = sprite_add(p + "SkillLifeFormPlant.png", 1, false, false, 16, 16);
global.sprSkillLifeFormScorpion = sprite_add(p + "SkillLifeFormScorpion.png", 1, false, false, 16, 16);
global.sprSkillLifeFormFrog = sprite_add(p + "SkillLifeFormFrog.png", 1, false, false, 16, 16);
global.sprSkillSelfHeal = sprite_add(p + "SkillSelfHeal.png", 1, false, false, 16, 16);

#endregion

#region king crimson

p = "Resources/Sprites/KC/";
global.sprKingCrimson = sprite_add(p + "KingCrimson.png", 1, false, false, 16, 19);
// global.sprGeFrog = sprite_add(p + "GeFrog.png", 1, false, false, 16, 16);
// global.sprGeScorpion = sprite_add(p + "GeScorpion.png", 2, false, false, 16, 16);

// skills
// global.sprSkillLifeFormPlant = sprite_add(p + "SkillLifeFormPlant.png", 1, false, false, 16, 16);
// global.sprSkillLifeFormScorpion = sprite_add(p + "SkillLifeFormScorpion.png", 1, false, false, 16, 16);
// global.sprSkillLifeFormFrog = sprite_add(p + "SkillLifeFormFrog.png", 1, false, false, 16, 16);
// global.sprSkillSelfHeal = sprite_add(p + "SkillSelfHeal.png", 1, false, false, 16, 16);

#endregion

#region silver chariot

p = "Resources/Sprites/SC/";
global.sprSilverChariot = sprite_add(p + "SilverChariot.png", 1, false, false, 16, 19);
global.sprSCarmorless = sprite_add(p + "SilverChariotArmorless.png", 1, false, false, 16, 19);
global.sprScAttack = sprite_add(p + "SCAttack.png", 1, false, false, 16, 16);

#endregion

#region spin

p = "Resources/Sprites/StB/";
global.sprSteelBall = sprite_add(p + "SteelBall.png", 1, false, false, 8, 8);
global.sprSteelBallProj = sprite_add(p + "SteelBallProj.png", 1, false, false, 8, 8);

#endregion

#region sticky fingers

p = "Resources/Sprites/SF/";
global.sprStickyFingers = sprite_add(p + "StickyFingers.png", 1, false, false, 16, 19);
global.sprSfZipper = sprite_add(p + "SfZipper.png", 4, false, false, 16, 16);
global.sprSfPortal = sprite_add(p + "SfPortal.png", 4, false, false, 16, 16);

// skills
global.sprSkillZipperGrab = sprite_add(p + "SkillZipperGrab.png", 1, false, false, 16, 16);
global.sprSkillZipPortal = sprite_add(p + "SkillZipPortal.png", 1, false, false, 16, 16);


#endregion

#region tusk

p = "Resources/Sprites/Tusk/";
global.sprTuskAct1 = sprite_add(p + "TuskAct1.png", 1, false, false, 16, 19);
global.sprTuskAct2 = sprite_add(p + "TuskAct2.png", 1, false, false, 16, 19);
global.sprTuskAct3 = sprite_add(p + "TuskAct3.png", 1, false, false, 16, 19);
global.sprTuskAct4 = sprite_add(p + "TuskAct4.png", 1, false, false, 16, 19);
global.sprNailGUI = sprite_add(p + "NailGUI.png", 1, false, false, 16, 16);
global.sprNailVoid = sprite_add(p + "NailVoid.png", 1, false, false, 16, 16);

    // act 1
//skills
global.sprSkillSpinningNail = sprite_add(p + "SkillSpinningNail.png", 1, false, false, 16, 16);
global.sprSkillScratch = sprite_add(p + "SkillScratch.png", 1, false, false, 16, 16);
global.sprSkillHerbTea = sprite_add(p + "SkillHerbTea.png", 1, false, false, 16, 16);

    // act 2
// skills
global.sprSkillGoldenRectangleNail = sprite_add(p + "SkillGoldenNail.png", 1, false, false, 16, 16);
global.sprSkillDoubleGoldenRectangleNail = sprite_add(p + "SkillDoubleGoldenNail.png", 1, false, false, 16, 16);
global.sprSkillNailVoidRedirection = sprite_add(p + "SkillNailVoidRedirection.png", 1, false, false, 16, 16);
global.sprSkillWormholeNail = sprite_add(p + "SkillWormholeNail.png", 1, false, false, 16, 16);

    // act 4
// skills
global.sprSkillInfiniteRotation = sprite_add(p + "SkillInfiniteRotation.png", 1, false, false, 16, 16);

#endregion

#region imposter

p = "Resources/Sprites/SUS/";
global.sprImposter = sprite_add(p + "Imposter.png", 11, false, false, 16, 19);

// skills
global.sprSkillMeetingCall = sprite_add(p + "SkillMeetingCall.png", 1, false, false, 16, 16);
global.sprSkillKill = sprite_add(p + "SkillKill.png", 1, false, false, 16, 16);

#endregion

#region Pucci

p = "Resources/Sprites/Pucci/";

    // pucci
global.sprEnricoPucci = sprite_add(p + "EnricoPucci.png", 4, false, false, 16, 19);
    // whitesnake
global.sprWhiteSnake = sprite_add(p + "Whitesnake.png", 1, false, false, 16, 19);

    // c-moon
global.sprCMoon = sprite_add(p + "CMoon.png", 1, false, false, 16, 19);

#endregion

#region Alts

p = "Resources/Sprites/Alts/";
global.sprSpookyWorld = sprite_add(p + "SpookyWorld.png", 1, false, false, 16, 19);
global.sprSPR = sprite_add(p + "SPR.png", 1, false, false, 16, 19);
global.sprTWR = sprite_add(p + "TWR.png", 1, false, false, 16, 19);

#endregion

