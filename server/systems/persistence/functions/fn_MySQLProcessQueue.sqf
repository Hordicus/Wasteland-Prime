if ( !isNil "MySQLQueueProcessing" ) exitwith{};
_database   = [call BL_fnc_persistenceConfig, 'database'] call CBA_fnc_hashGet;

MySQLQueueProcessing = true;
while { count MySQLQueue > 0 } do {
	_item = MySQLQueue select 0;
	MySQLQueue set [0, "REMOVE"];
	MySQLQueue = MySQLQueue - ["REMOVE"];
	
	_command = _item select 0;
	_arguments = _item select 1;
	_query = format['Arma2NETMySQLCommandAsync ["%1", "%2"]', _database, format ([_command] + _arguments )];
	_result = "";
	
	while { _result == "" } do {
		_result = "Arma2Net.Unmanaged" callExtension _query;
		sleep 0.1;
	};

	_result = [[_result] call BL_fnc_processQueryResult] call BL_fnc_emptyArrayValues;
	[_result, (_item select 2)] call (_item select 3);
};

MySQLQueueProcessing = nil;