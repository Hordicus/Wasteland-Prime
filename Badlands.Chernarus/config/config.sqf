private ['_config', '_key', '_return'];
_key = [_this, 0, '', ['']] call BIS_fnc_param;
_config = [] call CBA_fnc_hashCreate;

[_config, 'airBeaconModel', 'Land_SatellitePhone_F'] call CBA_fnc_hashSet;
[_config, 'groundBeaconModel', 'Land_SurvivalRadio_F'] call CBA_fnc_hashSet;
[_config, 'moneyModel', 'EvMoney'] call CBA_fnc_hashSet;

[_config, 'HUDServerInfo', format['
	<t font="EtelkaNarrowMediumPro" color="#80FFFFFF">
	<t size="2">%1</t><br />
	%2<br />
	%3<br />
	%4<br />
	</t>
	',
	'Gaming Community',
	'Server Info',
	'Community Info #1',
	'Community Info #2'
]] call CBA_fnc_hashSet;

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
		["Ground Beacon", 4000, "Ground beacon description.", {'groundBeacon' call BL_fnc_addInventoryItem;}],
		["Quadcopter UAV", 4000, "Quadcopter description.", {'quadcopter' call BL_fnc_addInventoryItem;}],
		["K40 Ababil-3 UAV", 4000, "K40 Ababil-3 description.", {'ababil' call BL_fnc_addInventoryItem;}]
	]]
]] call CBA_fnc_hashSet;

[_config, 'minMoney', 250] call CBA_fnc_hashSet;
[_config, 'killBounty', 250] call CBA_fnc_hashSet;

// See addons\randomWeather2.sqf for config options
[_config, 'weatherTemplates', [
	["Clear",[0,1,5],[0.30,0,0,1,1]],
	["Overcast",[0,1,2],[0.50,0,0,2,2]],
	["Light Rain",[1,2,3,5],[0.60,0.3,0.05,3,3]],
	["Medium Rain",[2,3,4],[0.70,0.5,0.05,4,4]],
	["Rainstorm",[3],[0.80,0.9,0.1,5,5]],
	["Light Fog",[0,2,5,6],[0.4,0,[0.2,0.01,10],0,0]],
	["Medium Fog",[5,6,7],[0.4,0,[0.4,0.005,20],0,0]],
	["Dense Fog",[6],[0.5,0,[0.4,0.0025,30],0,0]]
]] call CBA_fnc_hashSet;

[_config, 'weatherCycleTime', 20 * 60] call CBA_fnc_hashSet;

_return = '';
if ( _key == '' ) then {
	_return = _config;
}
else {
	_return = [_config, _key] call CBA_fnc_hashGet;
};

_return