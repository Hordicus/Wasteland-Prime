[
	{
		format['Repair %1', getText (configFile >> "CfgVehicles" >> typeOf (_this select 0) >> "displayName")]
	},
	
	{
		!BL_animDoWorkInProgress &&
		"ToolKit" in (backpackItems player) && (
			((_this select 0) isKindOf "LandVehicle" || (_this select 0) isKindOf "Air")
			&& damage (_this select 0) > 0
			&& alive (_this select 0)
		)
	},
	{
		(_this select 0) call BL_fnc_doHeal;
	},
	20
] call BL_fnc_addAction;