sleep _this;
BL_MySQLGroupTimeout = false;
_queue = +MySQLGroupQueue;
MySQLGroupQueue = [];

_query = [_queue, ";"] call CBA_fnc_join;
[_query] call BL_fnc_MySQLCommand;

nil