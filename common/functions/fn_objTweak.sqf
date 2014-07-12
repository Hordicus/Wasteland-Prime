if ( local (_this select 0) ) then {
	private ['_veh', '_class', '_config', '_cfg', '_fnc'];
	_veh = _this select 0;
	_class = typeOf _veh;
	_config = [] call BL_fnc_objTweaksConfig;


	_cfg = configFile >> "CfgVehicles" >> _class;
	while { configName _cfg != "" } do {
		_fnc = [_config, configName _cfg] call CBA_fnc_hashGet;
		
		if ( !isNil "_fnc" ) then {
			_result = _this call _fnc;
			
			if ( typeName _result == "BOOL" && {_result} ) exitwith{};
		};
		
		_cfg = inheritsFrom _cfg;
	}
};