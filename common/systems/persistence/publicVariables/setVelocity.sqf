[] spawn {
	waitUntil { !isNil "PERS_init_done" };
	
	if ( isServer ) then {
		"LOG_PVAR_SETVELOCITY_SERVER" addPublicVariableEventHandler {
			private ["_veh"];
			_veh = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
			_velocity = [_this select 1, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;
			_client   = owner _veh;
			
			[_veh] call BL_fnc_enableSimulationTemp;
			
			if ( local _veh ) then {
				_veh setVelocity _velocity;
			}
			else {	
				// Pass info on to owner of object
				LOG_PVAR_SETVELOCITY = [_veh, _velocity];
				_client publicVariableClient "LOG_PVAR_SETVELOCITY";
			};		
		};
	}
	else {
		"LOG_PVAR_SETVELOCITY" addPublicVariableEventHandler {
			private ["_veh","_velocity"];
			_veh      = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
			_velocity = [_this select 1, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;
			
			[_veh] call BL_fnc_enableSimulationTemp;
			
			_veh setVelocity _velocity;
		};	
	};
};