
#define OnHTTPAsync(_async_load)

var _id = _async_load[? "id"];
var _status = _async_load[? "status"];
var _result = _async_load[? "result"];

if (_status == 0)
{
    if (_id == global.jjsSteamVersionHTTP)
    {
        var _data = string_split(_result, ",");
        var _unix = 0;
        for (var i = 0; i < array_length(_data); i++)
        {
            if (string_count("time_updated", _data[i]) > 0)
            {
                _unix = real(string_split(_data[i], ":")[1]);
            }
        }
        global.jjSteamVersion = unix_to_iso8601(_unix);
    }
    if (_id == global.jjsModChangelogHTTP)
    {
        global.jjsModChangelog = string(_result);
    }
}
