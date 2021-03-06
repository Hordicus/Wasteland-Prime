BL_ignoreDropTypes = 'ignoreDropTypes' call BL_fnc_config;
['onPlayerDisconnected', {
	if ( 'objectLoad' call BL_fnc_shouldRun ) then {
		// Delete dropped money on player DC
		{
			if ( (_x getVariable ['player', '']) == (_this select 1) ) then {
				deleteVehicle _x;
			};
			nil
		} count entities ('moneyModel' call BL_fnc_config);
	};
}] call CBA_fnc_addEventHandler;

["killed", {
	if ( 'objectLoad' call BL_fnc_shouldRun ) then {
		private ["_player","_invItems","_position","_type","_item"];
		_player = _this select 0;
		_invItems = _player getVariable ['BL_playerInv', []];
		
		{
			_type = _x;
			_position = getPosATL _player;
			{
				if ( _x select 0 == _type ) exitwith {
					if !( _type in BL_ignoreDropTypes ) then {
						_emptySpot = _position findEmptyPosition [0, 5, _x select 2];
						if ( count _emptySpot == 0 ) then {
							_emptySpot = _position;
						};
						
						_item = createVehicle [_x select 2, _emptySpot, [], 0, "NONE"];
						[_item, 'invItem'] call BL_fnc_trackVehicle;
						
						_item setVariable ['BL_invDroppedItem', true, true];
						_item setVariable ['BL_invDroppedType', _x select 0, true];
					};
				};
				true
			} count BL_playerInventoryHandlers;
			true
		} count _invItems;
	};
}] call CBA_fnc_addEventHandler;

["respawn", {
	if ( 'objectLoad' call BL_fnc_shouldRun ) then {
		(_this select 0) setVariable['BL_playerInv', [], true];
	};
}] call CBA_fnc_addEventHandler;

if ( isServer ) then {
	[] spawn {
		private ['_mission_start'];
		_mission_start = diag_tickTime;
		while { true } do {
			['serverUpdate', [
				round diag_fps,
				diag_tickTime - _mission_start
			]] call CBA_fnc_globalEvent;
			sleep 10;
		};
	};
};