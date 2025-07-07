
#define OnHTTPAsync(_async_load)

var _id = _async_load[? "id"];
var _status = _async_load[? "status"];
var _result = _async_load[? "result"];

if (_id == global.jjHTTPPost)
{
    if (_status == 0)
    {
        var _data = string_split(_result, ":")[51];
        var _unix = real(string_split(_data, ",")[0]);
        global.jjSteamVersion = unix_to_iso8601(_unix);
    }
}
