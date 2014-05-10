private ["_players", "_friendlies"];
_players = _this;
_friendlies = [];

{
	if ( [[_x]] call BL_fnc_friendlyState == "FRIENDLY" ) then {
		_friendlies set [count _friendlies, _x];
	};
} count _players;

_friendlies