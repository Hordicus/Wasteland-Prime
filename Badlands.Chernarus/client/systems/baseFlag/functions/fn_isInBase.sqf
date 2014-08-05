private ['_loc'];
_loc = [_this, 0, [0,0,0], [[], objNull]] call BIS_fnc_param;

if ( typeName _loc == "OBJECT" ) then {
	_loc = getPosATL _loc;
};

({
	_loc distance (_x select 2) <= 125
} count BL_PVAR_baseFlags) > 0