private ['_player'];
_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

PVAR_adminLog = [player, format['%1 (%2) started freelook camera at %3 (%4)', name player, getPlayerUID player, name _player, getPlayerUID _player]];
publicVariableServer "PVAR_adminLog";

['Paste', [worldname,getPosATL _player,0,0.7,[0,0],0,0,daytime * 60,overcast,0]] call BIS_fnc_camera;

[] spawn {
	disableSerialization;
	waituntil {!isnil {uinamespace getvariable "BIS_fnc_camera_display"}};
	
	_display = uinamespace getvariable "BIS_fnc_camera_display";
	
	_display displayRemoveAllEventHandlers "keydown";
	_display displayRemoveAllEventHandlers "keyup";
	
	_display displayaddeventhandler ["keydown","with (uinamespace) do {if !( (_this select 1) in [0x39, 0x3B] ) then {['KeyDown',_this] call BIS_fnc_camera;};};"];
	_display displayaddeventhandler ["keyup","with (uinamespace) do {if !( (_this select 1) in [0x39, 0x3B] ) then {['KeyUp',_this] call BIS_fnc_camera;};};"];
};