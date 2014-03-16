#include "macro.sqf"

private ['_cfg', '_type', '_root'];
_cfg = _this call GEAR_fnc_getConfig;
_type = getNumber (_cfg >> 'ItemInfo' >> 'type');

if ( _type == 0 ) then {
	_type = getNumber (_cfg >> 'type');
};

switch ( _type ) do {
	case 0;
	case 1: {
		_root = _this call GEAR_fnc_getConfigRoot;
		
		if ( _root == 'CfgGlasses' ) then {
			_type = GEAR_type_glasses;
		}
		else {
			if ( _root == 'CfgVehicles' ) then {
				_type = GEAR_type_backpack;
			};
		};
	};
	
	case GEAR_type_map: {
		_class = configName _cfg;
		switch (_class) do {
			case 'ItemMap': { _type = GEAR_type_map; };
			case 'ItemGPS': { _type = GEAR_type_gps; };
			case 'ItemRadio': { _type = GEAR_type_radio; };
			case 'ItemCompass': { _type = GEAR_type_compass; };
			case 'ItemWatch': { _type = GEAR_type_watch; };
		};
	};
};

_type