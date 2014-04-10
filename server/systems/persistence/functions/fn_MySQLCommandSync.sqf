private ['_database', '_command', '_arguments', '_argStr'];
_command    = [_this, 0, "", [""]] call BIS_fnc_param;
_arguments  = [_this, 1, [], [[]]] call BIS_fnc_param;

_arguments = [_arguments] call BL_fnc_noEmptyArrayValues;
_arguments = [_arguments] call BL_fnc_allFloatsToStrings;

_database   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;
_query = format['Arma2NETMySQLCommand ["%1", "%2"]', _database, format ([_command] + _arguments )];

_result = "Arma2Net.Unmanaged" callExtension _query;
_result = [[_result] call BL_fnc_processQueryResult] call BL_fnc_emptyArrayValues;

_result