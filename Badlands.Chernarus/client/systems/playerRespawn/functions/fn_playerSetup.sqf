/*
	Description:
	Performs player set up before the player is spawned in
	and given control of the unit.
	
	Parameter(s):
	_player - Player to do set up on
*/

private ['_player', '_money', '_loadoutTotal'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
removeAllWeapons player;
removeAllItems player;
removeBackpack player;
removeVest player;
removeUniform player;
removeHeadgear player;
removeGoggles player;
removeAllAssignedItems player;

_money = [] call BL_fnc_money;
_loadoutTotal = GEAR_activeLoadout call GEAR_fnc_loadoutTotal;

if ( _money >= _loadoutTotal ) then {
	[player, ((GEAR_activeLoadout call GEAR_fnc_filterLoadout) call GEAR_fnc_toLoadoutArray)] call GEAR_fnc_setLoadout;
	_loadoutTotal call BL_fnc_subMoney;
};

player allowDamage true;
player enableSimulation true;
BL_playerSpawning = false;