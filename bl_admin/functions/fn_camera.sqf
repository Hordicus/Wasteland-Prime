private ['_position'];
_position = _this select 0;

['Paste', [worldname,_position,0,0.7,[0,0],0,0,daytime * 60,overcast,0]] call BIS_fnc_camera;

[] spawn {
	disableSerialization;
	waituntil {!isnil {uinamespace getvariable "BIS_fnc_camera_display"}};
	[] call BLAdmin_fnc_hud;
	
	_display = uinamespace getvariable "BIS_fnc_camera_display";
	
	_display displayRemoveAllEventHandlers "keydown";
	_display displayRemoveAllEventHandlers "keyup";
	
	_display displayaddeventhandler ["keydown","with (uinamespace) do {if !( (_this select 1) in [0x39, 0x3B] ) then {['KeyDown',_this] call BIS_fnc_camera;};};"];
	_display displayaddeventhandler ["keyup","with (uinamespace) do {if !( (_this select 1) in [0x39, 0x3B] ) then {['KeyUp',_this] call BIS_fnc_camera;};};"];
	
	_display displayAddEventHandler ["KeyDown", {
		if ( (_this select 1) == 219 ) then {
			showNames = true;
		};
	}];
	
	_display displayAddEventHandler ["KeyUp", {
		if ( (_this select 1) == 219 ) then {
			showNames = false;
		};
	}];
	
	_display displayAddEventHandler ["Unload", {
		false call BLAdmin_fnc_hud;
		nil
	}];
};