private ["_objType","_event","_params","_index","_typeHandlers"];
_objType = [_this, 0, "", [""]] call BIS_fnc_param;
_event   = [_this, 1, "", [""]] call BIS_fnc_param;
_params  = [_this, 2, [], [[]]] call BIS_fnc_param;

_index = _event call {
	if ( _this == 'save') exitwith{0};
	if ( _this == 'load') exitwith{1};
};

_typeHandlers = [PERS_typeHandlers, _objType] call CBA_fnc_hashGet;

if ( !isNil {_typeHandlers select _index} ) then {
	_params call (_typeHandlers select _index)
};
