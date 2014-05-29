if ( isServer ) then {
	[] spawn {
		"BL_PVAR_publicVariableClientRelay" addPublicVariableEventHandler {
			diag_log format["BL_PVAR_publicVariableClientRelay: %1", _this];
			_pvar = _this select 0;
			
			missionNamespace setVariable [_pvar select 2, _pvar select 1];
			(owner (_pvar select 0)) publicVariableClient (_pvar select 2);
		};
	};
};