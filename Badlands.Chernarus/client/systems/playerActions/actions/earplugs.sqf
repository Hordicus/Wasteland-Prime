[
	{
		if (soundVolume == 1) then {
			'<t color="#32C832">Put on ear plugs</t>'
		} else {
			'<t color="#32C832">Take off ear plugs</t>'
		}
	},
	{
		true
	},
	{
		if (soundVolume == 1) then {
			1 fadeSound 0.3;
		} else {
			1 fadeSound 1;
		}
	},
	-1,
	-90,
	true
]call BL_fnc_addAction;