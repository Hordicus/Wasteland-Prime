private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format['%1 (%2) began spectating %3 (%4)', name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

cutrsc ['RscSpectator','plain'];
RscSpectator_player = _player;

uiNamespace setVariable ['specKeyDown', (findDisplay 46) displayAddEventHandler ['KeyDown', {
	// User hit esc
	if ( _this select 1 == 1 ) then {
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', uiNamespace getVariable 'specKeyDown'];
		cuttext ['','plain'];
		true
	};
}]];
