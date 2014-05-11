_this spawn {
	waitUntil {isNull (_this select 1)};
	[] call BL_fnc_showPresets;
	[] call BL_fnc_showActiveLoadout;
};