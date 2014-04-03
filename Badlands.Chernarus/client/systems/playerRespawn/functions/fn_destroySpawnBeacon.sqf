/*
	Description:
	Destroys a spawn beacon and updates other clients
	
	Parameter(s):
	_beacon - Beacon object
	
	Returns:
	None
*/

private['_beacon'];
_beacon  = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_data = [player, _beacon];

destroySpawnBeacon = _data;
publicVariableServer "destroySpawnBeacon";