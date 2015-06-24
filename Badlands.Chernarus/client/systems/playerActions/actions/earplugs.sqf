[
	{
		if (soundVolume == 1) then {
			"Put on ear plugs"
		} else {
			"Take off ear plugs"
		}
	},
	{
		true
	},
	{
		if (soundVolume == 1) then {
			1 fadeSound 0.5;
		} else {
			1 fadeSound 1;
		}
	},
	-90,
	20
]call BL_fnc_addAction;