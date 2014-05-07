_clickedIDC = ctrlIDC (_this select 0);

_money = [] call BL_fnc_money;
_loadoutTotal = GEAR_activeLoadout call GEAR_fnc_loadoutTotal;

if ( _money < _loadoutTotal && BL_showLowMoneyWarning ) then {
	BL_showLowMoneyWarning = false;
	hint "You do not have enough money for your current loadout. Click again to spawn anyway.";
}
else {
	{
		if ( _x select 0 == _clickedIDC ) then {
			if ( BL_playerSpawning ) then {
				[player] call BL_fnc_playerSetup;
			};
			(_x select 1) call (_x select 2);
		};

	} count playerRespawnOptionEventHandlers;
};