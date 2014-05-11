BL_donatorInfo = [[], 0] call CBA_fnc_hashCreate;
BL_donatorTiers = [[] call BL_fnc_donatorsConfig, 'tiers'] call CBA_fnc_hashGet;
BL_donatorDatabase = [[] call BL_fnc_donatorsConfig, 'database'] call CBA_fnc_hashGet;

['initPlayerServer', {
	// Get and store donator level
	private ['_uid', '_result'];
	_uid = getPlayerUID (_this select 0);
	
	_result = (["SELECT `tier` FROM `donators` WHERE `uid` = '%1' AND `expires` > NOW() ORDER BY `expires` ASC", [_uid], BL_donatorDatabase] call BL_fnc_MySQLCommandSync) select 0;
	
	if ( count _result > 0 ) then {
		[BL_donatorInfo, _uid, _result select 0 select 0] call CBA_fnc_hashSet;
	}
	else {
		[BL_donatorInfo, _uid, -1] call CBA_fnc_hashSet;
	};
}] call CBA_fnc_addEventHandler;

['respawn', {
	// Apply donator benefits
	private ['_tier'];
	_tier = [BL_donatorInfo, getPlayerUID (_this select 0)] call CBA_fnc_hashGet;
	
	if ( _tier != -1 ) then {
		[_this select 0] call (BL_donatorTiers select _tier);
	};
}] call CBA_fnc_addEventHandler;