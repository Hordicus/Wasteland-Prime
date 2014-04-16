private ['_obj', '_cbArgs', '_cb'];
_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_cbArgs = [_this, 1, [], [[]]] call BIS_fnc_param;
_cb = [_this, 2, false, [{}, false]] call BIS_fnc_param;

PVAR_requestSave = [player, _obj, typeName _cb == "CODE"];
publicVariableServer "PVAR_requestSave";

if ( typeName _cb == "CODE" ) then {
	[_cbArgs, _cb] spawn {
		PVAR_requestSaveDone = false;
		waitUntil {PVAR_requestSaveDone};
		
		(_this select 0) call (_this select 1);
	};
};