private ['_veh'];
_veh = _this select 0;
_veh enableSimulation true;
_veh spawn {
	sleep 30;
	if ( count crew _this == 0 ) then {
		while { !((velocity _this) isEqualTo [0,0,0]) } do {
			sleep 5;
		};
		
		_this enableSimulation false;
	};
};

nil