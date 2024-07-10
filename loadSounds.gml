
var p = ""; // path short

p = "Resources/Sounds/DIO/";
global.sndDioSpawn = audio_create_stream(p + "dioSpawn.ogg");
global.sndDioDeath = audio_create_stream(p + "dio_death.ogg");

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
global.sndHeavyPunch = audio_create_stream(p + "heavyPunch.ogg");
global.sndRevFire1 = audio_create_stream(p + "revFire1.ogg");
global.sndRevFire2 = audio_create_stream(p + "revFire2.ogg");
global.sndRevFire3 = audio_create_stream(p + "revFire3.ogg");
global.sndRevFire4 = audio_create_stream(p + "revFire4.ogg");
global.sndRevReload = audio_create_stream(p + "revReload.ogg");

#endregion

#region star platinum

p = "Resources/Sounds/SP/";
global.sndSpSummon = audio_create_stream(p + "spSummon.ogg");
global.sndSpBarrage = audio_create_stream(p + "spBarrage.ogg");
global.sndSpTs = audio_create_stream(p + "spTs.ogg");
global.sndSpOpenSoda = audio_create_stream(p + "spOpenSoda.ogg");
global.sndSpStrongPunch = audio_create_stream(p + "spStrongPunch.ogg");
global.sndSpStarFinger = audio_create_stream(p + "spStarFinger.ogg");

// spova
p = "Resources/Sounds/SP/OVA/";
global.sndSpovaSummon = audio_create_stream(p + "spovaSummon.ogg");
global.sndSpovaBarrage = audio_create_stream(p + "spovaBarrage.ogg");
global.sndSpovaStrongPunch = audio_create_stream(p + "spovaStrongPunch.ogg");
global.sndSpovaTs = audio_create_stream(p + "spovaTs.ogg");

#endregion

#region star platinum retro

p = "Resources/Sounds/SPR/";
global.sndSprSummon = audio_create_stream(p + "sprSummon.ogg");
global.sndSprOra = audio_create_stream(p + "sprOra.ogg");
global.sndSprBarrage = audio_create_stream(p + "sprBarrage.ogg");
global.sndSprStarPlat = audio_create_stream(p + "sprStarPlat.ogg");
global.sndSprTokiyotomare = audio_create_stream(p + "sprTokiyotomare.ogg");
global.sndSprTsResume = audio_create_stream(p + "sprTsResume.ogg");
global.sndSprZawarudo = audio_create_stream(p + "sprZawarudo.ogg");
global.sndSprHurt1 = audio_create_stream(p + "sprHurt1.ogg");
global.sndSprHurt2 = audio_create_stream(p + "sprHurt2.ogg");
global.sndSprHurt3 = audio_create_stream(p + "sprHurt3.ogg");
global.sndSprDead = audio_create_stream(p + "sprDead.ogg");
global.sndSprTs = audio_create_stream(p + "sprTs.ogg");
global.sndSprStaar = audio_create_stream(p + "sprStaar.ogg");
global.sndSprFinger = audio_create_stream(p + "sprFinger.ogg");

#endregion

#region star platinum the world

p = "Resources/Sounds/SPTW/";
global.sndSptwTp = audio_create_stream(p + "sptwTp.ogg");
global.sndSptwTs = audio_create_stream(p + "sptwTs.ogg");

#endregion

#region estrella platinada

p = "Resources/Sounds/EP/";
global.sndEpSummon = audio_create_stream(p + "epSummon.ogg");
global.sndEpTs = audio_create_stream(p + "epTs.ogg");

#endregion

#region silver chariot

p = "Resources/Sounds/SC/";
global.sndScSummon = audio_create_stream(p + "scSummon.ogg");
global.sndScBarrage = audio_create_stream(p + "scBarrage.ogg");
global.sndScLunge = audio_create_stream(p + "scLunge.ogg");
global.sndScSweep = audio_create_stream(p + "scSweep.ogg");
global.sndScArmorOff = audio_create_stream(p + "scArmorOff.ogg");
global.sndScBladeOff = audio_create_stream(p + "scBladeOff.ogg");

#endregion

#region hierophant green

p = "Resources/Sounds/HG/";
global.sndHgEmeraldSplash = audio_create_stream(p + "hgEmeraldSplash.ogg");

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
global.sndStw2Summon = audio_create_stream(p + "stw2Summon.ogg");
global.sndStw2Desummon = audio_create_stream(p + "stw2Desummon.ogg");
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
global.sndStwHurt1 = audio_create_stream(p + "stwHurt1.ogg");
global.sndStwHurt2 = audio_create_stream(p + "stwHurt2.ogg");
global.sndStwHurt3 = audio_create_stream(p + "stwHurt3.ogg");
global.sndStwDead = audio_create_stream(p + "stwDead.ogg");

#endregion

#region the world

p = "Resources/Sounds/TW/";
global.sndTwSummon = audio_create_stream(p + "twSummon.ogg");
global.sndTwTs = audio_create_stream(p + "twTs.ogg");
global.sndStopSign = audio_create_stream(p + "stopSign.ogg");
global.sndTwBarrage = audio_create_stream(p + "twBarrage.ogg");

// ova
p = "Resources/Sounds/TW/OVA/";
global.sndTwovaSummon = audio_create_stream(p + "twovaSummon.ogg");
global.sndTwovaTs = audio_create_stream(p + "twovaTs.ogg");
global.sndTwovaBarrage = audio_create_stream(p + "twovaBarrage.ogg");
global.sndTwovaStrongPunch = audio_create_stream(p + "twovaStrongPunch.ogg");

#endregion

#region the world frozen

p = "Resources/Sounds/TWF/";
global.sndTwfSummon = audio_create_stream(p + "twfSummon.ogg");
global.sndTwfTs = audio_create_stream(p + "twfTs.ogg");
global.sndTwfTsResume = audio_create_stream(p + "twfTsResume.ogg");
global.sndTwfIdle1 = audio_create_stream(p + "twfIdle1.ogg");
global.sndTwfIdle2 = audio_create_stream(p + "twfIdle2.ogg");
global.sndTwfIdle3 = audio_create_stream(p + "twfIdle3.ogg");
global.sndTwfIdle4 = audio_create_stream(p + "twfIdle4.ogg");
global.sndTwfIdle5 = audio_create_stream(p + "twfIdle5.ogg");
global.sndTwfBarrage = audio_create_stream(p + "twfBarrage.ogg");

#endregion

#region the world over heaven

p = "Resources/Sounds/TWOH/";
global.sndTwohTs = audio_create_stream(p + "twohTs.ogg");
global.sndTwohHeal = audio_create_stream(p + "twohHeal.ogg");
global.sndTwohWave = audio_create_stream(p + "twohWave.ogg");
global.sndTwohTp = audio_create_stream(p + "twohTp.ogg");
global.sndTwohRealityOverwrite = audio_create_stream(p + "twohRealityOverwrite.ogg");

#endregion

#region the world retro

p = "Resources/Sounds/TWR/";
global.sndTwrSummon = audio_create_stream(p + "twrSummon.ogg");
global.sndTwrBarrage = audio_create_stream(p + "twrBarrage.ogg");
global.sndTwrTs = audio_create_stream(p + "twrTs.ogg");
global.sndTwrIdle1 = audio_create_stream(p + "twrIdle1.ogg");
global.sndTwrIdle2 = audio_create_stream(p + "twrIdle2.ogg");
global.sndTwrDrain = audio_create_stream(p + "twrDrain.ogg");
global.sndTwrMuda = audio_create_stream(p + "twrMuda.ogg");
global.sndTwrMudada = audio_create_stream(p + "twrMudada.ogg");
global.sndTwrBd1 = audio_create_stream(p + "twrBd1.ogg");
global.sndTwrBd2 = audio_create_stream(p + "twrBd2.ogg");

#endregion

#region the world alternate universe

p = "Resources/Sounds/TWAU/";
global.sndTwAuTs = audio_create_stream(p + "twauTs.ogg");
global.sndTwAuDiegoTs = audio_create_stream(p + "twauDiegoTs.ogg");
global.sndTwAuTsPanic = audio_create_stream(p + "twauTsPanic.ogg");
global.sndTwAuTsResume = audio_create_stream(p + "twauTsResume.ogg");

#endregion

#region neo

p = "Resources/Sounds/NEO/";
global.sndNeoTs = audio_create_stream(p + "neoTs.ogg");
global.sndNeoTsResume = audio_create_stream(p + "neoTsResume.ogg");

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
global.sndGeStab = audio_create_stream(p + "geStab.ogg");
global.sndGeBreak = audio_create_stream(p + "geBreak.ogg");
global.sndGeRequiem = audio_create_stream(p + "geRequiem.ogg");
// requiem
global.sndGerSummon = audio_create_stream(p + "gerSummon.ogg");
global.sndGerBarrage = audio_create_stream(p + "gerBarrage.ogg");
global.sndGerTaunt = audio_create_stream(p + "gerTaunt.ogg");

#endregion

#region king crimson

p = "Resources/Sounds/KC/";
global.sndKcSummon = audio_create_stream(p + "kcSummon.ogg");
global.sndKcTp = audio_create_stream(p + "kcTp.ogg");
global.sndKcArmChop = audio_create_stream(p + "kcArmChop.ogg");
global.sndKcGrowl = audio_create_stream(p + "kcGrowl.ogg");
global.sndKcAttack1 = audio_create_stream(p + "kcAttack1.ogg");
global.sndKcAttack2 = audio_create_stream(p + "kcAttack2.ogg");
global.sndKcAttack3 = audio_create_stream(p + "kcAttack3.ogg");
global.sndKcAttack4 = audio_create_stream(p + "kcAttack4.ogg");
global.sndKcAttack5 = audio_create_stream(p + "kcAttack5.ogg");
global.sndKcTe = audio_create_stream(p + "kcTe.ogg");
global.sndKcTeBass = audio_create_stream(p + "kcTeBass.ogg");
global.sndKcTeEnd = audio_create_stream(p + "kcTeEnd.ogg");

// kcm
p = "Resources/Sounds/KC/KCM/";
global.sndKcmSummon = audio_create_stream(p + "kcmSummon.ogg");
global.sndKcmTe = audio_create_stream(p + "kcmTe.ogg");
global.sndKcmTeBass = audio_create_stream(p + "kcmTeBass.ogg");
global.sndKcmTeEnd = audio_create_stream(p + "kcmTeEnd.ogg");

#endregion

#region kcau

p = "Resources/Sounds/KCAU/";
global.sndKcauSummon = audio_create_stream(p + "kcauSummon.ogg");
global.sndKcauTeStart = audio_create_stream(p + "kcauTeStart.ogg");
global.sndKcauTeEnd = audio_create_stream(p + "kcauTeEnd.ogg");
global.sndKcauStrike = audio_create_stream(p + "kcauStrike.ogg");
global.sndKcauEpitaph = audio_create_stream(p + "kcauEpitaph.ogg");

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

#region whitesnake

p = "Resources/Sounds/Pucci/WS/";
global.sndWsSummon = audio_create_stream(p + "wsSummon.ogg");
global.sndAcidicSpit = audio_create_stream(p + "wsAcidicSpit.ogg");
global.sndMeltYourHeart = audio_create_stream(p + "wsMeltYourHeart.ogg");
global.sndWsDiscSteal = audio_create_stream(p + "wsDiscSteal.ogg");

#endregion

#region soft and wet

p = "Resources/Sounds/SnW/";
global.sndSnwSummon = audio_create_stream(p + "snwSummon.ogg");
global.sndSnwBubble = audio_create_stream(p + "snwBubble.ogg");
global.sndSnwBubblePop = audio_create_stream(p + "snwBubblePop.ogg");
global.sndSnwBubbleBigPop = audio_create_stream(p + "snwBubbleBigPop.ogg");
global.sndSnwBubbleSummon = audio_create_stream(p + "snwBubbleSummon.ogg");
global.sndSnwBubbleThrow = audio_create_stream(p + "snwBubbleThrow.ogg");

#endregion

#region undertale

p = "Resources/Sounds/Undertale/";
global.sndSoulDamaged = audio_create_stream(p + "soul_damaged.ogg");

// sans
p = "Resources/Sounds/Undertale/Sans/";
global.sndSansVoice = audio_create_stream(p + "sans_voice.ogg");
global.sndSansTp = audio_create_stream(p + "sansTp.ogg");

#endregion
