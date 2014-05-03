private ['_units'];
_units = [_this, 0, [], [[], objNull, grpNull]] call BIS_fnc_param;

if ( typeName _units == "OBJECT" ) then {
	_units = [_units];
};

if ( typeName _units == "GROUP" ) then {
	_units = units _units;
};

{
	if ( local _x ) then {
		_x addEventHandler ['Killed', {
			['killed', _this] call CBA_fnc_localEvent;
		}];
	};
	true
} count _units;

nil