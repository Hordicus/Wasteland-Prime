weatherTemplates = 'weatherTemplates' call BL_fnc_config;

["SELECT `value` FROM `settings` WHERE `key` = 'rw2_Current_Weather'", [], [], {
	if ( count (_this select 0 select 0) == 0 ) then {
		rw2_Current_Weather = floor(random(count(weatherTemplates)));
		["INSERT INTO `settings` SET `key` = 'rw2_Current_Weather', `value` = '%1'", [rw2_Current_Weather]] call BL_fnc_MySQLCommand;
	}
	else {
		rw2_Current_Weather = _this select 0 select 0 select 0 select 0;
	};
	
	publicVariable "rw2_Current_Weather";
}] call BL_fnc_MySQLCommand;


[] spawn {
	waitUntil { !isNil "rw2_Current_Weather" };
	while {true} do {
		// Pick weather template from possible forecasts for next weather update
		sleep 10;
		_weatherUpdateArray = weatherTemplates select rw2_Current_Weather;
		_weatherUpdateForecasts = _weatherUpdateArray select 1;
		rw2_Next_Weather = _weatherUpdateForecasts select floor(random(count(_weatherUpdateForecasts)));
		publicVariable "rw2_Next_Weather";
		sleep (('weatherCycleTime' call BL_fnc_config) - 10);
		[[],"mb_fnc_UpdateWeather",true] spawn Bis_fnc_MP;
		rw2_Current_Weather = rw2_Next_Weather;
		publicVariable "rw2_Current_Weather";
		["UPDATE `settings` SET `value` = '%1' WHERE `key` = 'rw2_Current_Weather'", [rw2_Current_Weather]] call BL_fnc_MySQLCommand;
	};
};