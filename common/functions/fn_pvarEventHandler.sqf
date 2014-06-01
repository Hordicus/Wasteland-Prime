private ['_pvar', '_pvarEh'];
_pvar = _this select 0;
_pvarEh = [BL_pvarEventHandlers, _pvar] call CBA_fnc_hashGet;

if ( (_pvarEh select 0) call BL_fnc_shouldRun ) then {
	_this call (_pvarEh select 1);
}
else {
	if ( isServer ) then {
		private ['_runsOn'];
		_runsOn = [call BL_fnc_systemsConfig, (_pvarEh select 0)] call CBA_fnc_hashGet;
		
		{
			if ( _runsOn == (_x select 1) ) exitwith {
				missionNamespace setVariable [_pvar, _this select 1];
				(_x select 0) publicVariableClient _pvar;
			};
		} count BL_HCs;
	};
};