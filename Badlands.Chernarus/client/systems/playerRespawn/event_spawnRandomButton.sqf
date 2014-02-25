#include "dialog\defines.sqf"
_spawn = call playerRespawn_randomSpawnLocation;
_loc = _spawn select 1;

if (_this == 'ground' ) then {
	player setPosATL _loc;
}
else {
	_loc set[2, 1000];
	player setPosATL _loc;
	[player, 1000, false, false, true] call COB_fnc_HALO;
};

closeDialog respawnDialogIDD;