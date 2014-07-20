if ( isNil "PERS_init_done" ) then {
	[] spawn {
		waitUntil { isServer || isPlayer player };
		if ( 'objectLoad' call BL_fnc_shouldRun ) then {
			private ['_fobs'];
			_fobs = [call BL_fnc_fobsConfig, 'fobs'] call CBA_fnc_hashGet;

			private ['_name', '_pos', '_parts', '_marker', '_spawnedParts'];
			{
				_name  = _x select 0;
				_pos   = _x select 1;
				_parts = _x select 2;
				
				_marker = createMarker [format['fob_%1', _pos], _pos];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "mil_dot_noshadow";
				_marker setMarkerColor "ColorKhaki";
				_marker setMarkerText _name;
				
				_spawnedParts = [_pos, 0, _parts] call BL_fnc_spawnCollection;
				
				{
					_x allowDamage false;
					_x enableSimulationGlobal false;
					_x setVariable ['LOG_disabled', true, true];
					nil
				} count _spawnedParts;
				
				nil
			} count _fobs;
		};
	};
};