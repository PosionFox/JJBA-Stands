
var _map = "spanish";
tr_init(_map);

#region items

tr_add(_map, "susArrowName", "flecha sospechosa");
tr_add(_map, "susArrowDescription", "parece una flecha normal.");

tr_add(_map, "rokakakaName", "rokakaka");
tr_add(_map, "rokakakaDescription", "una fruta puntiaguda.");

tr_add(_map, "rokakakaStewName", "estofado de rokakaka");
tr_add(_map, "rokakakaStewDescription", "un estofado picante.");

tr_add(_map, "requiemArrowName", "flecha requiem");
tr_add(_map, "requiemArrowDescription", "una flecha con un diseño bonito de un escarabajo.");

tr_add(_map, "eternalArrowName", "flecha eterna");
tr_add(_map, "eternalArrowDescription", "parece una flecha sospechosa pero más ominosa.");

tr_add(_map, "discBlueprintName", "plano de disco");
tr_add(_map, "discBlueprintDescription", "contiene información necesaria para crear discos sintéticos en una fábrica sin un whitesnake.");

tr_add(_map, "discName", "disco");
tr_add(_map, "discDescription", "un disco para remover y almacenar datos.");

tr_add(_map, "steelBallName", "bola de acero");
tr_add(_map, "steelBallDescription", "aprende los caminos de spin.");

tr_add(_map, "anubisName", "anubis");
tr_add(_map, "anubisDescription", "anubis es el stand más fuerte!.");

tr_add(_map, "heartName", "corazón");
tr_add(_map, "heartDescription", "el corazón del santo.");

tr_add(_map, "eyeName", "ojo");
tr_add(_map, "eyeDescription", "el ojo del santo.");

tr_add(_map, "leftArmName", "brazo izquierdo");
tr_add(_map, "leftArmDescription", "el brazo izquierdo del santo.");

tr_add(_map, "prayerBeadsName", "rosario");
tr_add(_map, "prayerBeadsDescription", "invoca a enrico pucci.");

tr_add(_map, "standDiscName", "disco:");
tr_add(_map, "standDiscDescription", "el disco dice: ");

tr_add(_map, "diosDiaryName", "diario de dio");
tr_add(_map, "diosDiaryDescription", "contiene los secretos de la ascensión.");

tr_add(_map, "diosBoneName", "hueso de dio");
tr_add(_map, "diosBoneDescription", "un antiguo hueso de un difunto vampiro.");

tr_add(_map, "egyptianCrownName", "corona egipcia");
tr_add(_map, "egyptianCrownDescription", "invoca a dio durante la noche.");

tr_add(_map, "runeRemoverName", "removedor de runas");
tr_add(_map, "runeRemoverDescription", "remueve tus runas.");

tr_add(_map, "shardName", "fragmento");
tr_add(_map, "shardDescription", "La fragmentación de lo olvidado, usado para crear nuevas habilidades.");

tr_add(_map, "concentratedArrowName", "flecha concentrada");
tr_add(_map, "concentratedArrowDescription", "Le da al usuario una habilidad específica.");

tr_add(_map, "bizarreCandyName", "dulce bizarro");
tr_add(_map, "bizarreCandyDescription", "Un dulce que se ve bizarro.");

tr_add(_map, "deliciousDirkName", "puñal delicioso");
tr_add(_map, "deliciousDirkDescription", "Se ve delicioso pero peligroso.");

tr_add(_map, "suspiciousBoltName", "perno sospechoso");
tr_add(_map, "suspiciousBoltDescription", "se ve como un perno sospechoso.");



tr_add(_map, "requiemArrowMerge", "la flecha se fusiona con el stand!");
tr_add(_map, "requiemArrowRefuse", "no pasa nada...");

tr_add(_map, "holyPartRefuse", "la parte sagrada se rehusa a interactuar contigo");

#endregion

#region estructuras

tr_add(_map, "diosCoffinName", "ataúd de dio");
tr_add(_map, "diosCoffinDescription", "despierta al vampiro");

tr_add(_map, "shardsTableName", "mesa de fragmentos");
tr_add(_map, "shardsTableDescription", "crea nuevas habilidades usando fragmentos.");

tr_add(_map, "offeringPillarName", "pilar de ofrendas");
tr_add(_map, "offeringPillarDescription", "crea habilidades únicas.");

#endregion

tr_add(_map, "dmgDisplay", "daño");

#region tiers

tr_add(_map, "commonName", "común");
tr_add(_map, "uncommonName", "poco común");
tr_add(_map, "rareName", "raro");
tr_add(_map, "epicName", "épico");
tr_add(_map, "legendaryName", "legendario");
tr_add(_map, "mythicalName", "mítico");
tr_add(_map, "celestialName", "ascendido");
tr_add(_map, "ultimateName", "supremo");
tr_add(_map, "eventName", "evento");

#endregion

#region stand abilities

#region part 3

// stw
tr_add(_map, "uryDesc", "uryyy:\nembiste hacia adelante golpeando enemigos en el camino.");
tr_add(_map, "srseDesc", "ojos picadores de destripacion espacial:\ndispara dos láseres perforantes a gran velocidad.");
tr_add(_map, "divineBloodDesc", "sangre divina:\ndrena la vida del objetivo y cura al usuario.");
tr_add(_map, "charismaDesc", "carisma:\nlibera esporas vampíricas que persiguen a los enemigos.");
tr_add(_map, "xxiDesc", "xxi:\nejecuta un combo de dos golpes y un fuerte puñetazo final.");
tr_add(_map, "punishmentDesc", "castigo:\ncarga un ataque que al impactar rodea al enemigo con cuchillos.");
tr_add(_map, "throwingKnifesDesc", "lanzando cuchillos:\nlanza dos ráfagas de cuchillos.");
tr_add(_map, "stwTimestopDesc", @"el poder secreto de the world:
detiene el tiempo por un breve momento,
la mayoria de los enemigos no pueden moverse
y tus proyectiles se congelaran donde están.

(mantener) the world:
con suficiente experiencia,
shadow the world evoluciona a the world.");

// sc
tr_add(_map, "scBarrageDesc", "bombardeo de puñaladas:\nlanza un bombardeo de estocadas.");
tr_add(_map, "scLungeDesc", "estocada:\nsalta hacia adelante con una fuerte puñalada.");
tr_add(_map, "scSweepDesc", "barrido:\ncorta adelante con un ataque rastrillante.");
tr_add(_map, "ftlDesc", @"más rapido que la luz:
silver chariot se quita su armadura,
proporcionandole una gran velocidad de ataque
y tiempos de enfriamentos más cortos.");

// hg
tr_add(_map, "emeraldSplashDesc", "salpicadura esmeralda:\ndispara un corto bombardeo de esmeraldas adelante.");
tr_add(_map, "hierophantBarrierDesc", "barrera hierofante:\ncrea una barrera alrededor del usuario\ndaña al contacto.");
tr_add(_map, "emeraldSplash20MetersDesc", "salpicadura esmeralda de 20 metros:\ndispara un potente bombardeo de esmeraldas adelante.");

// sp
tr_add(_map, "diosKnifeDesc", "cuchillo de dio:\nlanza uno de los cuchillos de dio.");
tr_add(_map, "barrageDesc", "bombardeo:\nlanza un bombardeo de golpes.");
tr_add(_map, "spStrongPunchDesc", @"puñetazo fuerte:
carga y libera un golpe fuerte.

(mantener) tirón de melé:
jala el enemigo hacia ti.");
tr_add(_map, "starFingerDesc", "dedo estrella:\nstar platinum estira su dedo golpeando enemigos en el camino.");
tr_add(_map, "spTimestopDesc", @"parada de tiempo:
detiene el tiempo, la mayoria de los enemigos no pueden moverse
y tus proyectiles se congelaran donde están.

(mantener) star platinum: the world:
con suficiente experiencia,
star platinum evoluciona a star platinum: the world.");

// tw
tr_add(_map, "josephKnifeDesc", "cuchillo de joseph:\nlanza un cuchillo que causa sangrado al impactar.");
tr_add(_map, "stopSignDesc", "señal de pare:\ngolpea con una señal de pare.");
tr_add(_map, "bloodDrainDesc", "drenado de sangre:\ndrena la vida del objetivo y cura al usuario.");
tr_add(_map, "strongPunchDesc", "puñetazo fuerte:\ncarga y libera un golpe fuerte.");
tr_add(_map, "knifeWallDesc", "pared de cuchillos:\nlanza una pared de cuchillos.");
tr_add(_map, "twTimestopDesc", "tiempo, detente!:\ndetiene el tiempo, la mayoria de los enemigos no pueden moverse\ny tus proyectiles se congelaran donde están.");

#endregion

#region part 4

// sptw
tr_add(_map, "sodaDesc", "soda:\nbebe de una refrescante lata de soda.");
tr_add(_map, "bearingShotDesc", "tiro:\nlanza un proyectil hacia adelante.");
tr_add(_map, "tsTpDesc", "teleportación de parada de tiempo:\nteletransportate a donde esta tu cursor.");
tr_add(_map, "sptwTimestopDesc", "estrella platinada: el mundo!:\ndetiene el tiempo, la mayoria de los enemigos no pueden moverse\ny tus proyectiles se congelaran donde están.");


// kq
tr_add(_map, "detonateBombDesc", "detonar bomba:\nexplota cualquier bomba ya colocada.");
tr_add(_map, "placeBombDesc", "la primera bomba de killer queen:\ncoloca una bomba en el enemigo más cercano o en el suelo.");
tr_add(_map, "coinBombDesc", "moneda bomba:\nlanza una moneda que puede ser detonada.");
tr_add(_map, "shaSummonDesc", "la segunda bomba de killer queen:\ninvoca a sheer heart attack al combate,\npersiguiendo y explotando enemigos por si mismo.");

// kqbtd
tr_add(_map, "theWealthyDesc", "el adinerado:\nlanza tres monedas hacia adelante, estas pueden ser detonadas.");
tr_add(_map, "strayCatDesc", "gato extraviado:\nlibera una burbuja explosiva controlable.");
tr_add(_map, "thirdBombDesc", @"la tercera bomba de killer queen:
coloca una bomba especial en el suelo.

(despues de lanzar) bites the dust:
detona la bomba especial dañando a todos los enemigos cercanos,
devuelve al usuario a la posicion original
donde colocaron la bomba en primer lugar mientras que
cura al usuario por la cantidad de salud perdida.
");

#endregion

#region part 5

// ge
tr_add(_map, "lifeformPlantDesc", "forma de vida, planta:\ninvoca una planta aleatoria.");
tr_add(_map, "lifeformScorpionDesc", "forma de vida, escorpión:\ninvoca un escorpión que ataca a enemigos cercanos.");
tr_add(_map, "lifeformFrogDesc", "forma de vida, rana:\ninvoca una rana que protege y refleja daño.");
tr_add(_map, "lifePunchDesc", "puñetazo de vida:\ngolpea al enemigo y extrae su alma,\nel alma daña a los otros enemigos.");
tr_add(_map, "selfHealDesc", "auto curación:\ncura las heridas del usuario,\nla efectividad de la curación esta atado al nivel del usuario.");

// ger
tr_add(_map, "requiemDesc", "requiem:\ndespierta tu stand.");
tr_add(_map, "gerBarrageDesc", "bombardeo nulo:\nlanza un destructivo bombardeo de golpes.");
tr_add(_map, "scorpionTossDesc", "lanzamiento de escorpión:\nlanza una roca la cual se\ntransforma en un escorpión al impactar.");

// kc
tr_add(_map, "scalpelSlashDesc", "corte de bisturí:\ntalla a tus enemigos y provocales sangrado.");
tr_add(_map, "scalpelThrowDesc", "lanzamiento de bisturí:\nlanza dos bisturís hacia adelante.");
tr_add(_map, "kcBarrageDesc", @"bombardeo de salto:
salta el tiempo hasta el enemigo mas cercano
liberando una serie de golpes fatales.");
tr_add(_map, "chopDesc", @"cortar:
corta al enemigo por daño moderado.

(mantener) corte profundo:
carga un golpe terrible que esta atado a
dañar seriamente hasta el oponente más duro.");
tr_add(_map, "timeSkipDesc", "salto de tiempo:\nsalta el tiempo adelante hasta una nueva posición.");
tr_add(_map, "timeEraseDesc", "borrar tiempo:\nborra un marco de tiempo, nadie sabrá lo que ocurrió.");

// sf
tr_add(_map, "sfBarrageDesc", "bombardeo pegajoso:\nlanza un bombardeo de golpes.\ninflige cremalleras dañinas al enemigo.");
tr_add(_map, "zipperPunchDesc", "puñetazo cremallera:\ncarga y libera un golpe fuerte.\ninflige cremalleras dañinas al enemigo.");
tr_add(_map, "zipperGrabDesc", "agarre de cremallera:\ndesarticula y lanza su brazo hacia adelante\nagarrando y tirando del primer enemigo que toca.");
tr_add(_map, "portalThroughDesc", "portal a través:\nabre dos portales, uno debajo del usuario\ny el otro a donde esta apuntando.");

#endregion

#region part 6

// ws
tr_add(_map, "suddenStrikeDesc", "golpe súbito:\nlanza un ataque sorpresa.");
tr_add(_map, "explosiveSurpriseDesc", "sorpresa explosiva:\nlanza un disco explosivo hacia adelante.");
tr_add(_map, "discProduceDesc", "producir disco:\nwhitesnake produce un disco vacío nuevo.");
tr_add(_map, "meltYourHeartDesc", "derrite tu corazón:\nlibera un ilusorio charco de ácido.");
tr_add(_map, "wsBarrageDesc", "bombardeo ácido:\nlanza un bombardeo a distancia de golpes ácidos.");
tr_add(_map, "quickDisposalDesc", "desecho rápido:\ndescarga un voleo de balas hacia adelante.");
tr_add(_map, "acidicSpitDesc", "escupitajo ácido:\nescupe un proyectil hacia adelante que inflige daño con el tiempo.");
tr_add(_map, "discStealDesc", "robo de disco:\nroba el disco de memoria del objetivo volviéndolos inútiles.");

#endregion

#region part 7

// d4c
tr_add(_map, "revolverReloadDesc", "recargar revolver:\nrecarga tu revolver.");
tr_add(_map, "bulletVolleyDesc", "voleo de balas:\ndispara un voleo de tres proyectiles.");
tr_add(_map, "cloneSwapDesc", "cambio de clon:\ncambia de lugares con el clon más cercano que apuntes.");
tr_add(_map, "doubleSlapDesc", "doble bofetada:\nflota hacia adelante y bofetea a los enemigos dos veces,\nel segundo bofeteo inflige más daño.");
tr_add(_map, "clonesDesc", @"clon bomba:
invoca un clon del enemigo donde apuntes que
persigue el objetivo y explota al contacto.

(mantener) invocación de clon:
invoca clones del usuario para ayudarlo en combate,
la cantidad de clones depende del nivel del usuario.");
tr_add(_map, "dimensionalHopDesc", @"brinco dimensional:
saca la bandera y la ondea
aplanando la usuario y llevandolo
a otra dimensión paralela,
enemigos en rango también se teletransportan.");

// d4clt
tr_add(_map, "trickShotDesc", @"disparo con efecto:
dispara un proyectil adelante.

(despues de lanzar) tiempo bala:
redirecciona el proyectil al enemigo más cercano.");
tr_add(_map, "slashingStrikesDesc", @"golpes cortantes:
lanza un bombardeo corto de golpes que infligen sangrado.

(mantener) tirón de melé:
jala el enemigo hacia ti.");
tr_add(_map, "loveTrainDesc", @"tren del amor:
invoca una dimensión de bolsillo como una pared de luz
que refleja todo el daño devuelta al enemigo más cercano.

(mantener) brinco dimensional:
saca la bandera y la ondea
aplanando la usuario y llevandolo
a otra dimensión paralela,
enemigos en rango también se teletransportan.");

// twau
tr_add(_map, "tripleKnifeDesc", "cuchillos triples:\nlanza tres cuchillos a la vez.");
tr_add(_map, "knifeBarrageDesc", "bombardeo de cuchillos:\nlanza un bombardeo de cuchillos.");
tr_add(_map, "twauTimestopDesc", @"es mi hora!:
detiene el tiempo, la mayoria de los enemigos no pueden moverse
y tus proyectiles se congelaran donde están.

(salud baja) parada de tiempo de pánico:
el usuario entra en pánico debido a su salud baja
y realiza una parada de tiempo más larga.");

#endregion

#region part 8

// snw
tr_add(_map, "moisturePlunderDesc", "saqueo de humedad:\ncrea una barrera de burbujas a tu alrededor\nlas burbujas dañan a los enemigos que las tocan.");
tr_add(_map, "shovelDesc", "pala:\nsaca una pala y golpealos con ella!.");
tr_add(_map, "bubbleShieldDesc", "burbuja escudo:\ncrea un escudo burbuja que\nte protege de cualquier daño.");
tr_add(_map, "bubbleBarrageDesc", "bombardeo de burbujas:\nlanza un bombardeo de burbujas adelante.");
tr_add(_map, "screwsAndNutsDesc", "tornillos y tuercas:\nlanza una burbuja llena de tornillos y tuercas\nque explota al contacto.");
tr_add(_map, "bubbleTrapDesc", "trampa burbuja:\nlanza una barba que atrapa a los enemigos al impactar.");

#endregion

#region other

// twoh
tr_add(_map, "realityHealDesc", "curación de realidad:\nrevierte tus heridas a un estado anterior.");
tr_add(_map, "twohBarrageDesc", @"bombardeo ascendido:
lanza un bombardeo de golpes ascendidos.

(mantener) ola estruendosa:
libera una ola explosiva adelante.");
tr_add(_map, "meleeComboDesc", @"combo melé:
lanza una ráfaga de golpes.

(mantener) golpe que sobreescribe la realidad:
carga un ataque pesado que hace
daño porcentual.");
tr_add(_map, "lightningKnifesDesc", @"cuchillos relámpago:
lanza tres cuchillos adelante que
electrocutan a los enemigos golpeados.

(mantener) entierro de cuchillos:
rodea al enemigo más cercano de tu cursor
con cuchillos letales.");
tr_add(_map, "twohTimestopDesc", @"parada de tiempo ascendida:
detiene el tiempo, la mayoria de los enemigos no pueden moverse
y tus proyectiles se congelaran donde están,
detiene y reanuda a voluntad.");

// sus
tr_add(_map, "knifesDesc", @"cuchillos:
lanza algunos cuchillos.");
tr_add(_map, "meetingCallDesc", @"llamada de reunión:
presiona un botón que daña enemigos.");
tr_add(_map, "killDesc", @"matar:
se teletransporta a un enemigo cercano y los daña gravemente.");

#endregion

#endregion

#region npcs and quests

tr_add(_map, "questPucci1Talk1", "vine aquí con fines de investigación");
tr_add(_map, "questPucci1Talk2", "necesito que recolectes algo para mi");
tr_add(_map, "questPucci1Talk3", "buen trabajo");
tr_add(_map, "questPucci1Talk4", "toma esto, ya no lo necesito");

tr_add(_map, "questPucci2Talk1", "ya estoy de vuelta");
tr_add(_map, "questPucci2Talk2", "necesito mas muestras");
tr_add(_map, "questPucci2Talk3", "bien hecho");
tr_add(_map, "questPucci2Talk4", "aqui está tu recompensa");

#endregion

#region runes

tr_add(_map, "runeOf", "runa de");

tr_add(_map, "runeStandMightName", "poderío stand");
tr_add(_map, "runeStandMightDesc", "incrementa el daño en un");

tr_add(_map, "runeReachName", "alcance");
tr_add(_map, "runeReachDesc", "incrementa el alcance de stand en un");

tr_add(_map, "runeMendingName", "reparación");
tr_add(_map, "runeMending1Desc", "cura increiblemente lento.");
tr_add(_map, "runeMending2Desc", "cura muy lentamente.");
tr_add(_map, "runeMending3Desc", "cura lentamente.");
tr_add(_map, "runeMending4Desc", "cura moderadamente.");
tr_add(_map, "runeMending5Desc", "cura ligeramente rápido.");
tr_add(_map, "runeMending6Desc", "cura rápido.");
tr_add(_map, "runeMending7Desc", "cura muy rápido.");
tr_add(_map, "runeMending8Desc", "cura increiblemente rápido.");

tr_add(_map, "runeEnergizeName", "energizar");
tr_add(_map, "runeEnergizeDesc", "te permite utilizar energía en lugar de enfriamientos, esta runa contiene la siguiente energía:");

#endregion

#region cross modding

tr_add(_map, "dioGrimoireName", "grimorio de dio");
tr_add(_map, "dioGrimoireDescription", "invoca a dio sin costo.");

#endregion
