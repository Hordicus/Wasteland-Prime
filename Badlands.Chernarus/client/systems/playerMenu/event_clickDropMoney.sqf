#include "functions\macro.sqf"
_money = [] call BL_fnc_money;
_amountToDrop = parseNumber ctrlText dropMoneyAmountIDC;

if ( _money < _amountToDrop ) exitwith {
	hint "You don't have that much money.";
};

if ( _amountToDrop <= 0 ) exitwith {
	hint "You have to drop more than that.";
};

[5, "Dropping Money %1", [_amountToDrop], {
	(_this select 0) call BL_fnc_subMoney;
	['moneyModel' call BL_fnc_config, getPosATL player, 'veh', _this, {
		(_this select 0) setVariable ['moneyAmount', _this select 1 select 0, true];
	}] call BL_fnc_createVehicle;
}] call BL_fnc_animDoWork;