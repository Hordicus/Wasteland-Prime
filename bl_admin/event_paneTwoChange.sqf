#include "functions\macro.sqf"
disableSerialization;
_dialog = uiNamespace getVariable 'adminPanel';
_dialog call BLAdmin_fnc_hideCtrls;
_action = (_this select 0) lbData (_this select 1);


if ( typeName BL_adminPlayer == "OBJECT" ) then {
	_action call {
		if ( _this == "spec" ) exitwith {
			["Spectate player", {		
				closeDialog 0;
				[BL_adminPlayer] call BLAdmin_fnc_specPlayer;
			}] call BLAdmin_fnc_setButton;
		};
		
		if ( _this == "freelook" ) exitwith {
			["Freelook at player", {
				[BL_adminPlayer] call BLAdmin_fnc_freelook;
				closeDialog 0;
			}] call BLAdmin_fnc_setButton;
		};
		
		if ( _this == "money" ) exitwith {
			_text = [format["%1 has $%2. Set the player's money below", name BL_adminPlayer, BL_adminPlayer getVariable ['money', 0]]] call BLAdmin_fnc_setText;
		
			_money = _dialog displayCtrl moneyIDC;
			_money ctrlShow true;
			_money ctrlSetText str (BL_adminPlayer getVariable ['money', 0]);
			
			_moneyPos = ctrlPosition _money;
			_textPos = ctrlPosition _text;
			
			_moneyPos set [1, (_textPos select 1) + (_textPos select 3) + safezoneH * 0.01];
			_money ctrlSetPosition _moneyPos;
			_money ctrlCommit 0;
			
			_moneyCfg = (configFile >> "adminPanel" >> "controls" >> "money");
			["Set Money", {
				_amount = parseNumber ctrlText ((uiNamespace getVariable 'adminPanel') displayCtrl moneyIDC);
				[BL_adminPlayer, _amount] call BLAdmin_fnc_setMoney;
				closeDialog 0;
			}, [
				0,
				(_moneyPos select 1) + (_moneyPos select 3) + safezoneH * 0.01,
				0,
				0
			]] call BLAdmin_fnc_setButton;		
		};
		
		if ( _this == "clearInv" ) exitwith {
			[format["Clear all of %1's items.", name BL_adminPlayer]] call BLAdmin_fnc_setText;
			
			["Clear inventory", {
				[BL_adminPlayer] call BLAdmin_fnc_clearInventory;
				closeDialog 0;
			}] call BLAdmin_fnc_setButton;
		};
		
		if ( _this == "slay" ) exitwith {
			[format["Kill %1 and hide the body.", name BL_adminPlayer]] call BLAdmin_fnc_setText;
			["Slay player", {
				[BL_adminPlayer] call BLAdmin_fnc_slay;
				closeDialog 0;
			}] call BLAdmin_fnc_setButton;
		};
		
		if ( _this == "group" ) exitwith {
			_text = format["Units in %1's group as your client knows about them.<br /><br />", name BL_adminPlayer];
			
			{
				_text = _text + (name _x) + "<br />";
				true
			} count (units group BL_adminPlayer);
			
			[_text] call BLAdmin_fnc_setText;
		};
	};
}
else {
	// Non player action with sub action
	BL_adminPlayer call {
		if ( _this == "reveal" ) exitwith {
			_action call {
				if ( _this == "Man" ) exitwith {
					["Toggle Players on map", {
						PVAR_adminLog = [player, format['%1 (%2) toggled players on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";
						
						["Man"] call BLAdmin_fnc_revealOnMap;
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
				
				if ( _this == "AllVehicles" ) exitwith {
					["Toggle Vehicles on map", {
						PVAR_adminLog = [player, format['%1 (%2) toggled vehicles on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";

						["AllVehicles"] call BLAdmin_fnc_revealOnMap;
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
				
				if ( _this == "Static" ) exitwith {
					["Toggle Base parts on map", {
						PVAR_adminLog = [player, format['%1 (%2) toggled base parts on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";

						["Static"] call BLAdmin_fnc_revealOnMap;
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
				
				if ( _this == "Reammobox_F" ) exitwith {
					["Toggle Ammo boxes on map", {
						PVAR_adminLog = [player, format['%1 (%2) toggled ammo boxes on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";

						["Reammobox_F"] call BLAdmin_fnc_revealOnMap;
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
				
				if ( _this == "All" ) exitwith {
					["Show all types on map", {
						PVAR_adminLog = [player, format['%1 (%2) revealed all types on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";

						BLAdmin_drawClasses = [];
						["Man"] call BLAdmin_fnc_revealOnMap;
						["AllVehicles"] call BLAdmin_fnc_revealOnMap;
						["Static"] call BLAdmin_fnc_revealOnMap;
						["Reammobox_F"] call BLAdmin_fnc_revealOnMap;
						
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
				
				if ( _this == "" ) exitwith {
					["Hide all types on map", {
						PVAR_adminLog = [player, format['%1 (%2) hid all types on map', name player, getPlayerUID player]];
						publicVariableServer "PVAR_adminLog";

						BLAdmin_drawClasses = [];
						closeDialog 0;
					}] call BLAdmin_fnc_setButton;
				};
			};
		};
		
		if ( _this == "missions" ) exitwith {
			_mission = [];
			
			{
				if ( (_x select 0 select 0) == _action ) exitwith {
					_mission = _x;
				};
				nil
			} count (BL_PVAR_currentTasks select 2);			
			
			_pos = _mission select 3;
			if ( typeName (_pos select 0) == "OBJECT" ) then {
				_pos = getPosATL (_pos select 0);
			};
			
			_nearestCity = [_pos] call BL_fnc_nearestCity;
			_info = format['%1 of %2', [_pos, _nearestCity select 1] call BL_fnc_directionToString, _nearestCity select 0];

			[format['
			%1<br />
			%2<br />
			<br />
			%3<br />
			%4',
			_mission select 2 select 1 select 0, // Name
			_mission select 2 select 0 select 0, // Desc
			_mission select 0 select 0, // Code
			_info // Rel pos
			]] call BLAdmin_fnc_setText;
			
			BLAdmin_fnc_selectedMission = _mission select 0 select 0;
			["Fail Mission", {
				PVAR_failMission = [player, BLAdmin_fnc_selectedMission];
				publicVariableServer "PVAR_failMission";
				
				closeDialog 0;
			}] call BLAdmin_fnc_setButton;

		};
	};
};