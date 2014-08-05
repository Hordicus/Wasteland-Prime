private ['_command', '_arguments'];
_command    = [_this, 0, "", [""]] call BIS_fnc_param;
_arguments  = [_this, 1, [], [[]]] call BIS_fnc_param;

MySQLGroupQueue = missionNamespace getVariable ['MySQLGroupQueue', []];

_arguments = [_arguments] call BL_fnc_noEmptyArrayValues;
_arguments = [_arguments] call BL_fnc_allFloatsToStrings;

MySQLGroupQueue set [count MySQLGroupQueue, format ([_command] + _arguments)];

BL_MySQLGroupTimeout = missionNamespace getVariable ['BL_MySQLGroupTimeout', false];
if ( typeName BL_MySQLGroupTimeout == "SCRIPT" ) then {
	terminate BL_MySQLGroupTimeout;
};

if ( count MySQLGroupQueue < 15 ) then {
	BL_MySQLGroupTimeout = 15 spawn BL_fnc_MySQLProcessGroupQueue;;
}
else {
	BL_MySQLGroupTimeout = 0 spawn BL_fnc_MySQLProcessGroupQueue;;
};