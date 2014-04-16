private ['_cities', '_config', '_lowestChances', '_groupClasses'];
_cities = [] call BL_fnc_findCities;
_config = [] call BL_fnc_rareVehiclesConfig;
_lowestChances = [[], 1] call CBA_fnc_hashCreate;
_groupClasses = [] call CBA_fnc_hashCreate;

[_config, {
	private ['_lowest', '_classes'];
	_lowest = 1;
	_classes = [];
	
	{
		_classes set [_forEachIndex, _x select 0];
		if ( _x select 1 < _lowest ) then {
			_lowest = _x select 1;
		};
	} forEach (_value select 1);
	
	[_lowestChances, _key, _lowest] call CBA_fnc_hashSet;
	[_groupClasses, _key, _classes] call CBA_fnc_hashSet;
}] call CBA_fnc_hashEachPair;

['rareVeh', [
	// Save
	{(_this select 0) getVariable ['originalSpawnPoint', getPosATL (_this select 0)]},
	
	// Load
	{
		private ['_veh'];
		_veh = _this select 0;
		diag_log format['Setting originalSpawnPoint to %1', _this select 1];
		_veh setVariable ['originalSpawnPoint', _this select 1];
	}
]] call BL_fnc_persRegisterTypeHandler;

while { true } do {
	waitUntil { !isNil "PERS_init_done" };

	[_config, {
		private ['_maxCount', '_classes', '_lowestChance', '_count'];
		_maxCount = _value select 0;
		_classes = [_groupClasses, _key] call CBA_fnc_hashGet;
		_lowestChance = [_lowestChances, _key] call CBA_fnc_hashGet;
		_count = count ((getPosATL mapCenter) nearEntities [_classes, 100000]);
		
		for "_i" from 0 to (_maxCount - _count)-1 do {
			while { true } do {
				private ['_city', '_cityCenter', '_radius', '_distanceFromTown', '_randomDir', '_position', '_match', '_matchPos', '_matchAccuracy','_veh'];
				_city = _cities select floor random count _cities;
				_cityCenter = _city select 1;
				
				_radius = _city select 2;
				_distanceFromTown = random 1000;
				_randomDir = random 359;
				
				_position = [_cityCenter, _distanceFromTown + _radius, _randomDir] call BIS_fnc_relPos;
				_match = (selectBestPlaces [_position, 50, "meadow - ((trees factor [0.5, 1]) + forest + hills + sea/2)", 1, 1]) select 0;
				_matchPos = _match select 0;
				_matchAccuracy = _match select 1;
				
				if ( _matchAccuracy > 0 && count (_matchPos nearEntities [_classes, 1000]) == 0 ) exitwith {
					private ['_chance', '_possible', '_class'];
					_chance = random 1 + _lowestChance;
					_possible = [];
					
					{
						if ( 1-(_x select 1) <= _chance ) then {
							_possible set [count _possible, _x];
						};
					} count (_value select 1);

					_class = (_possible select floor random count _possible) select 0;
					_veh = [_class, _matchPos] call BL_fnc_safeVehicleSpawn;
					[[_veh, 'rareVeh'] call BL_fnc_trackVehicle] call BL_fnc_saveVehicle;
				};
			};
		};
	}] call CBA_fnc_hashEachPair;

	sleep (60 * 5);
};

/*
// Display vehicles on map. Useful for testing.
(findDisplay 12 displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
	_map = _this select 0;
	_config = [] call BL_fnc_rareVehiclesConfig;
	
	[_config, {
		{
			_class = _x select 0;
			_icon = getText (configFile >> "CfgVehicles" >> _class >> "icon");
			
			{
				_pos = getPosATL _x;
				_damage = damage _x;
				_map drawIcon [_icon, [1,1-_damage,1-_damage,1], _pos, 24, 24, 0, '', 1, 0.03, 'TahomaB', 'right'];
			} forEach entities _class;
		} forEach (_value select 1);
	}] call CBA_fnc_hashEachPair;
}];
*/