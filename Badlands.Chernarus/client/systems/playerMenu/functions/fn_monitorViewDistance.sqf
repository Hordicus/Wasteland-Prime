BL_footViewDistance = profileNamespace getVariable ['BL_footViewDistance', 1000];
BL_carViewDistance  = profileNamespace getVariable ['BL_carViewDistance', 1000];
BL_airViewDistance  = profileNamespace getVariable ['BL_airViewDistance', 2000];

if ( BL_footViewDistance < 500 || BL_footViewDistance > 5000 ) then {
	BL_footViewDistance = 1000;
};

if ( BL_carViewDistance < 500 || BL_carViewDistance > 5000 ) then {
	BL_carViewDistance = 1000;
};

if ( BL_airViewDistance < 500 || BL_airViewDistance > 5000 ) then {
	BL_airViewDistance = 1000;
};

[] spawn {
	private ['_last'];
	_last = objNull;
	while {true} do {
		waituntil { _last != vehicle player };
		[] call BL_fnc_setViewDistance;
		_last = vehicle player;
	};
};