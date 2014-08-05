private ['_pvar', '_system', '_fnc'];
_pvar   = [_this, 0, "", [""]] call BIS_fnc_param;
_system = [_this, 1, "", [""]] call BIS_fnc_param;
_fnc    = [_this, 2, {}, [{}]] call BIS_fnc_param;

BL_pvarEventHandlers = missionNamespace getVariable ["BL_pvarEventHandlers", [] call CBA_fnc_hashCreate];
[BL_pvarEventHandlers, _pvar, [_system, _fnc]] call CBA_fnc_hashSet;

_pvar spawn {
	_this addPublicVariableEventHandler BL_fnc_pvarEventHandler;
};