private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format["%1 (%2) slayed %3 (%4)", name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

_player setDamage 1;
_player spawn {
	while { !isNull _this } do {
		deleteVehicle _this;
		sleep 0.5;
	};
};