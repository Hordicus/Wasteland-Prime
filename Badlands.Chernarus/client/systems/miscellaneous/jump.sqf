BL_movingForward = false;
(findDisplay 46) displayAddEventHandler ['KeyDown', {
	if ( (_this select 1) in (actionKeys 'MoveForward') ) then {
		BL_movingForward = true;
	}
	else {
		if ( BL_movingForward && (_this select 1) in (actionKeys "GetOver") ) then {
			if ( animationState player != "AovrPercMrunSrasWrflDf" ) then {
				[[player, "AovrPercMrunSrasWrflDf"], "BL_fnc_switchMove"] call BIS_fnc_MP;
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