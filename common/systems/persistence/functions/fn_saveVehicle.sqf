private ["_veh","_dbID","_isNew","_type","_position","_variables","_fuelCargo","_ammoCargo","_data","_query"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( isNull _veh || isNil {_veh getVariable 'PERS_type'}) exitwith {};

if ( isNil {_veh getVariable 'PERS_type'} ) exitwith{};

_dbID = _veh getVariable ['PERS_id', -1];
_isNew = _dbID == -1;

_type = _veh getVariable 'PERS_type';

_position = getPosATL _veh;
_variables = [_type, 'save', [_veh]] call BL_fnc_persRunTypeHandler;
if ( isNil "_variables" ) then {
	_variables = "";
};

_fuelCargo = getFuelCargo _veh;
_ammoCargo = getAmmoCargo _veh;

if ( isNil "_fuelCargo" ) then { _fuelCargo = 0; };
if ( isNil "_ammoCargo" ) then { _ammoCargo = 0; };

if !( finite _fuelCargo ) then { _fuelCargo = 0; };
if !( finite _ammoCargo ) then { _ammoCargo = 0; };

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
	getDir _veh,
	str vectorUp _veh,
	_fuelCargo,
	_ammoCargo,
	magazines _veh,
	_variables,
	_veh getVariable ['LOG_contents', []],
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
`dir` = '%10',
`vectorUp` = '%11',
`fuelCargo` = %12,
`ammoCargo` = %13,
`magazines` = '%14',
`variables` = '%15',
`log_contents` = '%16'
";

if ( _isNew ) then {
	_query = _query + ", `object_type` = '%18'; SELECT LAST_INSERT_ID() as `id`";

	[_query, _data, [_veh], {
		(_this select 1 select 0) setVariable ['PERS_id', (_this select 0 select 0 select 0 select 0), true];
	}] call BL_fnc_MySQLCommand;
}
else {
	_query = _query + "WHERE `id` = '%17'";
	[_query, _data] call BL_fnc_MySQLGroupCommand;
};

_veh