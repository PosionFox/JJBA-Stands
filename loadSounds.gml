
var p = ""; // path short

#region generic stand

p = "Resources/Sounds/Generic/Stand/";
global.sndStandSummon = audio_create_stream(p + "standSummon.ogg");
global.sndTwTsResume = audio_create_stream(p + "tsResume.ogg");
global.sndTsOld = audio_create_stream(p + "tsOld.ogg");

#endregion

#region generic projectiles

p = "Resources/Sounds/Generic/Projectiles/";
global.sndPunchAir = audio_create_stream(p + "punchAir.ogg");
global.sndPunchHit = audio_create_stream(p + "punchHit.ogg");
global.sndKnifeThrow = audio_create_stream(p + "knifeThrow.ogg");
global.sndGunShot = audio_create_stream(p + "gunShot.ogg");
global.sndStrongPunch = audio_create_stream(p + "strongPunch.ogg");
global.sndRevFire1 = audio_create_stream(p + "revFire1.ogg");
global.sndRevFire2 = audio_create_stream(p + "revFire2.ogg");
global.sndRevFire3 = audio_create_stream(p + "revFire3.ogg");
global.sndRevFire4 = audio_create_stream(p + "revFire4.ogg");
global.sndRevReload = audio_create_stream(p + "revReload.ogg");

#endregion

#region star platinum

p = "Resources/Sounds/SP/";
global.sndSpSummon = audio_create_stream(p + "spSummon.ogg");
global.sndSpTs = audio_create_stream(p + "spTs.ogg");

#endregion

#region killer queen

p = "Resources/Sounds/KQ/";
global.sndKqSummon = audio_create_stream(p + "kqSummon.ogg");
global.sndBomb = audio_create_stream(p + "sndBomb.ogg");
global.sndClickBomb = audio_create_stream(p + "clickBomb.ogg");
global.sndDetonateBomb = audio_create_stream(p + "detonateBomb.ogg");
global.sndSHA = audio_create_stream(p + "sndSHA.ogg");

// bites the dust
p = "Resources/Sounds/KQ/BTD/";
global.sndKqbtdSummon = audio_create_stream(p + "kqbtdSummon.ogg");
global.sndBitesTheDust = audio_create_stream(p + "BitesTheDust.ogg");
global.sndStrayCat = audio_create_stream(p + "sndStrayCat.ogg");

#endregion

#region shadow the world

p = "Resources/Sounds/STW/";
global.sndStwSummon = audio_create_stream(p + "stwSummon.ogg");
global.sndStwKnifeThrow1 = audio_create_stream(p + "stwKnifeThrow1.ogg");
global.sndStwKnifeThrow2 = audio_create_stream(p + "stwKnifeThrow2.ogg");
global.sndStwSRSE = audio_create_stream(p + "stwSRSE.ogg");
global.sndStwUry = audio_create_stream(p + "stwUry.ogg");
global.sndStwCharisma = audio_create_stream(p + "stwCharisma.ogg");
global.sndStwDivineBlood = audio_create_stream(p + "stwDivineBlood.ogg");
global.sndStwEvolve = audio_create_stream(p + "stwEvolve.ogg");
global.sndStwLaugh1 = audio_create_stream(p + "stwLaugh1.ogg");
global.sndStwLaugh2 = audio_create_stream(p + "stwLaugh2.ogg");
global.sndStwNazimuzo = audio_create_stream(p + "stwNazimuzo.ogg");
global.sndStwTheWorld = audio_create_stream(p + "stwTheWorld.ogg");
global.sndStwTokiyotomare = audio_create_stream(p + "stwTokiyotomare.ogg");
global.sndStwTsResume = audio_create_stream(p + "stwTsResume.ogg");

#endregion

#region the world

p = "Resources/Sounds/TW/";
global.sndTwSummon = audio_create_stream(p + "twSummon.ogg");
global.sndTwTs = audio_create_stream(p + "twTs.ogg");
global.sndStopSign = audio_create_stream(p + "stopSign.ogg");

#endregion

#region the world alternate universe

p = "Resources/Sounds/TWAU/";
global.sndTwAuTs = audio_create_stream(p + "twauTs.ogg");

#endregion

#region dirty deeds done dirt cheap

p = "Resources/Sounds/D4C/";
global.sndD4CSummon = audio_create_stream(p + "d4cSummon.ogg");
global.sndCloneSummon = audio_create_stream(p + "cloneSummon.ogg");
global.sndDimensionalHop = audio_create_stream(p + "d4cDimensionalHop.ogg");

// love train
p = "Resources/Sounds/D4C/LT/";
global.sndD4CLTSummon = audio_create_stream(p + "d4cltSummon.ogg");
global.sndLoveTrain = audio_create_stream(p + "loveTrain.ogg");
global.sndLtStart = audio_create_stream(p + "ltStart.ogg");
global.sndLtLoop = audio_create_stream(p + "ltLoop.ogg");
global.sndLtEnd = audio_create_stream(p + "ltEnd.ogg");
global.sndLtPunish = audio_create_stream(p + "ltPunish.ogg");

#endregion

#region sticky fingers

p = "Resources/Sounds/SF/";
global.sndSfSummon = audio_create_stream(p + "sfSummon.ogg");
global.sndSfPunch = audio_create_stream(p + "sfPunch.ogg");
global.sndSfInjury = audio_create_stream(p + "sfInjury.ogg");
global.sndSfStrong = audio_create_stream(p + "sfStrong.ogg");
global.sndSfGrab = audio_create_stream(p + "sfGrab.ogg");
global.sndSfGrabReturn = audio_create_stream(p + "sfGrabReturn.ogg");
global.sndSfPortal = audio_create_stream(p + "sfPortal.ogg");
global.sndSfTp = audio_create_stream(p + "sfTp.ogg");

#endregion

#region gold experience

p = "Resources/Sounds/GE/";
global.sndGeSummon = audio_create_stream(p + "geSummon.ogg");
global.sndGeHit = audio_create_stream(p + "geHit.ogg");
global.sndGePunch = audio_create_stream(p + "gePunch.ogg");
global.sndGeLife = audio_create_stream(p + "geLife.ogg");

#endregion

#region imposter

p = "Resources/Sounds/SUS/";
global.sndImposterSummon = audio_create_stream(p + "AmogImposter.ogg");
global.sndAmogDead = audio_create_stream(p + "AmogDead.ogg");
global.sndAmogButton = audio_create_stream(p + "AmogButton.ogg");
global.sndAmogMurder = audio_create_stream(p + "AmogMurder.ogg");

#endregion

#region tusk

p = "Resources/Sounds/Tusk/";
global.sndTa1Summon = audio_create_stream(p + "ta1Summon.ogg");
global.sndTa2Summon = audio_create_stream(p + "ta2Summon.ogg");
global.sndTa3Summon = audio_create_stream(p + "ta3Summon.ogg");
global.sndTa4Summon = audio_create_stream(p + "ta4Summon.ogg");

#endregion


