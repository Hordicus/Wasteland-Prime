// Adapted from denisko.redisko (denvdmj) https://community.bistudio.com/wiki/weaponsTurret
private ["_root","_path","_result","_class","_i","_currentPath","_weapon","_mags"];
_root = [_this, 0, "LandVehicle", ["", (configFile >> "CfgVehicles")]] call BIS_fnc_param;
_path = +([_this, 1, [], [[]]] call BIS_fnc_param);
_result = [];

if ( typeName _root == "STRING" ) then {
	_root = (configFile >> "CfgVehicles" >> _root >> "turrets");
};

for "_i" from 0 to (count _root)-1 do {
	_class = _root select _i;
	if ( isClass _class ) then {
		_currentPath = _path + [_i];
		{
			_weapon = configFile >> "CfgWeapons" >> _x;
			_mags = [];
			{
				_mags = _mags + getArray (
					(if (_x == "this") then { _weapon } else { _weapon >> _x }) >> "magazines"
				);
			} forEach getArray (_weapon >> "muzzles");
	
			_result set [_forEachIndex, [_x, _currentPath, _mags]];
		} forEach getArray (_class >> "weapons");
		
		_class = _class >> "turrets";
		if ( isClass _class ) then {
			_result = _result + ([_class, _currentPath] call BL_fnc_vehicleWeapons);
		};
	};
};

_result