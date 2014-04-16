private ['_veh', '_timeout', '_saveH', '_h'];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_timeout = [_this, 1, 30, [0]] call BIS_fnc_param;

_saveH = _veh getVariable 'queueSaveVehicle';

if ( !isNil "_saveH" ) then {
	if ( !scriptDone _saveH ) then {
		terminate _saveH;
	};
};

_h = [_veh, _timeout] spawn {
	sleep (_this select 1);
	diag_log format['Saving %1', _this select 0];
	[_this select 0] call BL_fnc_saveVehicle;
};

_veh setVariable ['queueSaveVehicle', _h];

_h