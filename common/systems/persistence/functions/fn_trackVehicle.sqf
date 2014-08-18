private ["_veh","_type","_index","_id"];
_veh   = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_type  = [_this, 1, "veh", [""]] call BIS_fnc_param;
_id  = [_this, 2, -1, [0]] call BIS_fnc_param;

_veh setVariable ['PERS_type', _type, true];
_veh setVariable ['PERS_id', _id, true];

_veh