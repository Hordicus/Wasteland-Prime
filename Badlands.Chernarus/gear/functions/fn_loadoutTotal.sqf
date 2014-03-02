#include "macro.sqf"
private ['_total'];

_total = 0;

for "_i" from 0 to (count _this) do {
	_item = GET(_this, _i, "");
	if ( typeName _item == "ARRAY" ) then {
		{
			_total = _total + (_x call GEAR_fnc_itemPrice);
		} count _item;
	} else { if ( _item != "" ) then {
		_total = _total + (_item call GEAR_fnc_itemPrice);
	}};
};

_total