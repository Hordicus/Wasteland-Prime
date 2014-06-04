private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format['%1 (%2) began spectating %3 (%4)', name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

cutrsc ['RscSpectator','plain'];

_player spawn {
	waitUntil { !isNil "RscSpectator_player" };
	RscSpectator_player = _this;
	[] call BLAdmin_fnc_hud;
	showHUD true; // Spec turns this off
	vehicle RscSpectator_player switchcamera cameraview;
	("RscSpectator_fade" call bis_fnc_rscLayer) cuttext ["","black in"];
};

uiNamespace setVariable ['specKeyDown', (findDisplay 46) displayAddEventHandler ['KeyDown', {
	// User hit esc
	if ( _this select 1 == 1 ) then {
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', uiNamespace getVariable 'specKeyDown'];
		cuttext ['','plain'];
		false call BLAdmin_fnc_hud;
		true
	};
}]];
