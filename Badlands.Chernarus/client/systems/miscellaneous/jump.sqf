BL_movingForward = false;
(findDisplay 46) displayAddEventHandler ['KeyDown', {
	if ( (_this select 1) in (actionKeys 'MoveForward') ) then {
		BL_movingForward = true;
	}
	else {
		if ( BL_movingForward && (_this select 1) in (actionKeys "GetOver") && vehicle player == player ) then {
			if ( animationState player != "AovrPercMrunSrasWrflDf" ) then {
				"AovrPercMrunSrasWrflDf" call BL_fnc_switchMove;
			};
			true
		};
	};
}];

(findDisplay 46) displayAddEventHandler ['KeyUp', {
	if ( (_this select 1) in (actionKeys 'MoveForward') ) then {
		BL_movingForward = false;
	};
}];