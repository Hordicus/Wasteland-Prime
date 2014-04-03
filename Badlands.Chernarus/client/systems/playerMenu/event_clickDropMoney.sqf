#include "functions\macro.sqf"
_money = player getVariable ['money', 0];
_amountToDrop = parseNumber ctrlText dropMoneyAmountIDC;

if ( _money < _amountToDrop ) exitwith {
	hint "You don't have that much money.";
};

if ( _amountToDrop <= 0 ) exitwith {
	hint "You have to drop more than that.";
};

[5, [_amountToDrop], {
	player setVariable ['money', (player getVariable ['money', 0]) - (_this select 0), true];
	['moneyModel' call BL_fnc_config, getPosATL player, 'veh', _this, {
		(_this select 0) setVariable ['moneyAmount', _this select 1 select 0];
	}] call BL_fnc_createVehicle;
}] call BL_fnc_animDoWork;