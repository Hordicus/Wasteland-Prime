#include "functions\macro.sqf"
disableSerialization;

_target       = ctrlIDC (_this select 0);
_dropped      = _this select 4 select 0;
_class        = _dropped select 2;
_type         = _class call GEAR_fnc_getType;
_allowedSlots = _class call GEAR_fnc_allowedSlots;
_valid        = false;

_idcs = [
	 GEAR_select_helmet_idc, GEAR_select_glasses_idc, GEAR_select_nvg_idc, GEAR_select_binocular_idc,
	GEAR_item_map_idc, GEAR_item_gps_idc, GEAR_item_radio_idc, GEAR_item_compass_idc, GEAR_item_watch_idc
];

_types = [
	GEAR_type_helmet, GEAR_type_glasses, GEAR_type_nvg, GEAR_type_binocular,
	GEAR_type_map, GEAR_type_gps, GEAR_type_radio, GEAR_type_compass, GEAR_type_watch
];

_type_indexes = [
	GEAR_index_helmet, GEAR_index_glasses, GEAR_index_nvg, GEAR_index_binocular,
	GEAR_index_map, GEAR_index_gps, GEAR_index_radio, GEAR_index_compass, GEAR_index_watch
];

_index = _idcs find _target;
if ( _index >= 0 ) then {
	_target_type = _types select _index;
	_type_index = _type_indexes select _index;
	
	if ( _type == _target_type ) then {
		GEAR_activeLoadout set [_type_index, _class];
	};
}
else {
	switch(_target) do {
		case (GEAR_selected_inv_idc);
		case (GEAR_select_uniform_idc);
		case (GEAR_select_vest_idc);
		case (GEAR_select_backpack_idc): {
			_target_type = -1;
			_target_index = -1;
			
			if ( _target == GEAR_selected_inv_idc && !(_type in [GEAR_type_uniform, GEAR_type_vest, GEAR_type_backpack])) then {
				_target = switch(GEAR_activeContainer) do {
					case 'uniform': {(GEAR_select_uniform_idc)};
					case 'vest': {(GEAR_select_vest_idc)};
					case 'backpack': {(GEAR_select_backpack_idc)};
				};
			};
			
			switch(_target) do {
				case (GEAR_select_uniform_idc): {
					_target_type = GEAR_type_uniform;
					_target_index = GEAR_index_uniform;
				};
				
				case (GEAR_select_vest_idc): {
					_target_type = GEAR_type_vest;
					_target_index = GEAR_index_vest;
				};
				
				case (GEAR_select_backpack_idc): {
					_target_type = GEAR_type_backpack;
					_target_index = GEAR_index_backpack;
				};
			};
			
			_target_contents_index = _target_index + 1;
		
			if ( _type == _target_type) then {
				GEAR_activeLoadout set [_target_index, _class];
				GEAR_activeLoadout set [_target_contents_index, []];
			}
			else {
				// Is it allowed in this container?
				if ( _target_type in _allowedSlots && { count GEAR_activeLoadout > _target_contents_index } ) then {
					// Is there room?
					_contents = GEAR_activeLoadout select _target_contents_index;
					_capacity = (GEAR_activeLoadout select _target_index) call GEAR_fnc_getMassCapacity;
					_total    = ([_class] + _contents) call GEAR_fnc_getTotalMass;
					
					if ( _total <= _capacity ) then {
						_contents set [count _contents, _class];
						GEAR_activeLoadout set [_target_contents_index, _contents];
					}
					else {
					};
				};
			};
			
			GEAR_activeContainer call GEAR_fnc_selectContainer; // refresh display
		};
	
		case (GEAR_primary_idc): {
			if ( _type != GEAR_type_primary) exitwith{};

			GEAR_activeLoadout set [GEAR_index_primary, _class];
			GEAR_activeLoadout set [GEAR_index_primary_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_primary_acc, nil];
			GEAR_activeLoadout set [GEAR_index_primary_optic, nil];
			GEAR_activeLoadout set [GEAR_index_primary_mag, nil];
		};
		
		case (GEAR_secondary_idc): {
			if ( _type != GEAR_type_secondary) exitwith{};

			GEAR_activeLoadout set [GEAR_index_secondary, _class];
			GEAR_activeLoadout set [GEAR_index_secondary_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_acc, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_optic, nil];
			GEAR_activeLoadout set [GEAR_index_secondary_mag, nil];
		};
		
		case (GEAR_pistol_idc): {
			if ( _type != GEAR_type_pistol) exitwith{};

			GEAR_activeLoadout set [GEAR_index_pistol, _class];
			GEAR_activeLoadout set [GEAR_index_pistol_muzzle, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_acc, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_optic, nil];
			GEAR_activeLoadout set [GEAR_index_pistol_mag, nil];
		};
	
		case (GEAR_primary_muzzle_idc);
		case (GEAR_secondary_muzzle_idc);
		case (GEAR_pistol_muzzle_idc): {
			if ( _type != GEAR_type_muzzle) exitwith{};
			_gun_offset = -2;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_fnc_IDCToLoadoutIndex);
			
			if ( [_gun, _class, 'muzzle'] call GEAR_fnc_validAttachment ) then {
				GEAR_activeLoadout set [ _target call GEAR_fnc_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_acc_idc);
		case (GEAR_secondary_acc_idc);
		case (GEAR_pistol_acc_idc): {
			if ( _type != GEAR_type_acc) exitwith{};
			_gun_offset = -4;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_fnc_IDCToLoadoutIndex);
			
			if ( [_gun, _class, 'acc'] call GEAR_fnc_validAttachment ) then {
				GEAR_activeLoadout set [ _target call GEAR_fnc_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_optic_idc);
		case (GEAR_secondary_optic_idc);
		case (GEAR_pistol_optic_idc): {
			if ( _type != GEAR_type_optic) exitwith{};
			_gun_offset = -6;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_fnc_IDCToLoadoutIndex);
			
			if ( [_gun, _class, 'optic'] call GEAR_fnc_validAttachment ) then {
				GEAR_activeLoadout set [ _target call GEAR_fnc_IDCToLoadoutIndex, _class ];
			};
		};
		
		case (GEAR_primary_mag_idc);
		case (GEAR_secondary_mag_idc);
		case (GEAR_pistol_mag_idc): {
			_gun_offset = -8;
			_gun = GEAR_activeLoadout select ((_target + _gun_offset) call GEAR_fnc_IDCToLoadoutIndex);
			_compatible_mags = getArray (configFile >> "CfgWeapons" >> _gun >> "magazines");
			
			if ( _class in _compatible_mags ) then {
				GEAR_activeLoadout set [ _target call GEAR_fnc_IDCToLoadoutIndex, _class ];
			};
		};
	};
};

// call GEAR_fnc_updateDialogImgs;
call GEAR_fnc_updateDialogImgs;