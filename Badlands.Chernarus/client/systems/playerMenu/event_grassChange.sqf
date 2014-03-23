#include "functions\macro.sqf"
private ['_index'];
_index = lbCurSel grassSettingIDC;
if ( _index >= 0 ) then {
	BL_grass = _index;

	setTerrainGrid (switch _index do {
		case 0: {50};
		case 1: {25};
		case 2: {12.5};
		case 3: {6.25};
		case 4: {3.125};
	});
};