
global.sprBizarreCandy = sprite_add("Seasonal/Christmas/BizarreCandy.png", 1, false, false, 8, 8);
global.sprDeliciousDirk = sprite_add("Seasonal/Christmas/DeliciousDirk.png", 1, false, false, 8, 8);
global.sprOfferingPillar = sprite_add("Seasonal/Christmas/OfferingPillar.png", 1, false, false, 8, 24);
global.sprOfferingPillarWorn = sprite_add("Seasonal/Christmas/OfferingPillarWorn.png", 1, false, false, 8, 24);

global.jjsBizarreCandy = ItemCreate(
    undefined,
    "jjsBizarreCandy",
    "",
    global.sprBizarreCandy,
    ItemType.Material,
    ItemSubType.None,
    4,
    0,
    0,
    undefined,
    ScriptWrap(EventHandler),
    60 * 30,
    true
);
ItemEdit(global.jjsBizarreCandy, ItemData.Name, tr("bizarreCandyName"));
ItemEdit(global.jjsBizarreCandy, ItemData.Description, tr("bizarreCandyDescription"));

global.jjsDeliciousDirkTWF = ItemCreate(
    undefined,
    "jjsDeliciousDirkTWF",
    "",
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjsBizarreCandy, 512
    ],
    ScriptWrap(GrantTWF),
    5 * 60,
    true
);
ItemEdit(global.jjsDeliciousDirkTWF, ItemData.Name, tr("deliciousDirkName") + " (The World Frozen)");
ItemEdit(global.jjsDeliciousDirkTWF, ItemData.Description, tr("deliciousDirkDescription"));

global.jjsDeliciousDirkKCF = ItemCreate(
    undefined,
    "jjsDeliciousDirkKCF",
    "",
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjsBizarreCandy, 512
    ],
    ScriptWrap(GrantKCF),
    5 * 60,
    true
);
ItemEdit(global.jjsDeliciousDirkKCF, ItemData.Name, tr("deliciousDirkName") + " (King Crimson Festive)");
ItemEdit(global.jjsDeliciousDirkKCF, ItemData.Description, tr("deliciousDirkDescription"));

global.jjsDeliciousDirkHE = ItemCreate(
    undefined,
    "jjsDeliciousDirkHE",
    "",
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjsBizarreCandy, 512
    ],
    ScriptWrap(GrantHE),
    5 * 60,
    true
);
ItemEdit(global.jjsDeliciousDirkHE, ItemData.Name, tr("deliciousDirkName") + " (Hierophant Eve)");
ItemEdit(global.jjsDeliciousDirkHE, ItemData.Description, tr("deliciousDirkDescription"));

global.jjsOfferingPillar = StructureCreate(
    undefined,
    "jjsOfferingPillar",
    "",
    StructureType.Base,
    global.sprOfferingPillar,
    undefined,
    [
        global.jjsBizarreCandy, 100,
    ],
    1,
    true,
    [
        global.jjsDeliciousDirkTWF,
        global.jjsDeliciousDirkKCF,
        global.jjsDeliciousDirkHE
    ],
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);
StructureEdit(global.jjsOfferingPillar, StructureData.Name, tr("offeringPillarName"));
StructureEdit(global.jjsOfferingPillar, StructureData.Description, tr("offeringPillarDescription"));
if (current_month != 12)
{
    StructureEdit(global.jjsOfferingPillar, StructureData.Sprite, global.sprOfferingPillarWorn);
    StructureEdit(global.jjsOfferingPillar, StructureData.Items, undefined);
}

#define GrantTWF

grant_ability_from_item(global.jjsDeliciousDirkTWF, GiveTWF)

#define GrantKCF

grant_ability_from_item(global.jjsDeliciousDirkKCF, GiveKCF)

#define GrantHE

grant_ability_from_item(global.jjsDeliciousDirkHE, GiveHE)


