private ["_class", "_name"];
_class = _this;
_name = getText ((_class call GEAR_fnc_getConfig) >> "displayName");

_name