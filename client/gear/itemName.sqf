private ["_class", "_name"];
_class = _this;
_name = getText (configFile >> "cfgWeapons" >> _class >> "displayName");

_name