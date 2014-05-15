#include "\x\bl_server\addons\performance.sqf"
['playerMenu', 'onPlayerDisconnected', {
	['groupChange', []] call CBA_fnc_globalEvent;
}] call BIS_fnc_addStackedEventHandler;

["killed", {
	private ["_player","_invItems","_position","_type","_item"];
	_player = _this select 0;
	_invItems = _player getVariable ['BL_playerInv', []];
	
	{
		_type = _x;
		_position = getPosATL _player;
		{
			if ( _x select 0 == _type ) exitwith {
				_emptySpot = _position findEmptyPosition [0, 5, _x select 2];
				if ( count _emptySpot == 0 ) then {
					_emptySpot = _position;
				};
				
				_item = createVehicle [_x select 2, _emptySpot, [], 0, "NONE"];
				[_item, 'invItem'] call BL_fnc_trackVehicle;
				
				_item setVariable ['BL_invDroppedItem', true, true];
				_item setVariable ['BL_invDroppedType', _x select 0, true];
			};
			true
		} count BL_playerInventoryHandlers;
		true
	} count _invItems;
}] call CBA_fnc_addEventHandler;

["respawn", {
	(_this select 0) setVariable['BL_playerInv', [], true];
}] call CBA_fnc_addEventHandler;

[] spawn {
	private ['_mission_start'];
	_mission_start = diag_tickTime;
	while { true } do {
		PERF_START('serverUpdate');
		['serverUpdate', [
			round diag_fps,
			diag_tickTime - _mission_start
		]] call CBA_fnc_globalEvent;
		PERF_STOP('serverUpdate', true);
		sleep 10;
	};
};