_cars = entities "Car";
_counts = [[], 0] call CBA_fnc_hashCreate;


{
	_type = typeOf _x;
	_count = ([_counts, _type] call CBA_fnc_hashGet) + 1;
	
	[_counts, _type, _count] call CBA_fnc_hashSet;
} forEach _cars;

_str = "";
[_counts, {
	_str = _str + format["%1: %2\n", _key, _value];
}] call CBA_fnc_hashEachPair;

hint _str;
copyToClipboard _str;