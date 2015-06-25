[
	{
		if !( (_this select 0) isKindOf "Man" ) then {
			'Treat yourself'
		}
		else {
			format['Treat %1', getText (configFile >> "CfgVehicles" >> typeOf (_this select 0) >> "displayName")]
		};
	},
	
	{
		!BL_animDoWorkInProgress
		&& vehicle player == player
		&& "Medikit" in (backpackItems player) && (
			((_this select 0) isKindOf "Man" && damage (_this select 0) > 0.05 && alive (_this select 0))
			|| damage player > 0.05
		)
	},
	{
		_cursorTarget = _this select 0;
		if !( _cursorTarget isKindOf "Man" ) then {
			_cursorTarget = player;
		};
		
		[_cursorTarget] call BL_fnc_doHeal;
	},
	-1,
	20,
	false
] call BL_fnc_addAction;