private ['_queryResult', '_compiledVal'];
_queryResult = _this select 0;

if ( typeName _queryResult == "STRING" ) then {
	_queryResult = ([[_queryResult]] call BL_fnc_processQueryResult) select 0;
}
else {
	{
		if ( typeName _x == "STRING" ) then {
			_num = parseNumber _x;
			if ( str _num == _x ) then {
				_queryResult set [_forEachIndex, _num];
			}
			else { if ( _num == 0 && {!isNil {call compile _x}} ) then {
				_compiledVal = call compile _x;
				if ( typeName _compiledVal == "ARRAY" ) then {
					_compiledVal = [_compiledVal] call BL_fnc_processQueryResult;
				};
				
				_queryResult set [_forEachIndex, _compiledVal];
			}};
		}
		else {
			if ( typeName _x == "ARRAY" ) then {
				_queryResult set [_forEachIndex, [_x] call BL_fnc_processQueryResult];
			};
		};
	} forEach _queryResult;
};

_queryResult