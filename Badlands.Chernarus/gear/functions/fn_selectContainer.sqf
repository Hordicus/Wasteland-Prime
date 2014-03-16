#include "macro.sqf"

private ["_container","_items","_index","_container_type","_img","_price","_string","_idc","_capacity","_backpack","_total", "_fill"];
_container = _this;
GEAR_activeContainer = _container;

_items = [];
_index = -1;

switch(_container) do {
	case 'uniform': { _index = GEAR_index_uniform; };
	case 'vest': { _index = GEAR_index_vest; };
	case 'backpack': { _index = GEAR_index_backpack; };
};

if ( count GEAR_activeLoadout < _index ) then {
	_container_type = nil;
}
else {
	_container_type = GEAR_activeLoadout select _index;
};

lbClear ((findDisplay GEAR_dialog_idc) displayCtrl GEAR_selected_inv_idc);
((findDisplay GEAR_dialog_idc) displayCtrl GEAR_select_uniform_idc-1) ctrlSetBackgroundColor [0,0,0,0.5];
((findDisplay GEAR_dialog_idc) displayCtrl GEAR_select_vest_idc-1) ctrlSetBackgroundColor [0,0,0,0.5];
((findDisplay GEAR_dialog_idc) displayCtrl GEAR_select_backpack_idc-1) ctrlSetBackgroundColor [0,0,0,0.5];

((findDisplay GEAR_dialog_idc) displayCtrl (_index call GEAR_fnc_loadoutIndexToIDC)-1) ctrlSetBackgroundColor [1,1,1,0.5];

if ( !isNil "_container_type" ) then {
	_items = GEAR_activeLoadout select (_index+1);
	{
		_name = _x call GEAR_fnc_itemName;
		_img = _x call GEAR_fnc_itemImg;
		_price = _x call GEAR_fnc_itemPrice;
		
		_string = format['%1 [$%2]', _name, _price];
		lbAdd [GEAR_selected_inv_idc, _string];
		lbSetData [GEAR_selected_inv_idc, _forEachIndex, _x];
		lbSetPicture[GEAR_selected_inv_idc, _forEachIndex, _img];
	} forEach _items;
};

// Update mass bars
{
	_index = _x select 0;
	_idc   = _x select 1;
	if ( count GEAR_activeLoadout > _index ) then {
		_container = GEAR_activeLoadout select _index;
		_fill = 0;
		
		if ( ! isNil "_container" ) then {
			_items = GEAR_activeLoadout select _index+1;
			_capacity = _container call GEAR_fnc_getMassCapacity;
			_total = 0;
			{
				_total = _total + ( _x call GEAR_fnc_getMass );
			} count _items;
			
			if ( _total > 0 ) then {
				_fill = _total / _capacity;
			};
		};
		
		((findDisplay GEAR_dialog_idc) displayCtrl _idc) progressSetPosition _fill;	
	};
} count [
	[ GEAR_index_uniform, GEAR_uniform_load_idc ],
	[ GEAR_index_vest, GEAR_vest_load_idc ],
	[ GEAR_index_backpack, GEAR_backpack_load_idc ]
];