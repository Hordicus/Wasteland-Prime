private ['_player', '_side', '_name', '_playerIndex'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_side = _player getVariable 'side';
_name = _player getVariable 'name';

if ( isNil "_side" || isNil "_name" ) exitwith {-1};

_playerIndex = BL_scoreboardLookup find (format['%1%2', _side, _name]);

_playerIndex