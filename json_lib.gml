
global.__json_str = "";
global.__json_pos = 0;

#define json_parse(str)

global.__json_str = argument0;
global.__json_pos = 0;

_json_skip_whitespace();
var result = _json_parse_value();
return result;

#define _json_skip_whitespace()

while (global.__json_pos < string_length(global.__json_str)) {
    var c = string_char_at(global.__json_str, global.__json_pos + 1);
    if (c != " " && c != "\n" && c != "\r" && c != "\t") break;
    global.__json_pos += 1;
}

#define _json_parse_value()

_json_skip_whitespace();
var c = string_char_at(global.__json_str, global.__json_pos + 1);

if (c == "{") return _json_parse_object();
if (c == "[") return _json_parse_array();
if (c == "\"") return _json_parse_string();
if (c == "'") return _json_parse_string();
if (c == "-" || (ord(c) >= ord("0") && ord(c) <= ord("9"))) return _json_parse_number();

var substr = string_copy(global.__json_str, global.__json_pos + 1, 5);
if (string_copy(substr, 1, 4) == "true") {
    global.__json_pos += 4;
    return true;
}
if (string_copy(substr, 1, 5) == "false") {
    global.__json_pos += 5;
    return false;
}
if (string_copy(substr, 1, 4) == "null") {
    global.__json_pos += 4;
    return undefined;
}

return undefined;

#define _json_parse_object()

global.__json_pos += 1; // skip '{'
_json_skip_whitespace();
var map = ds_map_create();

if (string_char_at(global.__json_str, global.__json_pos + 1) == "}") {
    global.__json_pos += 1;
    return map;
}

repeat (10000) {
    _json_skip_whitespace();
    var key = _json_parse_string();
    
    _json_skip_whitespace();
    if (string_char_at(global.__json_str, global.__json_pos + 1) == ":") {
        global.__json_pos += 1;
    }
    
    _json_skip_whitespace();
    var val = _json_parse_value();
    ds_map_set(map, key, val);
    
    _json_skip_whitespace();
    var c = string_char_at(global.__json_str, global.__json_pos + 1);
    if (c == "}") {
        global.__json_pos += 1;
        break;
    } else if (c == ",") {
        global.__json_pos += 1;
    } else {
        break;
    }
}
return map;

#define _json_parse_array()

global.__json_pos += 1; // skip '['
_json_skip_whitespace();
var list = ds_list_create();

if (string_char_at(global.__json_str, global.__json_pos + 1) == "]") {
    global.__json_pos += 1;
    return list;
}

repeat (10000) {
    _json_skip_whitespace();
    var val = _json_parse_value();
    ds_list_add(list, val);

    _json_skip_whitespace();
    var c = string_char_at(global.__json_str, global.__json_pos + 1);
    if (c == "]") {
        global.__json_pos += 1;
        break;
    } else if (c == ",") {
        global.__json_pos += 1;
    } else {
        break;
    }
}
return list;

#define _json_parse_string()

global.__json_pos += 1; // skip '"'
var str = "";
repeat (10000) {
    if (global.__json_pos >= string_length(global.__json_str)) break;
    var c = string_char_at(global.__json_str, global.__json_pos + 1);
    if (c == "\"")
    {
        global.__json_pos += 1;
        break;
    }
    else if (c == "'")
    {
        global.__json_pos += 1;
        break;
    }
    else if (c == "\\")
    {
        global.__json_pos += 1;
        var esc = string_char_at(global.__json_str, global.__json_pos + 1);
        if (esc == "\"") str += "\"";
        else if (esc == "\\") str += "\\";
        else if (esc == "/") str += "/";
        else if (esc == "b") str += chr(8);
        else if (esc == "f") str += chr(12);
        else if (esc == "n") str += "\n";
        else if (esc == "r") str += "\r";
        else if (esc == "t") str += "\t";
        // no unicode \u handling for simplicity
        global.__json_pos += 1;
    }
    else
    {
        str += c;
        global.__json_pos += 1;
    }
}
return str;

#define _json_parse_number()

var start = global.__json_pos + 1;
var len = string_length(global.__json_str);
var has_dot = false;

repeat (len - global.__json_pos) {
    var c = string_char_at(global.__json_str, global.__json_pos + 1);
    if ((ord(c) >= ord("0") && ord(c) <= ord("9")) || c == "-" || c == "+" || c == "e" || c == "E") {
        global.__json_pos += 1;
    } else if (c == "." && !has_dot) {
        has_dot = true;
        global.__json_pos += 1;
    } else {
        break;
    }
}

var numstr = string_copy(global.__json_str, start, global.__json_pos - start + 1);
return real(numstr);

#define json_destroy()

var data = argument0;

if (is_undefined(data)) {
    return;
}

if (ds_map_valid(data)) {
    // ds_map
    var keys = ds_map_keys(data);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var value = ds_map_find_value(data, key);
        
        if (is_struct_like(value)) {
            json_destroy(value);
        }
    }
    ds_map_destroy(data);

} else if (ds_list_valid(data)) {
    // ds_list
    for (var i = 0; i < ds_list_size(data); i++) {
        var value = ds_list_find_value(data, i);
        if (is_struct_like(value)) {
            json_destroy(value);
        }
    }
    ds_list_destroy(data);
}

#define is_struct_like()

var v = argument0;

return ds_map_valid(v) or ds_list_valid(v); // ds_map or ds_list

#define json_stringify()

var val = argument0;

if (is_undefined(val)) return "null";
if (is_bool(val)) return string(val);
if (is_string(val)) return "\"" + _json_escape_string(val) + "\"";
if (is_real(val)) return string(val);

if (ds_map_valid(val)) {
    // ds_map
    var str = "{";
    var keys = ds_map_keys(val);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var v = ds_map_find_value(val, key);
        str += "\"" + _json_escape_string(key) + "\":" + json_stringify(v);
        if (i < array_length(keys) - 1) str += ",";
    }
    //ds_list_destroy(keys);
    str += "}";
    return str;
}

if (ds_list_valid(val)) {
    // ds_list
    var str = "[";
    for (var i = 0; i < ds_list_size(val); i++) {
        var v = ds_list_find_value(val, i);
        str += json_stringify(v);
        if (i < ds_list_size(val) - 1) str += ",";
    }
    str += "]";
    return str;
}

// unknown
return "null";

#define _json_escape_string()

var str = argument0;
var result = "";

for (var i = 1; i <= string_length(str); i++) {
    var c = string_char_at(str, i);
    if (c == "\"") result += "\\\"";
    else if (c == "\\") result += "\\\\";
    else if (c == "\b") result += "\\b";
    else if (c == "\f") result += "\\f";
    else if (c == "\n") result += "\\n";
    else if (c == "\r") result += "\\r";
    else if (c == "\t") result += "\\t";
    else result += c;
}
return result;
