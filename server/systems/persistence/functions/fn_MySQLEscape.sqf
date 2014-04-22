private ['_value', '_a', '_str'];
_value = [_this, 0, "", ["", 0, true, false, [], sideLogic, nil]] call BIS_fnc_param;

if ( isNil "_value" ) then {
	_value = "NULL";
}
else {
	_value call {
		if ( typeName _this == "SCALAR" ) exitwith {str _this};
		if ( typeName _this == "BOOL" && {_this} ) exitwith {"1"};
		if ( typeName _this == "BOOL" && {!_this} ) exitwith {"0"};
		
		if ( typeName _this == "ARRAY" ) exitwith {
			{
				_this set [_forEachIndex, [_x] call BL_fnc_MySQLEscape];
			} forEach ([_this] call BL_fnc_noEmptyArrayValues);
			
			str _this
		};
		
		if ( typeName _this == "STRING" ) exitwith {
			_a = toArray _this;
			_value = [];

			{
				if ( _x in [92, 39] ) then { // \ and '
					_value set [count _value, 92];
				};
				
				_value set [count _value, _x];
			} count _a;
			
			"'" + (toString _value) + "'"
		};
	};
};