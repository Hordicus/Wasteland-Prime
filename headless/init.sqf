BL_HC_callbacks = [[], [[], {}]] call CBA_fnc_hashCreate;

[] spawn {
	"BL_HC_callRes" addPublicVariableEventHandler {
		_code = _this select 1 select 0;
		_res  = _this select 1 select 1;
		
		_cb = [BL_HC_callbacks, _code] call CBA_fnc_hashGet;
		
		[_res, _cb select 0] call (_cb select 1);
	};
};