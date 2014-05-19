private ['_database', '_command', '_arguments', '_argStr'];
_command    = [_this, 0, "", [""]] call BIS_fnc_param;
_arguments  = [_this, 1, [], [[]]] call BIS_fnc_param;
_cbArgs     = [_this, 2, [], [[]]] call BIS_fnc_param;
_callback   = [_this, 3, {}, [{}]] call BIS_fnc_param;
_database   = [_this, 4, "", [""]] call BIS_fnc_param;

_arguments = [_arguments] call BL_fnc_noEmptyArrayValues;
_arguments = [_arguments] call BL_fnc_allFloatsToStrings;

MySQLQueue = missionNamespace getVariable ['MySQLQueue', []];
MySQLQueue set [count MySQLQueue, [_command, _arguments, _cbArgs, _callback, _database]];

if ( isNil "MySQLQueueProcessing" || { scriptDone MySQLQueueProcessing } ) then {
	MySQLQueueProcessing = [] spawn BL_fnc_MySQLProcessQueue;
};