#include "dialogs\gear_defines.sqf"
private ['_total'];

_total = 0;

for "_i" from 0 to (count _this) do {
	_item = GET(_this, _i, "");
	if ( typeName _item == "ARRAY" ) then {
		{
			_total = _total + (_x call GEAR_itemPrice);
		} count _item;
	} else { if ( _item != "" ) then {
		_total = _total + (_item call GEAR_itemPrice);
	}};
};

_total