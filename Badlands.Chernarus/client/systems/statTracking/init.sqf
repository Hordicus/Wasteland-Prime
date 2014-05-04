BL_scoreboard = missionNamespace getVariable ["BL_scoreboard", [
	// [_rank, _side, _playerName, _bounty, _kills, _deaths, _score ],
]];

BL_showingScoreboard = false;
[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	(findDisplay 46) displayAddEventHandler ['KeyDown', {
		if ( (_this select 1) in actionKeys 'NetworkStats' && !BL_showingScoreboard) then {
			BL_showingScoreboard = true;
			('BLscoreboard' call BIS_fnc_rscLayer) cutRsc ['scoreboardRsc', 'PLAIN', 0.01, false];
			true
		};
	}];
	
	(findDisplay 46) displayAddEventHandler ['KeyUp', {
		if ( (_this select 1) in actionKeys 'NetworkStats' ) then {
			BL_showingScoreboard = false;
			('BLscoreboard' call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
		};
	}];
};