private ['_index', '_action'];
_index = _this select 3;
_action = BL_playerActions select _index;

[BL_cursorTarget] call (_action select 2);