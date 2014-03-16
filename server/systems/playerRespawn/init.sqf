"createSpawnBeacon" addPublicVariableEventHandler {
	private ['_beaconInfo'];
	_beaconInfo = _this select 1;
	
	[
		_beaconInfo select 2,
		100,
		'beaconUpdate',
		[_beaconInfo select 1]
	] call BL_fnc_registerLocWithRadar;
};