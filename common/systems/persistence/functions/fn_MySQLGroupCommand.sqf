private ['_command', '_arguments'];
_command    = [_this, 0, "", [""]] call BIS_fnc_param;
_arguments  = [_this, 1, [], [[]]] call BIS_fnc_param;

MySQLGroupQueue = missionNamespace getVariable ['MySQLGroupQueue', []];

_arguments = [_arguments] call BL_fnc_noEmptyArrayValues;
_arguments = [_arguments] call BL_fnc_allFloatsToStrings;

MySQLGroupQueue set [count MySQLGroupQueue, format ([_command] + _arguments)];

BL_MySQLGroupTimeout = missionNamespace getVariable ['BL_MySQLGroupTimeout', false];
if ( typeName BL_MySQLGroupTimeout == "SCRIPT" && count MySQLGroupQueue < 50 ) then {
	terminate BL_MySQLGroupTimeout;
};

if ( count MySQLGroupQueue < 50 ) then {
	BL_MySQLGroupTimeout = [] spawn {
		sleep 60;
		_queue = +MySQLGroupQueue;
		MySQLGroupQueue = [];
		
		_query = [_queue, ";"] call CBA_fnc_join;
		[_query] call BL_fnc_MySQLCommand;
	};
};