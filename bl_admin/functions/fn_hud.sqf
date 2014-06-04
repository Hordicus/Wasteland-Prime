_showHud = [_this, 0, true, [true]] call BIS_fnc_param;
if ( _showHud ) then {
	["BLAdmin_HUD", "onEachFrame", {
		if ( showNames ) then {
			_loc = getPosATL player;
			if ( !isNil "BIS_fnc_camera_cam" ) then {
				_loc = getPosATL BIS_fnc_camera_cam;
			}
			else {
				if ( !isNil "RscSpectator_camera" ) then {
					_loc = getPosATL RscSpectator_player;
				};
			};
			
			{
				_loc = visiblePositionASL _x;
				_loc set [2, ((_x modelToWorld (_x selectionPosition 'pelvis')) select 2)];

				_color = (side _x) call BIS_fnc_sideColor;
				
				drawIcon3D [
					friendlyIcon,
					_color,
					_loc,
					0.3,
					0.3,
					0,
					name _x,
					0,
					0.03,
					"PuristaMedium"
				];	
				true
			} count ([_loc, 1000] call BL_fnc_nearUnits);
		};
	}] call BIS_fnc_addStackedEventHandler;
}
else {
	["BLAdmin_HUD", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};