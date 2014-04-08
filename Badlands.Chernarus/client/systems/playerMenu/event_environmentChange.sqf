#include "functions\macro.sqf"
private ['_index'];
_index = lbCurSel enableEnvironmentIDC;
if ( _index >= 0 ) then {
	BL_enableEnv = _index;
	[BL_enableEnv] call BL_fnc_setEnvEnabled;
};