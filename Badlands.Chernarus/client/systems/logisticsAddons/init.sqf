[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	private ['_addActions'];
	BL_lockedCursorTarget = objNull;
	BL_objectLockDoingCheck = false;
	
	if ( isNil "BL_animDoWorkInProgress" ) then {
		BL_animDoWorkInProgress = false;
	};
	
	_addActions = {
		player addAction ['Lock Object', {
				[5, [cursorTarget], {
					(_this select 0) setVariable ['objectLocked', true, true];
					(_this select 0) setVariable ['objectOwner', getPlayerUID player, true];
					
					PVAR_requestSave = [player, _this select 0, false];
					publicVariableServer "PVAR_requestSave";
				}] call BL_fnc_animDoWork;
			},
			[],
			0,
			false,
			true,
			"",
			"isNull LOG_currentObject && !isNull LOG_cursorTarget_moveable && isNull BL_lockedCursorTarget && !BL_animDoWorkInProgress"
		];
		
		player addAction ['Unlock Object', {
				BL_objectLockDoingCheck = true; // Will hide unlock option in case this takes a sec
				private ["_doUnlock","_owner","_state","_obj"];
				_doUnlock = {
					[45, [(_this select 0)], {
						(_this select 0) setVariable ['objectLocked', false, true];
						BL_objectLockDoingCheck = false;
					
						PVAR_requestSave = [player, _this select 0, false];
						publicVariableServer "PVAR_requestSave";
					}] call BL_fnc_animDoWork;				
				};
				
				_owner = [cursorTarget getVariable 'objectOwner'] call BL_fnc_playerByUID;
				
				// No need to do remote check if owner is the player, or in the player's group.
				if ( !isNull _owner || _owner == player || _owner in units group player ) then {
					[cursorTarget] call _doUnlock;
				}
				else {
					[getPosATL cursorTarget, 100, _owner, [cursorTarget], {
						_state = _this select 0;
						_obj   = _this select 1 select 0;
						
						if ( _state == "ENEMY" ) then {
							// The owner of the object shows the area as only
							// enemies, meaning there are no units friendly to them
							// in the area.
							
							[_obj] call _doUnlock;
						}
						else {
							hint 'The owner, or allied units are in the area. Eliminate them before moving this object.';
							BL_objectLockDoingCheck = false;
						};
					}] call BL_fnc_friendlyStateCheck;
				};
			},
			[],
			0,
			false,
			true,
			"",
			"!isNull BL_lockedCursorTarget && !BL_animDoWorkInProgress && !BL_objectLockDoingCheck"
		];
	};

	player addEventHandler ['respawn', _addActions];
	[] call _addActions;
	['beforeMove', { !((_this select 0) getVariable ['objectLocked', false]) }] call LOG_fnc_addEventHandler;
	
	while { true } do {
		if ( cursorTarget distance player < 20 ) then {
			if ( cursorTarget in (5 call LOG_fnc_getPointerObject) && cursorTarget getVariable ['objectLocked', false] ) then {
				BL_lockedCursorTarget = cursorTarget;
			}
			else {
				BL_lockedCursorTarget = objNull;
			};
		}
		else {
			BL_lockedCursorTarget = objNull;
		};
		
		sleep 0.3;
	};
};