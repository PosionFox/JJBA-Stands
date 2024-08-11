
#define init_trait(_user)

if !bool("trait" in _user)
{
    _user.trait = {
        name : "none",
        key : "jjNone",
        color : c_white,
        damage : 0,
        damage_reflected : 0
    }
}

#define trait_give_random(_user)

var _pool =
[
    // common
    ["jjFit", 128],
    // uncommon
    ["jjHefty", 64],
    // rare
    ["jjStrong", 32],
    // epic
    ["jjMuscular", 16],
    // legendary
    ["jjJacked", 8],
    ["jjRepeat", 8],
    // mythical
    ["jjBuff", 4],
    ["jjReflect", 4],
    // ascended
    ["jjRipped", 2],
    ["jjMirror", 2],
    // ultimate
    ["jjHercules", 1],
    ["jjEcho", 1]
]
trait_set_by_key(_user, random_weight(_pool));

#define trait_set_by_key(_user, _trait_key)

switch (_trait_key)
{
    // common
    case "jjFit":
        _user.trait.name = "fit";
        _user.trait.key = _trait_key;
        _user.trait.color = c_white;
        _user.trait.damage = 0.05;
        _user.trait.damage_reflected = 0;
    break;
    // uncommon
    case "jjHefty":
        _user.trait.name = "hefty";
        _user.trait.key = _trait_key;
        _user.trait.color = c_lime;
        _user.trait.damage = 0.10;
        _user.trait.damage_reflected = 0;
    break;
    // rare
    case "jjStrong":
        _user.trait.name = "strong";
        _user.trait.key = _trait_key;
        _user.trait.color = c_blue;
        _user.trait.damage = 0.15;
        _user.trait.damage_reflected = 0;
    break;
    // epic
    case "jjMuscular":
        _user.trait.name = "muscular";
        _user.trait.key = _trait_key;
        _user.trait.color = c_purple;
        _user.trait.damage = 0.20;
        _user.trait.damage_reflected = 0;
    break;
    // legendary
    case "jjJacked":
        _user.trait.name = "jacked";
        _user.trait.key = _trait_key;
        _user.trait.color = c_yellow;
        _user.trait.damage = 0.25;
        _user.trait.damage_reflected = 0;
    break;
    case "jjRepeat":
        _user.trait.name = "repeat";
        _user.trait.key = _trait_key;
        _user.trait.color = c_yellow;
        _user.trait.damage = 0;
        _user.trait.damage_reflected = 1;
    break;
    // mythical
    case "jjBuff":
        _user.trait.name = "buff";
        _user.trait.key = _trait_key;
        _user.trait.color = c_red;
        _user.trait.damage = 0.30;
        _user.trait.damage_reflected = 0;
    break;
    case "jjReflect":
        _user.trait.name = "reflect";
        _user.trait.key = _trait_key;
        _user.trait.color = c_red;
        _user.trait.damage = 0;
        _user.trait.damage_reflected = 5;
    break;
    // ascended
    case "jjRipped":
        _user.trait.name = "ripped";
        _user.trait.key = _trait_key;
        _user.trait.color = c_orange;
        _user.trait.damage = 0.35;
        _user.trait.damage_reflected = 0;
    break;
    case "jjMirror":
        _user.trait.name = "mirror";
        _user.trait.key = _trait_key;
        _user.trait.color = c_orange;
        _user.trait.damage = 0;
        _user.trait.damage_reflected = 10;
    break;
    // ultimate
    case "jjHercules":
        _user.trait.name = "hercules";
        _user.trait.key = _trait_key;
        _user.trait.color = c_fuchsia;
        _user.trait.damage = 0.40;
        _user.trait.damage_reflected = 0;
    break;
    case "jjEcho":
        _user.trait.name = "echo";
        _user.trait.key = _trait_key;
        _user.trait.color = c_fuchsia;
        _user.trait.damage = 0;
        _user.trait.damage_reflected = 15;
    break;
}
