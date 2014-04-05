private ['_config', '_mission', '_location'];
_config = call BL_fnc_missionsConfig;
_missions = [_config, 'missions'] call CBA_fnc_hashGet;

missionCount = missionCount + 1;
_missionCode = format['mission%1', missionCount];

_mission = [_missions, 1] call BL_fnc_selectRandom;
_mission = call compile preprocessFileLineNumbers format['\x\bl_server\addons\systems\missions\missions\%1.sqf', _mission select 0];

_location = _mission select 2;

if ( typeName _location == "CODE" ) then {
	_location = call _location;
};

[runningMissionLocations, _missionCode, _location] call CBA_fnc_hashSet;

// Creates task/waypoint/notice on all clients
[true, _missionCode, [
	_mission select 1,
	_mission select 0,
	format['Mission: %1', _mission select 0]
], _location, 'CREATED', 0] call BIS_fnc_taskCreate;

// Spawn mission's init
[_missionCode, _location] spawn (_mission select 3);