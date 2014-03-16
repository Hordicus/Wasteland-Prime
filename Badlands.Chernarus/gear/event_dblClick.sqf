#include "functions\macro.sqf"
_class = (_this select 0) lbData (_this select 1);

if ( GEAR_activeNav == 'presets' ) then {
	GEAR_activeLoadout = + [GEAR_presets, _class] call CBA_fnc_hashGet; // + creates copy

	call GEAR_fnc_updateDialogImgs;
	GEAR_activeContainer call GEAR_fnc_selectContainer;
}
else {
	_type  = _class call GEAR_fnc_getType;

	_get_item = {
		private ['_class'];
		_class = "";
		
		if ( count GEAR_activeLoadout > _this && { !isNil { GEAR_activeLoadout select _this } }) then {
			_class = GEAR_activeLoadout select _this;
		};
		
		_class
	};

	_do_default = true;

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
			_do_default = false;
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
				_do_default = false;
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
				if ( _gun != "" && {[_gun, _class] call GEAR_fnc_validAttachment}) exitwith {
					GEAR_activeLoadout set [_x + _offset, _class];
					_do_default = false;
				};
			} count [GEAR_index_primary, GEAR_index_secondary, GEAR_index_pistol];
		};
		
		case GEAR_type_helmet:     { GEAR_activeLoadout set [GEAR_index_helmet, _class]; _do_default = false; };
		case GEAR_type_glasses:    { GEAR_activeLoadout set [GEAR_index_glasses, _class]; _do_default = false; };
		case GEAR_type_nvg:        { GEAR_activeLoadout set [GEAR_index_nvg, _class]; _do_default = false; };
		case GEAR_type_binocular:  { GEAR_activeLoadout set [GEAR_index_binocular, _class]; _do_default = false; };
		case GEAR_type_map:        { GEAR_activeLoadout set [GEAR_index_map, _class]; _do_default = false; };
		case GEAR_type_gps:        { GEAR_activeLoadout set [GEAR_index_gps, _class]; _do_default = false; };
		case GEAR_type_radio:      { GEAR_activeLoadout set [GEAR_index_radio, _class]; _do_default = false; };
		case GEAR_type_compass:    { GEAR_activeLoadout set [GEAR_index_compass, _class]; _do_default = false; };
		case GEAR_type_watch:      { GEAR_activeLoadout set [GEAR_index_watch, _class]; _do_default = false; };
		
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
					_active_mag = (_x + 4) call _get_item;
					
					if ( _class in _magazines && ( _class != _active_mag ) ) exitwith {
						GEAR_activeLoadout set [_x + 4, _class];
						_do_default = false;
					};
				};
			} count [GEAR_index_primary, GEAR_index_secondary, GEAR_index_pistol];
		};
	};

	if ( _do_default ) then {
		// Find room in uniform/vest/backpack and add if possible
		// Start with currently selected container.
		_activeContainerIndex = switch(GEAR_activeContainer) do {
			case 'uniform': {GEAR_index_uniform};
			case 'vest': {GEAR_index_vest};
			case 'backpack': {GEAR_index_backpack};
		};
		
		{
			if ( !_do_default ) exitwith {};
			
			_item = _x call _get_item;
			_item_type = _item call GEAR_fnc_getType;
			
			if ( _item != "" ) then {
				_contents = GEAR_activeLoadout select (_x + 1);
				_capacity = _item call GEAR_fnc_getMassCapacity;
				_allowed_slots = _class call GEAR_fnc_allowedSlots;
				if ( _item_type in _allowed_slots && { (([_class] + _contents) call GEAR_fnc_getTotalMass) <= _capacity } ) then {
					GEAR_activeLoadout set [_x+1, (_contents + [_class])];
					GEAR_activeContainer call GEAR_fnc_selectContainer;
					_do_default = false;
				};
			};
		
		} count [_activeContainerIndex] + ([GEAR_index_uniform, GEAR_index_vest, GEAR_index_backpack] - [_activeContainerIndex]);
	};
	
	call GEAR_fnc_updateDialogImgs;
};