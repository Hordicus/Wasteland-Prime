private ['_netId', '_index', '_dbId'];
_netId = [_this, 0, "", ["", objNull]] call BIS_fnc_param;

if ( typeName _netId == "OBJECT" ) then {
	_netId = netId _netId;
};

_index = PERS_trackedObjectsNetIDs find _netId;
_dbId = -1;

if ( _index != -1 ) then {
	_dbId = PERS_trackedObjectsIDs select _index;
	
	if ( isNil "_dbId" ) then {
		_dbId = -1;
	};
};

_dbId