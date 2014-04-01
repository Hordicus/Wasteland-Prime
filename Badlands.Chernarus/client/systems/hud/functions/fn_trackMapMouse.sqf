private ['_position', '_veh'];
_position = (_this select 0) ctrlMapScreenToWorld [_this select 1, _this select 2];
_veh = _position nearEntities [['Man','Air','LandVehicle'], 5];
if ( count _veh > 0 ) then {
	mapCursorTarget = _veh select 0;
}
else {
	mapCursorTarget = objNull;
};