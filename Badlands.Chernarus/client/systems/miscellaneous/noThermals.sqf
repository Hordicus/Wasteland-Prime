_veh = vehicle player;
_view = cameraView;
while { true } do {
	waitUntil { _veh != vehicle player || (_view != cameraView && cameraView == "GUNNER") };
	_veh = vehicle player;
	_veh disableTIEquipment true;
	(getConnectedUav player) disableTIEquipment true;
};