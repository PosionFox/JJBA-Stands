
#define ConstructRuneMight

var _rune = ConstructRuneBase();
_rune.save_key = "rsk_might";
_rune.name = tr("rune_might_name");
_rune.description = tr("rune_might_desc");
_rune.sprite = global.sprRuneMight;
_rune.damage = 0.1;
return _rune;

#define ConstructRuneAcute

var _rune = ConstructRuneBase();
_rune.save_key = "rsk_acute";
_rune.name = tr("rune_acute_name");
_rune.description = tr("rune_acute_desc");
_rune.sprite = global.sprRuneAcute;
_rune.crit_chance = 0.02;
return _rune;

#define ConstructRuneReach

var _rune = ConstructRuneBase();
_rune.save_key = "rsk_reach";
_rune.name = tr("rune_reach_name");
_rune.description = tr("rune_reach_desc");
_rune.sprite = global.sprRuneReach;
_rune.stand_reach = 0.1;
return _rune;

#define ConstructRuneMending

var _rune = ConstructRuneBase();
_rune.save_key = "rsk_mending";
_rune.name = tr("rune_mending_name");
_rune.description = tr("rune_mending_desc");
_rune.sprite = global.sprRuneMending;
_rune.healing = 0.0001;
return _rune;

#define ConstructRuneEnergize

var _rune = ConstructRuneBase();
_rune.save_key = "rsk_energize";
_rune.name = tr("rune_energize_name");
_rune.description = tr("rune_energize_desc");
_rune.sprite = global.sprRuneEnergize;
_rune.max_energy = 200;
return _rune;

#define ConstructRuneBriefRaspite

var _rune = ConstructRuneBase();
_rune.sprite = global.sprRuneBriefRaspite;
_rune.save_key = "rsk_brief_raspite";
_rune.update = ScriptWrap(RuneBriefRaspiteUpdate);
return _rune;

#define RuneBriefRaspiteUpdate

if (instance_exists(player))
{
    player.hp += 0.001;
}
