#include "macro.sqf"
disableSerialization;

private ['_towns', '_beacons', '_helis', '_distFrom', '_options', '_perPage', '_buttons'];
_towns = _this select 0;
_beacons = _this select 1;
_helis = _this select 2;
_distFrom = _this select 3;
_options = [];
_numButtons = 6;
_buttons = [
	[respawnOptionOneIDC, respawnOptionOneInfoIDC, respawnOptionOneDistIDC],
	[respawnOptionTwoIDC, respawnOptionTwoInfoIDC, respawnOptionTwoDistIDC],
	[respawnOptionThreeIDC, respawnOptionThreeInfoIDC, respawnOptionThreeDistIDC],
	[respawnOptionFourIDC, respawnOptionFourInfoIDC, respawnOptionFourDistIDC],
	[respawnOptionFiveIDC, respawnOptionFiveInfoIDC, respawnOptionFiveDistIDC],
	[respawnOptionSixIDC, respawnOptionSixInfoIDC, respawnOptionSixDistIDC]
];

playerRespawnOptionEventHandlers = [];

_townRespawn = {
	private ['_loc'];
	_loc = [_this] call BL_fnc_randomSpawnLocation;

	player setPos (_loc select 1);
	closeDialog respawnDialogIDD;
};

[_towns, {
	// Button Text, Info, Distance, Blocked
	_friendlies = [];
	{
		_friendlies set [count _friendlies, name _x];
	} count ((_value select 0) call BL_fnc_filterFriendly);
	
	if ( count _friendlies > 0 ) then {
		_town = [_key, _value select 2 select 0, _value select 2 select 1];
		
		_options set [count _options, [
			_key, // Btn text
			[_friendlies, ', '] call CBA_fnc_join, // Info
			round((_value select 2 select 0) distance playerRespawn_lastDeath), // Dist
			(_value select 1) != "FRIENDLY", // Blocked
			_town, // Data to pass to handler
			_townRespawn // Btn click handler
		]];
	};
}] call CBA_fnc_hashEachPair;

private ['_display', '_offset'];
_display = (findDisplay respawnDialogIDD);
_offset = _numButtons * playerRespawnPage;

// Sort by distance
_options = [_options, [], { _x select 2 }, "ASCEND"] call BIS_fnc_sortBy;

{
	private['_btn', '_info', '_dist', '_show', '_data'];
	_btn  = _display displayCtrl (_x select 0);
	_info = _display displayCtrl (_x select 1);
	_dist = _display displayCtrl (_x select 2);
	_show = count _options > (_forEachIndex + _offset);
	
	if ( _show ) then {
		_data = _options select (_forEachIndex + _offset);
		_btn  ctrlSetText (_data select 0);
		_info ctrlSetText (_data select 1);
		_dist ctrlSetText format['%1m', _data select 2];
		_btn  ctrlEnable !(_data select 3);
		
		playerRespawnOptionEventHandlers set [count playerRespawnOptionEventHandlers, [_x select 0, _data select 4, _data select 5]];
	};
	
	_btn ctrlShow _show;
	_info ctrlShow _show;
	_dist ctrlShow _show;
} forEach _buttons;