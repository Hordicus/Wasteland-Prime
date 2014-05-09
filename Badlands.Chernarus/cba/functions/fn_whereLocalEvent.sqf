#include "script_macros_common.hpp"
DEFAULT_PARAM(1,_params,nil);

if (isNil "_params") exitWith {
	WARNING("Locality check parameter in CBA_fnc_whereLocalEvent function is missing!");
};

private "_locobj";
_locobj = if (typeName _params == typeName []) then {_params select 0} else {_params};

if (typeName _locobj != "OBJECT") exitWith {
	WARNING("Locality check parameter is not an object!");
	nil
};

TRACE_1("",_locobj);

if (isNil "_locobj" || isNull _locobj) exitWith {
	WARNING("Locality check object is nil or null!");
	nil
};

// doing a local check first
if (!local _locobj) exitWith {
	CBA_l = _this;
	publicVariable "CBA_l";
	nil
};

_this call CBA_fnc_remoteLocalEvent;

nil; // Return.
