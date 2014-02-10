#include "dialogs\gear_defines.sqf"
_class = (_this select 0) lbData (_this select 1);
_type  = _class call GEAR_getType;

_get_item = {
	private ['_class'];
	_class = "";
	
	if ( count GEAR_activeLoadout > _this && { !isNil { GEAR_activeLoadout select _this } }) then {
		_class = GEAR_activeLoadout select _this;
	};
	
	_class
};

switch(_type) do {
	case GEAR_type_primary;
	case GEAR_type_secondary;
	case GEAR_type_pistol: {
		_index = switch(_type) do {
			case GEAR_type_primary: { GEAR_index_primary };
			case GEAR_type_secondary: { GEAR_index_secondary };
			case GEAR_type_pistol: { GEAR_index_pistol };
		};
	
		GEAR_activeLoadout set [_index, _class];
		GEAR_activeLoadout set [_index+1, nil];
		GEAR_activeLoadout set [_index+2, nil];
		GEAR_activeLoadout set [_index+3, nil];
		GEAR_activeLoadout set [_index+4, nil];
	};
	
	case GEAR_type_uniform;
	case GEAR_type_vest;
	case GEAR_type_backpack: {
		_index = switch(_type) do {
			case GEAR_type_uniform: { GEAR_index_uniform };
			case GEAR_type_vest: { GEAR_index_vest };
			case GEAR_type_backpack: { GEAR_index_backpack };
		};
		
		_item = _index call _get_item;
		
		if ( _item == "" || { count (GEAR_activeLoadout select _index+1) == 0 } ) then {
			// No gear, or empty gear.
			GEAR_activeLoadout set [_index, _class];
			GEAR_activeLoadout set [_index+1, []];
		};
	};
	
	case GEAR_type_muzzle;
	case GEAR_type_acc;
	case GEAR_type_optic: {
		_offset = switch(_type) do {
			case GEAR_type_muzzle: { 1 };
			case GEAR_type_acc: { 2 };
			case GEAR_type_optic: { 3 };
		};

		
		{
			_gun = _x call _get_item;
			if ( _gun != "" && {[_gun, _class] call GEAR_validAttachment}) exitwith {
				GEAR_activeLoadout set [_x + _offset, _class];
			};
		} count [GEAR_index_primary, GEAR_index_secondary, GEAR_index_pistol];
	};
	
	case GEAR_type_helmet:     { GEAR_activeLoadout set [GEAR_index_helmet, _class]; };
	case GEAR_type_glasses:    { GEAR_activeLoadout set [GEAR_index_glasses, _class]; };
	case GEAR_type_nvg:        { GEAR_activeLoadout set [GEAR_index_nvg, _class]; };
	case GEAR_type_binocular:  { GEAR_activeLoadout set [GEAR_index_binocular, _class]; };
	case GEAR_type_map:        { GEAR_activeLoadout set [GEAR_index_map, _class]; };
	case GEAR_type_gps:        { GEAR_activeLoadout set [GEAR_index_gps, _class]; };
	case GEAR_type_radio:      { GEAR_activeLoadout set [GEAR_index_radio, _class]; };
	case GEAR_type_compass:    { GEAR_activeLoadout set [GEAR_index_compass, _class]; };
	case GEAR_type_watch:      { GEAR_activeLoadout set [GEAR_index_watch, _class]; };
	
	// Ammo
	case 16;
	case 256;
	case 512;
	case 768;
	case 1536: {
		{
			_gun = _x call _get_item;
			if ( _gun != "" ) then {
				_magazines = getArray ( configFile >> "CfgWeapons" >> _gun >> "magazines" );
				if ( _class in _magazines ) then {
					GEAR_activeLoadout set [_x + 4, _class];
				};
			};
		} count [GEAR_index_primary, GEAR_index_secondary, GEAR_index_pistol];
	};
};

call GEAR_updateDialogImgs;