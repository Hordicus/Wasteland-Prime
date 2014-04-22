#include "functions\macro.sqf"
disableSerialization;
_dialog = uiNamespace getVariable 'adminPanel';

_action = (_this select 0) lbData (_this select 1);

_action call {
	if ( _this == "spec" ) exitwith {
		closeDialog 0;
		cutrsc ['RscSpectator','plain'];
		RscSpectator_player = BL_adminPlayer;
		
		uiNamespace setVariable ['adminKeyDown', (findDisplay 46) displayAddEventHandler ['KeyDown', {
			// User hit esc
			if ( _this select 1 == 1 ) then {
				(findDisplay 46) displayRemoveEventHandler ['KeyDown', uiNamespace getVariable 'adminKeyDown'];
				cuttext ['','plain'];
				true
			};
		}]];
	};
};