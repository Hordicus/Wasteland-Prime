_veh = vehicle player;

if ( _veh == player ) then {
	_cars = (getPosATL player) nearEntities ['Car', 5];
	if ( count _cars > 0 ) then {
		_veh = _cars select 0;
	};
};

if ( _veh != player ) then {
	_veh setVectorUp [0,0,1];
	if ( local _veh ) then {
		_veh setVelocity [0,0,5];
	};
};