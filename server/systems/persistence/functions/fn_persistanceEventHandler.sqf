_veh =  _this select 0;
_lastSave = _veh getVariable 'lastSave';
_lastSavePos = _veh getVariable 'lastSavePos';

_index = PERS_trackedObjectsNetIDs find (netId _veh);
_dbID = PERS_trackedObjectsIDs select _index;

if ( !isNil "_dbID" && time - _lastSave >= 60 ) then {
	[_veh] call BL_fnc_saveVehicle;
};