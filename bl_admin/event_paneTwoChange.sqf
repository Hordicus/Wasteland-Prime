#include "functions\macro.sqf"
disableSerialization;
_dialog = uiNamespace getVariable 'adminPanel';
_dialog call BLAdmin_fnc_hideCtrls;

_action = (_this select 0) lbData (_this select 1);

_action call {
	if ( _this == "spec" ) exitwith {
		["Spectate player", {
			PVAR_adminLog = [player, format['%1 (%2) began spectating %3 (%4)', name player, getPlayerUID player, name BL_adminPlayer, getPlayerUID BL_adminPlayer]];
			publicVariableServer "PVAR_adminLog";
			
			[BL_adminPlayer] call BLAdmin_fnc_specPlayer;
		}] call BLAdmin_fnc_setButton;
	};
	
	if ( _this == "freelook" ) exitwith {
		["Freelook at player", {
			PVAR_adminLog = [player, format['%1 (%2) started freelook camera at %3 (%4)', name player, getPlayerUID player, name BL_adminPlayer, getPlayerUID BL_adminPlayer]];
			publicVariableServer "PVAR_adminLog";

			closeDialog 0;
			['Paste', [worldname,getPosATL BL_adminPlayer,0,0.7,[0,0],0,0,daytime * 60,overcast,0]] call BIS_fnc_camera;
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
		
		_moneyCfg = (missionConfigFile >> "adminPanel" >> "controls" >> "money");
		["Set Money", {
			_amount = parseNumber ctrlText ((uiNamespace getVariable 'adminPanel') displayCtrl moneyIDC);
		
			PVAR_adminLog = [player, format["%1 (%2) set %3's (%4) money to $%5", name player, getPlayerUID player, name BL_adminPlayer, getPlayerUID BL_adminPlayer, _amount]];
			publicVariableServer "PVAR_adminLog";
			
			BL_adminPlayer setVariable ['money', _amount];
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
			PVAR_adminLog = [player, format["%1 (%2) cleared %3's (%4) inventory", name player, getPlayerUID player, name BL_adminPlayer, getPlayerUID BL_adminPlayer, _amount]];
			publicVariableServer "PVAR_adminLog";

			removeAllWeapons BL_adminPlayer;
			removeAllItems BL_adminPlayer;
			removeBackpack BL_adminPlayer;
			removeVest BL_adminPlayer;
			removeUniform BL_adminPlayer;
			removeHeadgear BL_adminPlayer;
			removeGoggles BL_adminPlayer;
			removeAllAssignedItems BL_adminPlayer;
		}] call BLAdmin_fnc_setButton;
	};
	
	if ( _this == "slay" ) exitwith {
		[format["Kill %1 and hide the body.", name BL_adminPlayer]] call BLAdmin_fnc_setText;
		["Slay player", {
			PVAR_adminLog = [player, format["%1 (%2) slayed %3 (%4)", name player, getPlayerUID player, name BL_adminPlayer, getPlayerUID BL_adminPlayer, _amount]];
			publicVariableServer "PVAR_adminLog";
			
			BL_adminPlayer setDamage 1;
			BL_adminPlayer spawn {
				while { !isNull _this } do {
					deleteVehicle _this;
					sleep 0.5;
				};
			};
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