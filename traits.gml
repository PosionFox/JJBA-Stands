
#define trait_set_by_key(_user, _trait_key)

switch (_trait_key)
{
    // common
    case "jjFit":
        _user.trait = {
            name : "fit",
            key : _trait_key,
            color : c_white,
            damage : 0.05
        }
    break;
    // uncommon
    case "jjHefty":
        _user.trait = {
            name : "hefty",
            key : _trait_key,
            color : c_lime,
            damage : 0.10
        }
    break;
    // rare
    case "jjStrong":
        _user.trait = {
            name : "strong",
            key : _trait_key,
            color : c_blue,
            damage : 0.15
        }
    break;
    // epic
    case "jjMuscular":
        _user.trait = {
            name : "muscular",
            key : _trait_key,
            color : c_purple,
            damage : 0.20
        }
    break;
    // legendary
    case "jjJacked":
        _user.trait = {
            name : "jacked",
            key : _trait_key,
            color : c_yellow,
            damage : 0.25
        }
    break;
    // mythical
    case "jjBuff":
        _user.trait = {
            name : "buff",
            key : _trait_key,
            color : c_red,
            damage : 0.30
        }
    break;
    // ascended
    case "jjRipped":
        _user.trait = {
            name : "ripped",
            key : _trait_key,
            color : c_orange,
            damage : 0.35
        }
    break;
    // ultimate
    case "jjHercules":
        _user.trait = {
            name : "hercules",
            key : _trait_key,
            color : c_fuchsia,
            damage : 0.40
        }
    break;
}
