private ['_obj', '_simulation', '_persistant'];
_obj        = [_this, 0, objNull, [objNull]] call BL_fnc_param;
_simulation = [_this, 1, false, [false]] call BL_fnc_param;
_persistant = [_this, 2, false, [false]] call BL_fnc_param;

_obj allowDamage false;
_obj addEventHandler ["HandleDamage", {
	if ( damage (_this select 0) > 0 ) then {
		(_this select 0) setDamage 0;
	};
	
	false
}];

_obj addEventHandler ["Killed", {
	(_this select 0) setDamage 0;
}];

_obj enableSimulation _simulation;

if ( (isServer || !hasInterface) && _persistant ) then {
	BL_PVAR_protect = missionNamespace getVariable ['BL_PVAR_protect', []];
	
	BL_PVAR_protect set [count BL_PVAR_protect, [_obj, _simulation]];
	publicVariable "BL_PVAR_protect";
};

_obj