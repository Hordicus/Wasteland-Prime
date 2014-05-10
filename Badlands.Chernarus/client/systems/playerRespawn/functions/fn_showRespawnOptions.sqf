/*
	Description:
	Update respawn dialog with spawn options. Options
	are sorted by distance.
	
	Parameters(s):
	_spawn_options: ARRAY - list of spawn options to show.
	
	Usage:
		[
			[
				Button text,
				Info text,
				Distance from playerRespawn_lastDeath,
				is blocked,
				data to pass to event handler,
				event handler to call when option is clicked
			]
		] call BL_fnc_showRespawnOptions
*/

#include "macro.sqf"
disableSerialization;

private ['_spawn_options', '_perPage', '_buttons'];
_spawn_options = +([_this, 0, [], [[]]] call BIS_fnc_param);

_buttons = [
	[respawnOptionOneIDC, respawnOptionOneInfoIDC, respawnOptionOneDistIDC],
	[respawnOptionTwoIDC, respawnOptionTwoInfoIDC, respawnOptionTwoDistIDC],
	[respawnOptionThreeIDC, respawnOptionThreeInfoIDC, respawnOptionThreeDistIDC],
	[respawnOptionFourIDC, respawnOptionFourInfoIDC, respawnOptionFourDistIDC],
	[respawnOptionFiveIDC, respawnOptionFiveInfoIDC, respawnOptionFiveDistIDC],
	[respawnOptionSixIDC, respawnOptionSixInfoIDC, respawnOptionSixDistIDC]
];
_numButtons = count _buttons;
_pages = ceil((count _spawn_options)/_numButtons)-1;

if ( _pages < 0 ) then {
	_pages = 0;
};

if ( playerRespawnPage < 0 ) then {
	playerRespawnPage = _pages;
};

if ( playerRespawnPage > _pages ) then {
	playerRespawnPage = 0;
};

playerRespawnOptionEventHandlers = [];

private ['_display', '_offset'];
_display = (findDisplay respawnDialogIDD);
_offset = _numButtons * playerRespawnPage;

// Sort by distance
_spawn_options = [_spawn_options, [], { (_x select 2) distance playerRespawn_lastDeath }, "ASCEND"] call BIS_fnc_sortBy;

{
	private['_btn', '_info', '_dist', '_show', '_data'];
	_btn  = _display displayCtrl (_x select 0);
	_info = _display displayCtrl (_x select 1);
	_dist = _display displayCtrl (_x select 2);
	_show = count _spawn_options > (_forEachIndex + _offset);
	
	if ( _show ) then {
		_data = _spawn_options select (_forEachIndex + _offset);
		_btn  ctrlSetText (_data select 0);
		_info ctrlSetText (_data select 1);
		_dist ctrlSetText format['%1m', round((_data select 2) distance playerRespawn_lastDeath)];
		_btn  ctrlEnable !(_data select 3);
		
		playerRespawnOptionEventHandlers set [count playerRespawnOptionEventHandlers, [_x select 0, _data select 4, _data select 5]];
	};
	
	_btn ctrlShow _show;
	_info ctrlShow _show;
	_dist ctrlShow _show;
} forEach _buttons;

(_display displayCtrl respawnSpawnPagesIDC) ctrlSetText format['Page %1 of %2', playerRespawnPage+1, _pages+1];