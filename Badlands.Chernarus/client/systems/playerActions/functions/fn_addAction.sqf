/*
	Description:
	Adds an action the the player. Useful for adding actions
	that should be available depending on what the player is
	looking at.
	
	Parameter(s):
	_actionName - String or code that returns name
	_actionCheck - Function that returns true/false depending on
		if the action should show.
	_action - Function to call when action is triggered
	_actionPriority - Priority to use for addAction. Default 1.5.
	
	Returns:
	Index - Use to remove action
	
*/

private ['_actionName', '_actionCheck', '_action', '_actionPriority'];
_actionName = [_this, 0, "", [{}, ""]] call BIS_fnc_param;
_actionCheck = [_this, 1, {false}, [{}]] call BIS_fnc_param;
_action = [_this, 2, {}, [{}]] call BIS_fnc_param;
_actionPriority = [_this, 3, 1.5, [0]] call BIS_fnc_param;

BL_playerActions = missionNamespace getVariable ['BL_playerActions', []];

_index = count BL_playerActions;
BL_playerActions set [_index, [_actionName, _actionCheck, _action, _actionPriority]];
_index