
#region DIO

global.jjs_skin_dio_hair = CosmeticCreate(
    undefined,
    "jjs_skin_dio_hair",
    CosmeticType.Head,
    global.sprDIOIdleHead,
    global.sprDIOWalkHead,
    undefined,
    false
);
CosmeticEdit(global.jjs_skin_dio_hair, CosmeticData.Name, "dio's hair");

global.jjs_skin_dio_body = CosmeticCreate(
    undefined,
    "jjs_skin_dio_body",
    CosmeticType.Body,
    global.sprDIOIdle,
    global.sprDIOWalk,
    undefined,
    false
);
CosmeticEdit(global.jjs_skin_dio_body, CosmeticData.Name, "dio's body?");

#endregion
