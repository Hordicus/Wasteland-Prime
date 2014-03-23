#include "functions\macro.sqf"
private ['_index'];
_index = lbCurSel enableEnvironmentIDC;
if ( _index >= 0 ) then {
	BL_enableEnv = _index;

	enableEnvironment (switch _index do {
		case 0: {false};
		case 1: {true};
	});
};