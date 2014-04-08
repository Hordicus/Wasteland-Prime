/*
	Description:
	Performs player set up before the player is spawned in
	and given control of the unit.
	
	Parameter(s):
	_player - Player to do set up on
*/

_player = [_this, 0, player, [player]] call BIS_fnc_param;
removeAllWeapons player;
removeAllItems player;
removeBackpack player;
removeVest player;
removeUniform player;
removeHeadgear player;
removeGoggles player;
removeAllAssignedItems player;

[player, (GEAR_activeLoadout call GEAR_fnc_toLoadoutArray)] call GEAR_fnc_setLoadout;
player allowDamage true;
player enableSimulation true;
BL_playerSpawning = false;