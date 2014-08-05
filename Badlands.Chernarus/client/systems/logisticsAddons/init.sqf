if ( !hasInterface ) exitwith{};
[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};
	BL_objectLockDoingCheck = false;
	BL_lockCost = 'lockCost' call BL_fnc_config;
	BL_unlockCost = 'unlockCost' call BL_fnc_config;
	LOG_currentObject = objNull;
	LOG_cursorTarget_moveable = objNull;

	if ( isNil "BL_animDoWorkInProgress" ) then {
		BL_animDoWorkInProgress = false;
	};
	
	[
		{
			if ( (_this select 0) isKindOf "Reammobox_F" ) then {
				if ( [] call BL_fnc_money >= BL_lockCost ) then {
					format["Lock Object [<t color='#FF0000'>-$%1</t>]", BL_lockCost]
				}
				else {
					format["<t color='#FF0000'>Lock Object [-$%1]</t>", BL_lockCost]
				};
			}
			else {
				"Lock Object"
			};
		},
		{
			isNull LOG_currentObject &&
			!isNull LOG_cursorTarget_moveable &&
			!((_this select 0) getVariable ['objectLocked', false]) &&
			!BL_animDoWorkInProgress
		},
		{
			if(
				({
					(player distance (_x select 0)) <= (_x select 2)
				} count (([[] call BL_fnc_storeConfig, 'buildingStore'] call CBA_fnc_hashGet) select 2)) == 0
			) then {
				if ( (_this select 0) isKindOf "Reammobox_F" && [] call BL_fnc_money < BL_lockCost ) exitwith {
					hint "You do not have enough money to lock that.";
				};
				
				[10, "Locking Object %1", [(_this select 0)], {
					(_this select 0) setVariable ['objectLocked', true, true];
					(_this select 0) setVariable ['objectOwner', getPlayerUID player, true];
					
					PVAR_requestSave = [player, _this select 0, false, vectorUp (_this select 0)];
					publicVariableServer "PVAR_requestSave";

					if ( (_this select 0) isKindOf "Reammobox_F" ) then {
						BL_lockCost call BL_fnc_subMoney;
					};
				}] call BL_fnc_animDoWork;
			}
			else {
				hint "You can not lock parts inside the building store radius";
			};
		},
		-1,
		5
	] call BL_fnc_addAction;
	
	[
		{
			if ( (_this select 0) isKindOf "Reammobox_F" ) then {
				format["Unlock Object [<t color='#00FF00'>+$%1</t>]", BL_unlockCost]
			}
			else {
				"Unlock Object"
			};
		},
		{
			((_this select 0) getVariable ['objectLocked', false]) &&
			!BL_animDoWorkInProgress &&
			!BL_objectLockDoingCheck
		},
		{
			BL_objectLockDoingCheck = true; // Will hide unlock option in case this takes a sec
			private ["_doUnlock","_owner","_state","_obj"];
			_doUnlock = {
				[20, "Unlocking Object %1", [(_this select 0)], {
					(_this select 0) setVariable ['objectLocked', false, true];
					BL_objectLockDoingCheck = false;
				
					PVAR_requestSave = [player, _this select 0, false];
					publicVariableServer "PVAR_requestSave";
					
					if ( (_this select 0) isKindOf "Reammobox_F" ) then {
						BL_unlockCost call BL_fnc_addMoney;
					};
				}, {BL_objectLockDoingCheck = false}] call BL_fnc_animDoWork;				
			};
			
			_owner = [(_this select 0) getVariable 'objectOwner'] call BL_fnc_playerByUID;
			
			// No need to do remote check if owner is the player, or in the player's group.
			if ( isNull _owner || _owner == player || _owner in units group player ) then {
				[(_this select 0)] call _doUnlock;
			}
			else {
				[getPosATL (_this select 0), 100, _owner, [(_this select 0), _doUnlock], {
					_state    = _this select 0;
					_obj      = _this select 1 select 0;
					_doUnlock = _this select 1 select 1;
					
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
		-1,
		5
	] call BL_fnc_addAction;

	['beforeMove', { !((_this select 0) getVariable ['objectLocked', false]) }] call LOG_fnc_addEventHandler;
	['releasedVehicle', { (_this select 1) call BL_fnc_requestSave; }] call LOG_fnc_addEventHandler;
	['unloadedItem', {(_this select 0) call BL_fnc_requestSave;}] call LOG_fnc_addEventHandler;
	['objectLoadedIn', {(_this select 0) call BL_fnc_requestSave;}] call LOG_fnc_addEventHandler;
	
	['beforeReleaseObject', {
		if ( (_this select 0) isKindOf "Reammobox_F" ) then {
			[_this select 0, [0,0,0]] call BL_fnc_setVelocity;
		};
		nil;
	}] call LOG_fnc_addEventHandler;
};