"LOG_PVAR_SETVELOCITY_SERVER" addPublicVariableEventHandler {
	private ["_veh"];
	_veh = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	
	_veh enableSimulation true;
	_veh spawn {
		sleep 30;
		if ( count crew _this == 0 ) then {
			while { _this call BIS_fnc_absSpeed > 1 } do {
				sleep 5;
			};
			
			_this enableSimulation false;
		};
	};
};