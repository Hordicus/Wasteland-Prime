private ['_player', '_move', '_allowed'];
_move   = [_this, 0, "", [""]] call BIS_fnc_param;
_player = [_this, 1, player, [objNull]] call BIS_fnc_param;
_mp     = [_this, 2, false, [false]] call BIS_fnc_param;

_allowed = [
	"AovrPercMrunSrasWrflDf", // Jump
	"amovpknlmstpsraswrfldnon", // Crouch
	"ainvpknlmstpslaywrfldnon_medic" // animDoWork animation
];

if !( isPlayer _player && _move in _allowed ) exitwith{};

if ( local _player && !_mp) then {
	_player switchMove _move;
	[[_move, _player, true], "BL_fnc_switchMove", true] call BIS_fnc_MP;
}
else {
	if ( !local _player && _mp ) then {
		_player switchMove _move;
	};
};