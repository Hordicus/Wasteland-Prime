#include "functions\macro.sqf"
_money = [] call BL_fnc_money;
_loadoutTotal = GEAR_activeLoadout call GEAR_fnc_loadoutTotal;

if ( _money < _loadoutTotal && BL_showLowMoneyWarning ) then {
	BL_showLowMoneyWarning = false;
	hint "You do not have enough money for your current loadout. Click again to spawn anyway.";
}
else {
	_spawn = [] call BL_fnc_randomSpawnLocation;
	_loc = _spawn select 1;

	if ( BL_playerSpawning ) then {
		[player] call BL_fnc_playerSetup;
	};

	if (_this == 'ground' ) then {
		player setPosATL _loc;
	}
	else {
		_loc set[2, 'haloSpawnHeight' call BL_fnc_config];
		player setPosATL _loc;
		[player, _loc select 2, false, false, true] call COB_fnc_HALO;
	};
	
	[] call BL_fnc_showLocationInfo;
	closeDialog respawnDialogIDD;
};
