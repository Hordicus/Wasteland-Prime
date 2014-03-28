private ["_veh","_position","_variables","_fuelCargo","_ammoCargo","_weapons","_magazines"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _veh ) exitwith {};

_netId = netId _veh;
_index = PERS_trackedObjectsNetIDs find _netId;
_dbID = PERS_trackedObjectsIDs select _index;
_isNew = isNil "_dbID";

if ( _isNew ) then { _dbID = -1; };

_type = _veh getVariable 'PERS_type';

_position = getPosATL _veh;
_variables = [];

_fuelCargo = getFuelCargo _veh;
_ammoCargo = getFuelCargo _veh;

if !( finite _fuelCargo ) then { _fuelCargo = 0; };
if !( finite _ammoCargo ) then { _ammoCargo = 0; };

// _weapons = ([typeOf _veh] call BL_fnc_vehicleWeapons);

_magazines = [];
// {
	// _magazines set [_forEachIndex, [_x, _veh magazinesTurret _x]];
// } forEach _weapons;

_data = [
	typeOf _veh,
	_position select 0,
	_position select 1,
	_position select 2,

	damage _veh,
	fuel _veh,
	getWeaponCargo _veh,
	getMagazineCargo _veh,
	getItemCargo _veh,
	vectorDir _veh,
	vectorUp _veh,
	_fuelCargo,
	_ammoCargo,
	_magazines,
	_variables,
	_dbID,
	_type
];

_query = "";

if ( _isNew ) then {
	_query = "INSERT INTO `vehicles` SET";
}
else {
	_query = "UPDATE `vehicles` SET";
};

_query = _query + "
`class` = '%1',
`pos_x` = %2,
`pos_y` = %3,
`pos_z` = %4,
`damage` = %5,
`fuel` = %6,
`weaponCargo` = '%7',
`magazineCargo` = '%8',
`itemCargo` = '%9',
`vectorDir` = '%10',
`vectorUp` = '%11',
`fuelCargo` = %12,
`ammoCargo` = %13,
`magazines` = '%14',
`variables` = '%15'
";

if ( _isNew ) then {
	_query = _query + ", `object_type` = '%17'";
}
else {
	_query = _query + "WHERE `id` = '%16'";
};

[_query, _data] call BL_fnc_MySQLCommand;
["SELECT LAST_INSERT_ID() as `id`", [], [_index], {
	PERS_trackedObjectsIDs set [_this select 1 select 0, (_this select 0 select 0 select 0 select 0)];
}] call BL_fnc_MySQLCommand;

_veh