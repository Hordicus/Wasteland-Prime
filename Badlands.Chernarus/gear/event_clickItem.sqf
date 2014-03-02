#include "functions\macro.sqf"
_ctrlIDC   = ctrlIDC (_this select 0);
_btn       = _this select 1;
_coords_y  = _this select 3;

if ( _btn == 0 ) then { // Left click
	switch(_ctrlIDC) do {
		case (GEAR_select_uniform_idc): {
			'uniform' call GEAR_fnc_selectContainer;
		};
		case (GEAR_select_vest_idc): {
			'vest' call GEAR_fnc_selectContainer;
		};
		case (GEAR_select_backpack_idc): {
			'backpack' call GEAR_fnc_selectContainer;
		};
	};
}
else { if ( _btn == 1 ) then { // Right click
	_index = _ctrlIDC call GEAR_fnc_IDCtoLoadoutIndex;
	switch(_ctrlIDC) do {
		case (GEAR_select_uniform_idc);
		case (GEAR_select_vest_idc);
		case (GEAR_select_backpack_idc): {
			GEAR_activeLoadout set [_index, nil];
			GEAR_activeLoadout set [_index+1, nil];
		
			GEAR_activeContainer call GEAR_fnc_selectContainer;
			call GEAR_fnc_updateDialogImgs;
		};
	
		case (GEAR_selected_inv_idc): {
			_index = switch(GEAR_activeContainer) do {
				case 'uniform': { GEAR_index_uniform_contents };
				case 'vest': { GEAR_index_vest_contents };
				case 'backpack': { GEAR_index_backpack_contents };
			};
			
			_y = safezoneY + ( safezoneH * 0.12 );
			_rowHeight = 0.045;
			_row = floor((_coords_y - _y) / _rowHeight);
			
			_contents = GEAR_activeLoadout select _index;
			_contents set [_row, "REMOVE"];
			_contents = _contents - ["REMOVE"];
			GEAR_activeLoadout set [_index, _contents];
			GEAR_activeContainer call GEAR_fnc_selectContainer;
		};
	
		case (GEAR_pistol_idc);
		case (GEAR_secondary_idc);
		case (GEAR_primary_idc): {
			GEAR_activeLoadout set [_index, nil];
			GEAR_activeLoadout set [_index+1, nil];
			GEAR_activeLoadout set [_index+2, nil];
			GEAR_activeLoadout set [_index+3, nil];
			GEAR_activeLoadout set [_index+4, nil];
			call GEAR_fnc_updateDialogImgs;
		};
		
		case (GEAR_itemslist_idc): {
			if ( GEAR_activeNav == 'presets' ) then {
				_row = [_this select 0, [_this select 2, _this select 3]] call GEAR_fnc_getRowFromPos;
				_preset = lbData[GEAR_itemslist_idc, _row];
				lbDelete[GEAR_itemslist_idc, _row];
				[GEAR_presets, _preset] call CBA_fnc_hashRem;
				profileNamespace setVariable ["GEAR_presets", GEAR_presets];
				saveProfileNamespace;
			};
		};
		
		default {
			GEAR_activeLoadout set [_index, nil];
			call GEAR_fnc_updateDialogImgs;
		};
	};
}};