_defaultDatabase   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;

while { count MySQLQueue > 0 } do {
	_item = MySQLQueue select 0;
	MySQLQueue set [0, "REMOVE"];
	MySQLQueue = MySQLQueue - ["REMOVE"];
	
	_command = _item select 0;
	_arguments = _item select 1;
	_database = _item select 4;
	
	if ( _database == "" ) then {
		_database = _defaultDatabase;
	};
	
	_query = _command;
	
	if !( _arguments isEqualTo [] ) then {
		_query = format ([_command] + _arguments );
	};
	
	if ( typeName (_item select 3) == "CODE" ) then {
		_query = 'Arma2NETMySQLCommandAsync ["'+_database+'", "'+_query+'"]';
		
		"Arma2Net.Unmanaged" callExtension _query;
		_result = "";
		
		while { _result == "" } do {
			_result = "Arma2Net.Unmanaged" callExtension "Arma2NETMySQLCommandAsync []";
			sleep 0.1;
		};

		_result = [[_result] call BL_fnc_processQueryResult] call BL_fnc_emptyArrayValues;
		[_result, (_item select 2)] call (_item select 3);
	}
	else {
		"Arma2Net.Unmanaged" callExtension ('Arma2NETMySQLCommandAsyncNoResult ["'+_database+'", "'+_query+'"]');
	};
};