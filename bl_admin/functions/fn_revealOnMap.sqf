private ['_class', '_drawIcons', '_count'];
_class = [_this, 0, "", [""]] call BIS_fnc_param;

_drawIcons = {
	_map = _this select 0;
	
	{
		{
			_map drawIcon [
				getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"),
				[1,1,1,1],
				getPosATL _x,
				24,
				24,
				getDir _x,
				'',
				1,
				0.03,
				'TahomaB',
				'right'
			];
			nil
		} count (_x call {
			if ( _this select 0 ) exitwith { entities (_x select 1) };
			if !( _this select 0 ) exitwith { allMissionObjects (_x select 1) };
		});
		
		nil
	} count BLAdmin_drawClasses;
};


if ( isNil "BLAdmin_drawingClasses" ) then {
	BLAdmin_drawingClasses = true;
	BLAdmin_drawClasses = [];
	
	(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", _drawIcons];
};

_count = {
	if ( (_x select 1) == _class ) then {
		BLAdmin_drawClasses = BLAdmin_drawClasses - [_x];
		true
	}
	else {
		false
	};
} count BLAdmin_drawClasses;

if ( _count == 0 ) then {
	BLAdmin_drawClasses set [count BLAdmin_drawClasses, [count entities _class > 0, _class]];
};

if ( isNil "BLAdmin_camWatch" || {scriptDone BLAdmin_camWatch} ) then {
	BLAdmin_camWatch = _drawIcons spawn {
		while { count BLAdmin_drawClasses > 0 } do {
			waitUntil { !isNil {uiNamespace getVariable "BIS_fnc_camera_display"} || BLAdmin_drawClasses isEqualTo []};
			((uiNamespace getVariable "BIS_fnc_camera_display") displayCtrl 3141) ctrlAddEventHandler ["Draw", _this];
			waitUntil { isNil {uiNamespace getVariable "BIS_fnc_camera_display"} || BLAdmin_drawClasses isEqualTo [] };
		};
	};
};