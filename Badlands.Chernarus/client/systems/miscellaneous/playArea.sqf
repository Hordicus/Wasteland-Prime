_cfgOption = 'playArea' call BL_fnc_config;

_x1 = _cfgOption select 0;
_x2 = _cfgOption select 1;
_timer = _cfgOption select 2;
_outOfBoundsTimer = [] spawn {};

while { true } do {
	_loc = getPosATL player;
	
	if (
		// Not Respawning
		alive player &&
		player distance getMarkerPos 'respawn_west' > 100 &&
		player distance getMarkerPos 'respawn_guerrila' > 100 &&
		isNull (findDisplay 3000) && // Respawn dialog
		isNull (findDisplay 6000) && // Loading dialog
		
		// And out of Bounds
		!([_loc, _x1, _x2] call BL_fnc_withinArea)) then {
		BL_outOfPlayArea = true;
	
		if ( scriptDone _outOfBoundsTimer ) then {
			_outOfBoundsTimer = _timer spawn {
				_start = diag_tickTime;
				waitUntil {
					[format["You have %1s to return to the play area.", _this - round(diag_tickTime - _start)]] call BL_fnc_actionText;
					diag_tickTime - _start > _this || !BL_outOfPlayArea
				};
				
				if ( BL_outOfPlayArea ) then {
					(vehicle player) setDamage 1;
				};
				
				[""] call BL_fnc_actionText;
			};
		};
	}
	else {
		BL_outOfPlayArea = false;
	};
	
	sleep 1;
};