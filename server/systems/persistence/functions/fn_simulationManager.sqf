private ['_veh'];
_veh = _this select 0;

if ( _veh isKindOf "AllVehicles" && isNil {_veh getVariable 'simManaged'}) then {
	_veh enableSimulation false;

	_veh addEventHandler ['GetIn', {
		(_this select 0) enableSimulation true;
	}];
	
	_veh addEventHandler ['GetOut', {
		if ( count crew (_this select 0) > 0 ) exitwith{};
	
		if ( (_this select 0) call BIS_fnc_absSpeed < 1 ) then {
			(_this select 0) enableSimulation false;
		}
		else {
			// Wait until vehicle has stopped
			(_this select 0) spawn {
				while { (_this select 0) call BIS_fnc_absSpeed > 1 } do {
					sleep 5;
				};
				
				(_this select 0) enableSimulation false;
			};
		};
	}];
	
	_veh addEventHandler ['Killed', {
		(_this select 0) enableSimulation true;
	}];
	
	_veh setVariable ['simManaged', true];
};