
global.jjRuneBriefRaspite = ItemCreate(
    undefined,
    "rune of brief raspite",
    "heals slowly.",
    global.sprRuneBriefRaspite,
    ItemType.Consumable,
    ItemSubType.Potion,
    512,
    0,
    0,
    undefined,
    ScriptWrap(RuneBriefRaspiteUse),
    5 * 60,
    true
)

#define RuneBriefRaspiteUse

RuneEquip(player, ConstructRuneBriefRaspite());

#define ConstructRuneBriefRaspite

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneBriefRaspite;
_rune.item_id = global.jjRuneBriefRaspite;
_rune.save_key = "skRuneBriefRaspite";
_rune.update = ScriptWrap(RuneBriefRaspiteUpdate);
return _rune

#define RuneBriefRaspiteUpdate

if (instance_exists(player))
{
    player.hp += 0.001;
}
