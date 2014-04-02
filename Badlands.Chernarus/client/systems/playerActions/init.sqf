BL_playerActions = missionNamespace getVariable ['BL_playerActions', []];
BL_animDoWorkInProgress = false;
call compile preprocessFileLineNumbers "client\systems\playerActions\actions\treatPlayer.sqf";
call compile preprocessFileLineNumbers "client\systems\playerActions\actions\repairVehicle.sqf";

[] spawn {
	BL_playerActionsIDs = [];
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

	while { true } do {
		_cameraPosition = eyePos player;
		_finalPosition = [_cameraPosition, _distance, getDir player] call BIS_fnc_relPos;
		_angle = (([positionCameraToWorld [0,0,0], positionCameraToWorld [0,0,1]] call BIS_fnc_vectorFromXtoY) call BIS_fnc_unitVector) select 2;
		_finalPosition set [2, _angle*_distance + (_cameraPosition select 2)];

		_targets = lineIntersectsObjs [_cameraPosition, _finalPosition, objNull, player, true, 2];
		if ( count _targets == 1 && cursorTarget in _targets) then {
			BL_cursorTarget = _targets select 0;
		}
		else {
			if ( cursorTarget isKindOf "Man" && player distance cursorTarget < 5 ) then {
				BL_cursorTarget = cursorTarget;
			}
			else {
				BL_cursorTarget = objNull;
			};
		};
		
		{
				_doShow = [BL_cursorTarget] call (_x select 1);
				if ( _doShow ) then {
					_actionName = _x select 0;
					if ( typeName _actionName == "CODE" ) then {
						_actionName = [BL_cursorTarget] call _actionName;
					};
					
					if ( count BL_playerActionsIDs > _forEachIndex && {!isNil { BL_playerActionsIDs select _forEachIndex }} ) then {
						player setUserActionText [
							BL_playerActionsIDs select _forEachIndex,
							_actionName
						];
					}
					else {
						BL_playerActionsIDs set [_forEachIndex, player addAction [
							_actionName,
							BL_fnc_doPlayerAction,
							_forEachIndex,
							(_x select 3),
							false,
							true,
							"cursorTarget == BL_cursorTarget"
						]];
					};
				}
				else {
					if ( count BL_playerActionsIDs > _forEachIndex && {!isNil { BL_playerActionsIDs select _forEachIndex }} ) then {
						player removeAction (BL_playerActionsIDs select _forEachIndex);
						BL_playerActionsIDs set [_forEachIndex, nil];
					};
				};
				
				true
		} forEach BL_playerActions;
		
		sleep 0.3;
	};
};