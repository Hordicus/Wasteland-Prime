private ["_class", "_parent", "_try"];
_class = _this;
_parent = "";
_try = ["CfgWeapons", "CfgMagazines"];

{
	if ( isClass (configFile >> _x >> _class ) ) exitwith {
		_parent = _x;
	};
} count _try;

(configFile >> _parent >> _class)