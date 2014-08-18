private ['_obj'];
_obj = [_this, 0, "", ["", objNull]] call BIS_fnc_param;

if ( typeName _netId == "STRING" ) then {
	_obj = objectFromNetId _obj;
};

_obj getVariable ['PERS_id', -1]