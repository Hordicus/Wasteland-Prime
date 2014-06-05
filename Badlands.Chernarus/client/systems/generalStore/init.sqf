// Scripts that add inventory types
call compile preprocessFileLineNumbers "client\systems\generalStore\items\quadcopter.sqf";
call compile preprocessFileLineNumbers "client\systems\generalStore\items\ababil.sqf";

[
	{ format['Sell Crate [$%1]', [LOG_currentObject] call BL_fnc_crateSellPrice] },
	{ LOG_currentObject isKindOf "Reammobox_F" && { ({(_this select 0) == (_x select 1)} count BL_PVAR_storeAccessObjects) > 0} },
	{
		_crate = LOG_currentObject;
		[] call LOG_fnc_releaseObject;
		
		([_crate] call BL_fnc_crateSellPrice) call BL_fnc_addMoney;
		deleteVehicle _crate;
	}
] call BL_fnc_addAction;