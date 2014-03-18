BL_footViewDistance = 1000;
BL_carViewDistance  = 1000;
BL_airViewDistance  = 2000;

[] spawn {
	private ['_last'];
	_last = objNull;
	while {true} do {
		waituntil { _last != vehicle player };
		[] call BL_fnc_setViewDistance;
		_last = vehicle player;
	};
};