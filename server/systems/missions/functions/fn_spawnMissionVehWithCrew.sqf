private ['_group', '_class', '_loc', '_units', '_veh', '_createdUnits', '_turrets'];
_group = [_this, 0, grpNull, [grpNull]] call BIS_fnc_param;
_class = [_this, 1, "", [""]] call BIS_fnc_param;
_loc   = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_units = [_this, 3, [], [[]]] call BIS_fnc_param;

_veh = createVehicle [_class, _loc, [], 0, "CAN_COLLIDE"];
[_veh, 'reward'] call BL_fnc_trackVehicle;

_createdUnits = [];
_turrets = count (configFile >> "CfgVehicles" >> _class >> "Turrets");

// If a list of units to use wasn't provided add riflemen for driver/turret(s)
if ( count _units == 0 ) then {
	for "_i" from 0 to (1 + _turrets-1) do {
		_units set [_i, "O_Soldier_F"];
	};
};

{
	_createdUnits set [_forEachIndex, _group createUnit [_x, _loc, [], 0, "FORM"]];
} forEach _units;

(_createdUnits select 0) moveInDriver _veh;

for "_i" from 1 to _turrets-1 do {
	if ( _i > count _createdUnits ) exitwith{};
	(_createdUnits select _i) moveInTurret [_veh, [_i-1]];
};

for "_i" from (1 + _turrets-1) to (count _createdUnits) - 1 do {
	(_createdUnits select _i) moveInCargo _veh;
};

_veh