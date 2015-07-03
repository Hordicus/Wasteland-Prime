['crate', [
	// Save
	{(_this select 0) getVariable 'objectOwner'},
	
	// Load
	{
		private ['_crate'];
		_crate = _this select 0;
		_crate setVariable ['objectLocked', true, true];
		_crate setVariable ['objectOwner', _this select 1, true];
	}
]] call BL_fnc_persRegisterTypeHandler;

[] spawn {
	if ( !isNil "PERS_init_done" ) exitwith{};
	waitUntil {isServer || isPlayer player};
	waitUntil { !isNil "PERS_init_done" };
	if !( 'weaponsCrates' call BL_fnc_shouldRun ) exitwith{};

	private ['_config', '_amount', '_crates', '_cities', '_searchDistance', '_classes'];
	_config = [] call BL_fnc_weaponsCrates_config;
	_amount = [_config, 'amount'] call CBA_fnc_hashGet;
	_crates = [_config, 'crates'] call CBA_fnc_hashGet;
	_cities = [] call BL_fnc_findCities;
	_searchDistance = 5;
	
	_classes = [];
	{
		_classes set [_forEachIndex, _x select 0];
	} forEach _crates;
	
	for "_i" from 1 to _amount do {
		_crate = [_crates, 1] call BL_fnc_selectRandom;
		_position = [];

		while { count _position == 0 } do {
			_city  = _cities select floor random count _cities;
			_cityCenter = _city select 1;
			_cityRadius = _city select 2;
			_distance = random _cityRadius - _searchDistance;
			_direction = random 359;

			_position = [_cityCenter, _distance, _direction] call BIS_fnc_relPos;
			_nearCrates = _position nearEntities [_classes, 50];
			
			if ( count _nearCrates == 0 ) then {
				_position = _position findEmptyPosition [0, _searchDistance, _crate select 0];
				
				if ( count _position > 0 ) then {
					_abovePosition = +_position;
					_abovePosition set [2, 15];
					_intersects = lineIntersectsWith [ATLToASL _position, ATLToASL _abovePosition, objNull, objNull, false];
					
					if ( count _intersects > 0 ) then{
						_position = [];
					};
				};
			}
			else {
				_position = [];
			};
		};
		
		_box = createVehicle [_crate select 0, _position, [], 0, "CAN_COLLIDE"];
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;
	    clearBackpackCargoGlobal _box;
		
		{
			_box addBackpackCargoGlobal _x;
		} count (_crate select 2);
		
		{
			_box addItemCargoGlobal _x;
		} count (_crate select 2);
		
		[_box, 'crate'] call BL_fnc_trackVehicle;
	};
};