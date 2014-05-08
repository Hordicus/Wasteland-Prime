private ['_code'];
_code = [_this, 0, "", [""]] call BIS_fnc_param;

if ( hasInterface ) then {
	BL_particleSourceObjects = missionNamespace getVariable ["BL_particleSourceObjects", [[], objNull] call CBA_fnc_hashCreate];
	deleteVehicle ([BL_particleSourceObjects, _code] call CBA_fnc_hashGet);
};