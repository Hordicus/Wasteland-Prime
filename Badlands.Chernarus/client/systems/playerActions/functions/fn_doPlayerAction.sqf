private ['_actionTarget', '_action'];
_index = _this select 3;
_actionTarget = BL_playerActionTargets select _index;
_action = BL_playerActions select _index;

[_actionTarget] call (_action select 2);