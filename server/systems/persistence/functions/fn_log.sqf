private ['_type', '_msg'];
_type = [_this, 0, "log", [""]] call BIS_fnc_param;
_msg =  [_this, 1, "", [""]] call BIS_fnc_param;

BL_logQueue = missionNamespace getVariable ['BL_logQueue', []];
BL_logQueue set [count BL_logQueue, [_type call BL_fnc_MySQLEscape, _msg call BL_fnc_MySQLEscape]];

BL_logTimeout = missionNamespace getVariable ['BL_logTimeout', false];

if ( typeName BL_logTimeout == "SCRIPT" ) then {
	terminate BL_logTimeout;
};

BL_logTimeout = [] spawn {
	sleep 30;
	BL_logTimeout = false;
	_queue = +BL_logQueue;
	BL_logQueue = [];
	
	_command = "INSERT INTO `log` (`timestamp`, `type`, `message`) VALUES ";
	_values = [];

	{
		_values set [_forEachIndex, format(["(UNIX_TIMESTAMP(), '%1', '%2')"] + ([_x] call BL_fnc_noEmptyArrayValues))];
	} forEach _queue;
	
	_command = _command + ([_values, ','] call CBA_fnc_join);
	[_command] call BL_fnc_MySQLCommand;
};