private ["_veh","_index","_dbID"];
_veh =  _this select 0;

_index = PERS_trackedObjectsNetIDs find (netId _veh);
_dbID = PERS_trackedObjectsIDs select _index;

if ( !isNil "_dbID" && (_x getVariable ['lastSaveState', '']) != (_x call BL_fnc_vehicleState) ) then {
	[_veh] call BL_fnc_queueSaveVehicle;
};