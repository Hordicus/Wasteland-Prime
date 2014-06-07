#include "functions\macro.sqf"
_money = [] call BL_fnc_money;
_amountToDrop = parseNumber ctrlText dropMoneyAmountIDC;

if ( _money < _amountToDrop ) exitwith {
	hint "You don't have that much money.";
};

if ( _amountToDrop <= 0 ) exitwith {
	hint "You have to drop more than that.";
};

BL_dropMoneyTimeout = missionNamespace getVariable ['BL_dropMoneyTimeout', 0];

if ( BL_dropMoneyTimeout < diag_tickTime ) then {
	[5, "Dropping Money %1", [_amountToDrop], {
		(_this select 0) call BL_fnc_subMoney;
		BL_dropMoneyTimeout = diag_tickTime + (((_this select 0)/100) * ('secondsPerHundred' call BL_fnc_config));
		
		['moneyModel' call BL_fnc_config, getPosATL player, 'veh', _this, {
			(_this select 0) setVariable ['moneyAmount', _this select 1 select 0, true];
			(_this select 0) setVariable ['player', getPlayerUID player, true];
		}] call BL_fnc_createVehicle;
	}] call BL_fnc_animDoWork;
}
else {
	if ( BL_dropMoneyTimeout - diag_tickTime > 60 ) then {
		hint format['You must wait %1 minute(s) before dropping money again.', round((BL_dropMoneyTimeout - diag_tickTime)/60)];
	}
	else {
		hint format['You must wait %1 seconds before dropping money again.', round(BL_dropMoneyTimeout - diag_tickTime)];
	};
};
