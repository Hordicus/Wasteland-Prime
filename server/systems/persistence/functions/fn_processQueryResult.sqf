private ["_numbers","_queryResult","_aThis","_compiledVal"];
_numbers = toArray '012345678901.-'; //[48,49,50,51,52,53,54,55,56,57,48,49,46]; // toArray '012345678901.-'
_queryResult = _this select 0;

if ( typeName _queryResult == "STRING" ) then {
	_queryResult = ([[_queryResult]] call BL_fnc_processQueryResult) select 0;
}
else {
	{
		if ( typeName _x == "STRING" ) then {
			_aThis = toArray _x;
			if ( count (_aThis - _numbers) == 0 && {!(101 in (toArray str parseNumber _x))}) then {
				_queryResult set [_forEachIndex, parseNumber _x];
			}
			else { if ( (_aThis find 91) != -1 ) then {
				_compiledVal = call compile _x;
				if ( !isNil "_compiledVal" ) then {
					_queryResult set [_forEachIndex, [_compiledVal] call BL_fnc_processQueryResult];
				};
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