private ['_veh', '_state'];
_veh   = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_state = [_this, 1, true, [true]] call BIS_fnc_param;

if ( isServer || local _veh ) then {
	_veh enableSimulation _state;
	
	if ( count crew _veh == 0 ) then {
		[_veh, _state] spawn {
			_veh   = _this select 0;
			_state = _this select 1;
		
			sleep 10;
			waitUntil { (velocity _veh) isEqualTo [0,0,0] || count crew _veh > 0 };
			
			if ( count crew _veh == 0 ) then {
				_veh enableSimulation !_state;
			};
		};
	};
	
	if ( !isServer ) then {
		[[_veh, _state], "BL_fnc_enableSimulation", false] call BIS_fnc_MP;
	};
}
else {
	[[_veh, _state], "BL_fnc_enableSimulation", _veh] call BIS_fnc_MP;
	[[_veh, _state], "BL_fnc_enableSimulation", false] call BIS_fnc_MP;
};