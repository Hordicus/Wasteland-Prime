#include "functions\macro.sqf"
private ['_valueIDC', '_dist'];

_dist = round sliderPosition (_this select 0);
_valueIDC = switch (ctrlIDC (_this select 0)) do {
	case footViewDistanceIDC: {
		BL_footViewDistance = _dist;
		footViewDistanceValueIDC
	};
	case carViewDistanceIDC: {
		BL_carViewDistance = _dist;
		carViewDistanceValueIDC
	};
	case airViewDistanceIDC: {
		BL_airViewDistance = _dist;
		airViewDistanceValueIDC
	};
};

[] call BL_fnc_setViewDistance;
ctrlSetText [_valueIDC, format['%1m', _dist]];