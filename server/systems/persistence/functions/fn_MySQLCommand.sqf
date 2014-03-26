private ['_database', '_command', '_arguments', '_argStr'];
_database   = "badlands"; // TODO: Get from config
_command    = [_this, 0, "", [""]] call BIS_fnc_param;
_arguments  = [_this, 1, [], [[]]] call BIS_fnc_param;
_cbArgs     = [_this, 2, [], [[]]] call BIS_fnc_param;
_callback   = [_this, 3, {}, [{}]] call BIS_fnc_param;

_arguments = [_arguments] call BL_fnc_noEmptyArrayValues;

[
	format['Arma2NETMySQLCommandAsync ["%1", "%2"]', _database, format ([_command] + _arguments )],
	_cbArgs,
	_callback
] spawn {
	_query = "";
	while { _query == "" } do {
		_query = "Arma2Net.Unmanaged" callExtension (_this select 0);
		sleep 0.5;
	};
	
	_query = ([call compile _query] call BL_fnc_emptyArrayValues);
	
	[_query, (_this select 1)] call (_this select 2);
};