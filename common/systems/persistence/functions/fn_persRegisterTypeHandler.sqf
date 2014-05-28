private ["_objType","_event","_params","_eh","_types","_events","_index"];
_objType = [_this, 0, "", [""]] call BIS_fnc_param;
_events   = [_this, 1, [], [[]]] call BIS_fnc_param;

PERS_typeHandlers = missionNamespace getVariable ['PERS_typeHandlers', [] call CBA_fnc_hashCreate];
[PERS_typeHandlers, _objType, _events] call CBA_fnc_hashSet;

{
	if ( _x select 0 == _objType ) then {
		(_x select 1) call (_events select 1);
		PERS_typeData set [_forEachIndex, "REMOVE"];
	};
} forEach PERS_typeData;

PERS_typeData = PERS_typeData - ["REMOVE"];