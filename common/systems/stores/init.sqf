_config = [] call BL_fnc_storeConfig;
BL_PVAR_storeAccessObjects = missionNamespace getVariable ['BL_PVAR_storeAccessObjects', []];

[_config, {
	private ['_fnc', '_store', '_marker'];
	_fnc = compile preprocessFileLineNumbers format['\x\bl_common\addons\systems\stores\storeBuildings\%1.sqf', _key];
	_store = _key;
	
	{
		if ( 'objectLoad' call BL_fnc_shouldRun ) then {
			_accessObject = _x call _fnc;
			BL_PVAR_storeAccessObjects set [count BL_PVAR_storeAccessObjects, [_store, _accessObject]];
		};
		
		if ( 'radar' call BL_fnc_shouldRun ) then {
			_radius = [_x, 2, 0, [0]] call BIS_fnc_param;
			if ( _radius > 0 ) then {
				_marker = format['%1%2', _store, _forEachIndex];
				[_x select 0, _radius, 'storeRadar', [_marker]] call BL_fnc_registerLocWithRadar;
			};
		};
		
		true
	} forEach (_value select 2);
}] call CBA_fnc_hashEachPair;

if ( 'objectLoad' call BL_fnc_shouldRun ) then {
	publicVariable "BL_PVAR_storeAccessObjects";
};