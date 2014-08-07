private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

BL_Logic getVariable [
	format['%1%2', _player getVariable 'side', _player getVariable 'name'],
	[
		0, // Rank
		0, // Bounty
		0, // Kills
		0, // Deaths
		0  // Points
	]
];