private ['_config', '_key', '_return'];
_key = [_this, 0, '', ['']] call BIS_fnc_param;
_config = [] call CBA_fnc_hashCreate;

[_config, 'airBeaconModel', 'Land_SatellitePhone_F'] call CBA_fnc_hashSet;
[_config, 'groundBeaconModel', 'Land_SurvivalRadio_F'] call CBA_fnc_hashSet;

[_config, 'buildingStore', [
	["Concrete", [
		["", "Land_CncBarrier_F", 100],
		["", "Land_CncWall1_F", 100],
		["", "BlockConcrete_F", 100],
		["", "Land_RampConcrete_F", 100],
		["", "Land_RampConcreteHigh_F", 100]
	]],
	["Sandbags", [
		["", "Land_BagBunker_Small_F", 100],
		["", "Land_BagFence_Long_F", 100],
		["", "Land_BagFence_Round_F", 100]
	]]
]] call CBA_fnc_hashSet;

[_config, 'generalStore', [
	["General Store", [
		["Air Beacon", 8000, "Air beacon description.", {'airBeacon' call BL_fnc_addInventoryItem;}],
		["Ground Beacon", 4000, "Ground beacon description.", {'groundBeacon' call BL_fnc_addInventoryItem;}]
	]]
]] call CBA_fnc_hashSet;


_return = '';
if ( _key == '' ) then {
	_return = _config;
}
else {
	_return = [_config, _key] call CBA_fnc_hashGet;
};

_return