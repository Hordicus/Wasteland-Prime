private ["_config","_missions","_missionCode","_mission","_missionInit","_missionName","_missionDesc","_missionLoc","_missionRun","_initResult"];
_config = call BL_fnc_missionsConfig;
_missions = [_config, 'missions'] call CBA_fnc_hashGet;

missionCount = missionCount + 1;
_missionCode = format['mission%1', missionCount];

_mission = [_missions, 1] call BL_fnc_selectRandom;
_mission = call compile preprocessFileLineNumbers format['\x\bl_server\addons\systems\missions\missions\%1.sqf', _mission select 0];

private ['_missionInit', '_missionName', '_missionDesc', '_missionLoc', '_missionRun', '_initResult'];
_missionInit = [_mission, 0, {}, [{}]] call BIS_fnc_param;
_missionName = [_mission, 1, '', [{}, '']] call BIS_fnc_param;
_missionDesc = [_mission, 2, '', [{}, '']] call BIS_fnc_param;
_missionLoc  = [_mission, 3, [], [[], {}, objNull]] call BIS_fnc_param;
_missionRun  = [_mission, 4, {}, [{}]] call BIS_fnc_param;

_initResult = [] call _missionInit;

if ( typeName _missionLoc == "CODE" ) then {
	_missionLoc = [_initResult] call _missionLoc;
};

if ( typeName _missionName == "CODE" ) then {
	_missionName = [_initResult, _missionLoc] call _missionName;
};

if ( typeName _missionDesc == "CODE" ) then {
	_missionDesc = [_initResult, _missionLoc]  call _missionDesc;
};

// Creates task/waypoint/notice on all clients
[true, _missionCode, [
	_missionDesc,
	_missionName,
	_missionName
], _missionLoc, 'CREATED', 0] call BIS_fnc_taskCreate;

// Spawn mission's init
[_initResult, _missionCode, _missionLoc] spawn _missionRun;

if ( count _missionLoc == 2 && typeName (_missionLoc select 0) == "OBJECT" ) then {
	_missionLoc = _missionLoc select 0
};

[runningMissionLocations, _missionCode, _missionLoc] call CBA_fnc_hashSet;
