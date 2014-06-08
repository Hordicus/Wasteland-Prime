#include "\A3\ui_f\hpp\defineDIKCodes.inc"
BL_deleteSafetyOn = true;
PVAR_adminLog = [player, format['%1 (%2) started delete camera', name player, getPlayerUID player]];
publicVariableServer "PVAR_adminLog";

[getPosATL player, {
	(_this select 0) displayAddEventHandler ["KeyDown", {
		if ( (_this select 1) == DIK_DELETE ) then {
			if ( BL_deleteSafetyOn || (_this select 2) ) then {
				if ( (_this select 2) ) then {
					BL_deleteSafetyOn = !BL_deleteSafetyOn;
					if ( BL_deleteSafetyOn ) then {
						hint "Delete safety turned on.";
					}
					else {
						hint "Delete safety turned off.";
					};
				}
				else {
					hint "Delete safety is on. Shift + DEL to turn off.";
				};
			}
			else {
				if ( BIS_fnc_camera_target in allMissionObjects "All" ) then {
					PVAR_adminDelete = [player, BIS_fnc_camera_target];
					publicVariableServer "PVAR_adminDelete";
				};
			};
			true
		};
	}]
}] call BLAdmin_fnc_camera;