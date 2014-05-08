private ['_loc', '_type', '_params', '_interval', '_duration', '_source'];
_loc      = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_type     = [_this, 1, "", [""]] call BIS_fnc_param;
_interval = [_this, 2, -1, [0]] call BIS_fnc_param;
_params   = [_this, 3, [], [[]]] call BIS_fnc_param;
_duration = [_this, 4, 5, [0, ""]] call BIS_fnc_param;

if ( hasInterface ) then {
	_source = objNull;
	if ( typeName (_loc select 0) == "SCALAR" ) then {
		_source = "#particlesource" createVehicleLocal _loc;
	}
	else {
		_source = "#particlesource" createVehicleLocal [0,0,0];
		_source attachTo _loc;
	};

	_source setParticleClass _type;

	if ( count _params > 0 ) then {
		_source setParticleParams _params;
	};

	if ( _interval > -1 ) then {
		_source setDropInterval _interval;
	};

	if ( typeName _duration == "SCALAR" ) then {
		[_duration, _source] spawn {
			sleep (_this select 0);
			deleteVehicle (_this select 1);
		};
	}
	else {
		BL_particleSourceObjects = missionNamespace getVariable ["BL_particleSourceObjects", [[], objNull] call CBA_fnc_hashCreate];
		[BL_particleSourceObjects, _duration, _source] call CBA_fnc_hashSet;
	};	
};