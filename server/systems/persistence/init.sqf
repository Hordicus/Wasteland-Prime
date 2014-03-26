"PVAR_loadPlayer" addPublicVariableEventHandler {
	[_this select 1] call BL_fnc_loadPlayer;
};

[] spawn {
	private ['_savePlayer'];
	_savePlayer = {
		private ['_player', '_lastSave'];
		_player = _this select 0;
		_lastSave = _player getVariable ['lastSave', time];
		
		if ( time - _lastSave >= 60 ) then {
			diag_log format['Saving player3 %1', _player];
			[_player] call BL_fnc_savePlayer;
			_player setVariable ['lastSave', time];
		};
	};

	while { true } do {
		{
			_lastSave = _x getVariable ['lastSave', time];
			_processed = _x getVariable ['persistenceEHAdded', false];

			if ( !_processed ) then {
				_x addEventHandler ['Put', _savePlayer];
				_x addEventHandler ['Take', _savePlayer];
				_x addEventHandler ['Killed', _savePlayer];
				_x setVariable ['lastSave', time];
				_x setVariable ['persistenceEHAdded', true];
			};
			
			[_x] call _savePlayer;
		} count playableUnits;
		
		sleep 60 * 3;
	};
};