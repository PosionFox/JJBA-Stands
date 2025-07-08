
global.jjsCurrentLang = "english";
var _settings = ModSettingsFetch();
if (_settings != undefined)
{
    if (_settings[? "jjsCurrentLang"] != undefined)
    {
        global.jjsCurrentLang = _settings[? "jjsCurrentLang"];
    }
}
ds_map_destroy(_settings);

global.jjsLangs = ds_map_create();
ds_map_clear(global.jjsLangs);

localizationEnglish();
localizationSpanish();

#define tr_init(_lang)

Trace("added " + string(_lang));
global.jjsLangs[? _lang] = ds_map_create();
ds_map_clear(global.jjsLangs[? _lang]);

#define tr_add(_lang, _key, _string)

global.jjsLangs[? _lang][? _key] = _string;

#define tr(_key)

var _result = "loc not found";
var _str = global.jjsLangs[? global.jjsCurrentLang][? _key];
if (_str != undefined)
{
    _result = _str;
}
else
{
    var _estr = global.jjsLangs[? "english"][? _key];
    if (_estr != undefined) _result = _estr;
}

return _result;
