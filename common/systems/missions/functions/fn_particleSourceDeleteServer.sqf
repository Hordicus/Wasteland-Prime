private ['_code'];
_code = [_this, 0, "", [""]] call BIS_fnc_param;

[_this, "BL_fnc_particleSourceDelete"] call BIS_fnc_MP;
[BL_particleSources, _code] call CBA_fnc_hashRem;