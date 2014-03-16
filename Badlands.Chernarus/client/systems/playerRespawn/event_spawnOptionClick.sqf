_clickedIDC = ctrlIDC (_this select 0);

{
	if ( _x select 0 == _clickedIDC ) then {
		[player] call BL_fnc_playerSetup;
		(_x select 1) call (_x select 2);
	};

} count playerRespawnOptionEventHandlers;