private ['_args', '_fnc', '_cbArgs', '_cb', '_cbCode'];
_args    = [_this, 0, [], [[]]] call BIS_fnc_param;
_fnc     = [_this, 1, "", [""]] call BIS_fnc_param;
_cbArgs  = [_this, 2, [], [[]]] call BIS_fnc_param;
_cb      = [_this, 3, false, [{}, false]] call BIS_fnc_param;

_cbCode = "";

if ( typeName _cb == "CODE" ) then {
	_cbCode = 10 call BL_fnc_randStr;
	
	[BL_HC_callbacks, _cbCode, [_cbArgs, _cb]] call CBA_fnc_hashSet;
};

BL_HC_call = [player, _args, _fnc, _cbCode];
publicVariableServer "BL_HC_call";

nil