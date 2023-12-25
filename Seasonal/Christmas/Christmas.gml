
global.sprBizarreCandy = sprite_add("Seasonal/Christmas/BizarreCandy.png", 1, false, false, 8, 8);
global.sprDeliciousDirk = sprite_add("Seasonal/Christmas/DeliciousDirk.png", 1, false, false, 8, 8);
global.sprOfferingPillar = sprite_add("Seasonal/Christmas/OfferingPillar.png", 1, false, false, 8, 24);
global.sprOfferingPillarWorn = sprite_add("Seasonal/Christmas/OfferingPillarWorn.png", 1, false, false, 8, 24);

global.jjBizarreCandy = ItemCreate(
    undefined,
    Localize("bizarreCandyName"),
    Localize("bizarreCandyDescription"),
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

global.jjDeliciousDirkTWF = ItemCreate(
    undefined,
    Localize("deliciousDirkName") + " (The World Frozen)",
    Localize("deliciousDirkDescription"),
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjBizarreCandy, 512
    ],
    ScriptWrap(GrantTWF),
    5 * 60,
    true
)

global.jjDeliciousDirkKCF = ItemCreate(
    undefined,
    Localize("deliciousDirkName") + " (King Crimson Festive)",
    Localize("deliciousDirkDescription"),
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjBizarreCandy, 512
    ],
    ScriptWrap(GrantKCF),
    5 * 60,
    true
)

global.jjDeliciousDirkHE = ItemCreate(
    undefined,
    Localize("deliciousDirkName") + " (Hierophant Eve)",
    Localize("deliciousDirkDescription"),
    global.sprDeliciousDirk,
    ItemType.Consumable,
    ItemSubType.None,
    815,
    0,
    0,
    [
        global.jjBizarreCandy, 512
    ],
    ScriptWrap(GrantHE),
    5 * 60,
    true
)

var _sprite = global.sprOfferingPillarWorn;
var _items = undefined
if (current_month == 12)
{
    _sprite = global.sprOfferingPillar
    _items = [
        global.jjDeliciousDirkTWF,
        global.jjDeliciousDirkKCF,
        global.jjDeliciousDirkHE
    ]
}
global.jjOfferingPillar = StructureCreate(
    undefined,
    Localize("offeringPillarName"),
    Localize("offeringPillarDescription"),
    StructureType.Base,
    _sprite,
    undefined,
    [
        global.jjBizarreCandy, 100,
    ],
    1,
    true,
    _items,
    true,
    BuildMenuCategory.Magical,
    undefined,
    false
);



#define GrantTWF

grant_ability_from_item(global.jjDeliciousDirkTWF, GiveTWF)

#define GrantKCF

grant_ability_from_item(global.jjDeliciousDirkKCF, GiveKCF)

#define GrantHE

grant_ability_from_item(global.jjDeliciousDirkHE, GiveHE)


