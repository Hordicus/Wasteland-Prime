BL_donatorDatabase = [[] call BL_fnc_donatorsConfig, 'database'] call CBA_fnc_hashGet;

['initPlayerServer', {
	if ( 'donators' call BL_fnc_shouldRun ) then {
		// Get and store donator level
		private ['_uid', '_result'];
		_uid = getPlayerUID (_this select 0);
		
		["SELECT `tier` FROM `donators` WHERE `uid` = '%1' AND `expires` > NOW() ORDER BY `expires` ASC", [_uid], [_uid, _this select 0], {
			_uid = _this select 1 select 0;
			_result = _this select 0 select 0;
			
			if ( count _result > 0 ) then {
				BL_donatorInfo = _result select 0 select 0;
			}
			else {
				BL_donatorInfo = -1;
			};
			
			[_this select 1 select 1, "BL_donatorInfo"] call BL_fnc_publicVariableClient;
		}, BL_donatorDatabase] call BL_fnc_MySQLCommand;
	};
}] call CBA_fnc_addEventHandler;