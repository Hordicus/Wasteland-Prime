/*
	Author: Karel Moricky
	
	Description:
	Delete task
	
	Parameters:
		0: STRING - Task ID
		1: Removed task owners (optional, the task will be removed for all existing owners by default)
			BOOL - true to useall playable units
			OBJECT - specific object
			GROUP - all objects in the group
			SIDE - all objects of the given side
			ARRAY - collection of above types

	Returns:
	BOOL
*/
private ["_taskID","_targets","_taskVar","_data"];

_taskID = [_this,0,"",[""]] call BIS_fnc_param;
_targets = [_this,1,[],[true,sideunknown,grpnull,objnull,[]]] call bis_fnc_param;
_init = [_this,2,true,[true]] call bis_fnc_param;

_taskVar = _taskID call bis_fnc_taskVar;
if (typename _targets != typename []) then {_targets = [_targets];};

if (_init) then {

	//--- Terminate when the task does not exist
	if (isnil {missionnamespace getvariable _taskVar}) exitwith {
		//if (_taskID != "") then {["Task '%1' does not exist",_taskID] call bis_fnc_error;};
		false
	};

	//--- Select tasks to delete (include subtasks)
	_data = +(missionnamespace getvariable [_taskVar,[["","",[]],[],["","",""],objnull,"CREATED",-1]]);
	_params = _data select 0;
	_taskChildren = _params select 2;
	{
		_taskVar = _x call bis_fnc_taskVar;
		_data = +(missionnamespace getvariable [_taskVar,[["",""],[],["","",""],objnull,"CREATED",-1]]);

		//--- Init
		_targetsLocal = if (count _targets == 0) then {_data select 1} else {_targets};
		[[_x,_targetsLocal,false],"bis_fnc_deleteTask"] call bis_fnc_mp;

		//--- Delete owners
		_targetsAll = _data select 1;
		_targetsAll = _targetsAll - _targetsLocal;
		_data set [1,_targetsAll];
		diag_log format['_taskVar = %1', _taskVar];
		missionnamespace setvariable [_taskVar,nil];
		publicvariable _taskVar;
		
		// Remove from MP logic queue
		_logic = missionnamespace getvariable ["bis_functions_mainscope",objnull];
		_queue = _logic getvariable ["BIS_fnc_MP_queue",[]];
		
		private ['_currentTaskID'];
		_currentTaskID = _x;
		{
			if ( typeName (_x select 1) == "ARRAY" && {(_x select 1 select 0) == _currentTaskID} ) then {
				_queue set [_forEachIndex, "REMOVE"];
				_queue = _queue - ["REMOVE"];
			};
		} forEach _queue;
		
		_logic setvariable ["BIS_fnc_MP_queue",_queue,true];
	} foreach ([_taskID] + _taskChildren);
} else {
	//--- Local
	private ["_units"];
	_units = [];
	{
		_target = _x;
		switch (typename _target) do {
			case (typename ""): {
				private ["_unit"];
				_unit = missionnamespace getvariable [_target,objnull];
				_units set [count _units,_unit];
			};
			case (typename grpnull): {
				_units = _units + units _target;
			};
			case (typename sideunknown): {
				{
					if ((_x call bis_fnc_objectSide) == _target) then {_units set [count _units,_x];};
				} foreach (allunits + alldead);
			};
			case (typename []): {
				_units = _units + _target;
			};
			case (typename true): {
				if (_target) then {
					_units = _units + ([] call bis_fnc_listplayers);
				};
			};
		};
	} foreach _targets;

	{
		private ["_task"];
		_task = _x getvariable [_taskVar,tasknull];
		_x removesimpletask _task;
		_x setvariable [_taskVar,nil];
	} foreach _units;
};
true