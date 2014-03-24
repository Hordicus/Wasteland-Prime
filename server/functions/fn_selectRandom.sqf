/*
	Description:
	Selects a random item from an array.
	Can optionally add a chance to items to be
	considered.
	
	Parameter(s):
	_items - Items to select from
	_chanceIndex - Index for item that holds chance value
		in each item.
	_lowestChance - If the lowest chance value is known, pass it in here.
		If the value is not provided it will be calculated.
	
	Returns:
	Random item from array
	
	Examples:
	['one', 'two', 'three'] call BL_fnc_selectRandom;
	
	[[
		['High Probability', 1],
		['Med Probability', 0.5],
		['Low Probability', 0.2]
	], 1, 0.2] call BL_fnc_selectRandom;
*/

private ["_items","_chanceIndex","_lowestChance","_chance","_possible"];
_items = [_this, 0, [], [[]]] call BIS_fnc_param;
_chanceIndex = [_this, 1, -1, [0]] call BIS_fnc_param;
_lowestChance = [_this, 2, false, [0]] call BIS_fnc_param;

if ( typeName _lowestChance == "BOOL" && _chanceIndex >= 0 ) then {
	_lowestChance = 1;
	{
		if ( _x select _chanceIndex < _lowestChance ) then {
			_lowestChance = _x select _chanceIndex;
		};
	} forEach _items;
};

if ( _chanceIndex >= 0 ) then {
	_chance = random 1 + _lowestChance;
	_possible = [];
	
	{
		if ( 1-(_x select 1) <= _chance ) then {
			_possible set [count _possible, _x];
		};
	} count _items;
	
	_possible select floor random count _possible
}
else {
	_items select floor random count _items
};