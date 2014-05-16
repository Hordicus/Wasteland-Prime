private ["_pos", "_men", "_vehicles", "_animals", "_radius","_players"];

_pos      = _this select 0;
_radius   = _this select 1;
_men      = _pos nearEntities [["CAManBase", "Air", "LandVehicle"], _radius];

_players = [];
{
	{
		if ( isPlayer _x ) then {
			_players set [count _players, _x];
		};
	} count crew _x;
	nil
} count _men;

_players
