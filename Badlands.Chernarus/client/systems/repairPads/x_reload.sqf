private ["_config","_count","_i","_magazines","_object","_type","_type_name","_startPos","_maxDist","_interupt"];
_object = _this select 0;
_type = typeof _object;
if (_object isKindOf "ParachuteBase") exitWith {};
if (isNil "x_reload_time_factor") then {x_reload_time_factor = .1;};
if (!alive _object) exitWith {};
_startPos = getPosATL _object;
_maxDist = 10;
_interrupt = false;
_object setVehicleAmmo 1;
_type_name = typeOf _object;
_object vehicleChat format ["Servicing %1... Please stand by...", _type];
sleep x_reload_time_factor;

if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
_object vehicleChat "Repairing...";
_object setDamage 0;
sleep x_reload_time_factor;

if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
_object vehicleChat "Refueling...";
_object setFuel 1;
sleep x_reload_time_factor;

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_object removeMagazines _x;
			_removed set [count _removed, _x];
		};
	} forEach _magazines;
	{
		_object vehicleChat format ["Reloading %1", _x];
		sleep x_reload_time_factor;
		if (!alive _object || _object distance _startPos > _maxDist) exitWith {_interrupt = true};
		_object addMagazine _x;
	} forEach _magazines;
};
_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		if (!alive _object || _object distance _startPos > _maxDist) exitWith{_interrupt = true};
		
		_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed set [count _removed, _x];
			};
		} forEach _magazines;
		{
			_object vehicleChat format ["Reloading %1", _x];
			sleep x_reload_time_factor;
			if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
			_object addMagazine _x;
			sleep x_reload_time_factor;
			if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
		} forEach _magazines;
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed set [count _removed, _x];
					};
				} forEach _magazines;
				{
					_object vehicleChat format ["Reloading %1", _x];
					sleep x_reload_time_factor;
					if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
					_object addMagazine _x;
					sleep x_reload_time_factor;
					if (!alive _object || _object distance _startPos > _maxDist) then {breakOut "xx_reload2_xx"};
				} forEach _magazines;
			};
		};
	};
};

if ( !_interrupt ) then {
	_object setVehicleAmmo 1;
	_object vehicleChat format ["%1 is ready...", _type_name];
}
else {
	_object vehicleChat format ["Service interrupted. Please try again.", _type_name];
};

if (true) exitWith {};