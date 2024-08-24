
#define GiveSpecless(_user)

var _skills = SpecSkillsInit();

var _spec = SpecBuild(_user, _skills)
with (_spec)
{
    name = "Specless";
}
return _spec;
