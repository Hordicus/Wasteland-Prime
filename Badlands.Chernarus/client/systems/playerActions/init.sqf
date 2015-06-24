BL_playerActions = missionNamespace getVariable ['BL_playerActions', []];
BL_animDoWorkInProgress = false;
call compile preprocessFileLineNumbers "client\systems\playerActions\actions\treatPlayer.sqf";
call compile preprocessFileLineNumbers "client\systems\playerActions\actions\repairVehicle.sqf";
call compile preprocessFileLineNumbers "client\systems\playerActions\actions\earplugs.sqf";

if ( !hasInterface ) exitwith{};
[] spawn {
	BL_playerActionsIDs = [];
	BL_playerActionTargets = [];
	BL_playerActionsShowProximity = [];
	_distance = 5;

	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	
	player addEventHandler ['Respawn', {
		{
			(_this select 1) removeAction _x;
			true
		} count BL_playerActionsIDs;
		BL_playerActionsIDs = [];
	}];
	
	_addAction = {
		private ['_actionTarget', '_actionIndex', '_actionProximity'];
		_actionTarget = _this select 0;
		_actionIndex = _this select 1;
		_actionProximity = _this select 2;
		
		BL_playerActionsShowProximity set [_actionIndex, _actionProximity];
		BL_playerActionTargets set [_actionIndex, _actionTarget];

		private ['_action', '_actionName'];
		_action = _this select 3;
		_actionName = _action select 0;
		
		if ( typeName _actionName == "CODE" ) then {
			_actionName = [_actionTarget] call _actionName;
		};
		
		if ( count BL_playerActionsIDs > _actionIndex && {!isNil { BL_playerActionsIDs select _actionIndex }} ) then {
			player setUserActionText [
				BL_playerActionsIDs select _forEachIndex,
				_actionName
			];
		}
		else {
			BL_playerActionsIDs set [_actionIndex, player addAction [
				_actionName,
				BL_fnc_doPlayerAction,
				_actionIndex,
				(_x select 4),
				false,
				true,
				"cursorTarget == BL_cursorTarget || BL_playerActionsShowProximity select _actionIndex"
			]];
		};
	};

	while { true } do {
		if ( vehicle player == player ) then {
			_cameraPosition = eyePos player;
			_finalPosition = [_cameraPosition, _distance, getDir player] call BIS_fnc_relPos;
			_angle = (([positionCameraToWorld [0,0,0], positionCameraToWorld [0,0,1]] call BIS_fnc_vectorFromXtoY) call BIS_fnc_unitVector) select 2;
			_finalPosition set [2, _angle*_distance + (_cameraPosition select 2)];

			_targets = lineIntersectsObjs [_cameraPosition, _finalPosition, objNull, player, true, 2];
			if ( count _targets == 1 && cursorTarget in _targets) then {
				BL_cursorTarget = _targets select 0;
			}
			else {
				if ( (player distance cursorTarget) <= _distance ) then {
					BL_cursorTarget = cursorTarget;
				}
				else {
					BL_cursorTarget = objNull;
				};
			};
			
			{
				_action = _x;
				_actionIndex = _forEachIndex;
				
				// Check cursorTarget
				if ( [BL_cursorTarget] call (_x select 1) ) then {
					[BL_cursorTarget, _forEachIndex, false, _action] call _addAction;
				}
				else {
					// Try proximity
					_proximityTarget = objNull;
					if ( (_x select 3) >= 0 ) then {
						{
							if ( [_x] call (_action select 1) && _x distance player <= (_action select 3) ) exitwith {
								_proximityTarget = _x;
							};
							true
						} count (nearestObjects [getPosATL player, ["All"], _distance]);
						
						if ( !isNull _proximityTarget ) then {
							[_proximityTarget, _forEachIndex, true, _action] call _addAction;
						};
					};
				
					if ( isNull _proximityTarget && count BL_playerActionsIDs > _forEachIndex && {!isNil { BL_playerActionsIDs select _forEachIndex }} ) then {
						player removeAction (BL_playerActionsIDs select _forEachIndex);
						BL_playerActionsIDs set [_forEachIndex, nil];
					};
				};
				
				true
			} forEach BL_playerActions;
		}
		else {
			// In vehicle. Remove all actions.
			{
				if ( count BL_playerActionsIDs > _forEachIndex && {!isNil { BL_playerActionsIDs select _forEachIndex }} ) then {
					player removeAction (BL_playerActionsIDs select _forEachIndex);
					BL_playerActionsIDs set [_forEachIndex, nil];
				};
			} forEach BL_playerActions;
		};
		
		sleep 0.3;
	};
};