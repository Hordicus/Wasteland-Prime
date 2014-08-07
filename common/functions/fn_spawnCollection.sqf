private ['_center', '_dir', '_parts', '_spawnedObjects'];
_center = _this select 0;
_dir    = _this select 1;
_parts  = _this select 2;

_spawnedObjects = [];

private ['_class', '_distance', '_alt', '_dirTo', '_partDir', '_part', '_pos'];
{
	_class    = _x select 0;
	_distance = parseNumber (_x select 1);
	_alt      = parseNumber (_x select 2);
	_dirTo    = parseNumber (_x select 3);
	_partDir  = parseNumber (_x select 4);

	_part = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_part setDir (_dir + _partDir);
	
	_pos = [_center, _distance, _dirTo+_dir] call BIS_fnc_relPos;
	_pos set [2, _alt];
	
	_part setPosATL _pos;
	_part setDir (_dir + _partDir);
	
	_spawnedObjects set [count _spawnedObjects, _part];
	
	nil
} count _parts;

_spawnedObjects