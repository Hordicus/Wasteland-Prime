#include "macro.sqf"
private ['_towns', '_townRespawn', '_result'];
_towns = [_this, 0, [] call CBA_fnc_hashCreate, [[]], [4]] call BIS_fnc_param;
_result = [];


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
		
		_result set [count _result, [
			_key, // Btn text
			[_friendlies, ', '] call CBA_fnc_join, // Info
			_value select 2 select 0, // Location
			(_value select 1) != "FRIENDLY", // Blocked
			_town, // Data to pass to handler
			_townRespawn // Btn click handler
		]];
	};
}] call CBA_fnc_hashEachPair;

_result