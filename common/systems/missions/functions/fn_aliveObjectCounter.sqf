private ['_marker'];
_marker = format["aoc%1", 10 call BL_fnc_randStr];
[_marker, _this] spawn {
	/*
		[units]
		group
		[[0,0,0], radius]
	*/
	_marker     = _this select 0;
	_loc        = [_this select 1, 0, [0,0,0], [[], objNull]] call BIS_fnc_param;
	_toCount    = [_this select 1, 1, [], [[]]] call BIS_fnc_param;
	_what       = [_this select 1, 2, "AI", [""]] call BIS_fnc_param;
	_autoRemove = [_this select 1, 3, true, [true]] call BIS_fnc_param;
	
	_pos = _loc;
	if ( typeName _pos == "OBJECT" ) then {
		_pos = getPosATL _loc;
	};
	
	_marker = createMarker [_marker, _pos];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot_noshadow";
	_marker setMarkerColor "ColorBlack";
	
	while { true } do {
		_count = 0;
		
		if ( typeName _toCount == "ARRAY" ) then {
			_count = (typeName _toCount) call {
				if ( _this == "ARRAY" && typeName (_toCount select 0) == "OBJECT" ) exitwith{{alive _x} count _toCount};
				if ( _this == "ARRAY" && count _toCount == 2 ) exitwith{
					private ['_units'];
					_units = (_toCount select 0) nearEntities ["Man", _toCount select 1];
					{_units = _units + crew _x; nil } count ((_toCount select 0) nearEntities [["Air", "LandVehicle"], _toCount select 1]);
					{!isPlayer _x && alive _x} count _units
				};
			
				0
			};
		}
		else {
			if ( typeName _toCount == "GROUP" ) then {
				_count = {alive _x} count (units _toCount);
			};
		};
	
		if ( (_autoRemove && _count == 0) || (getMarkerColor _marker == "")) exitwith{};
		
		if ( typeName _loc == "OBJECT" ) then {
			_pos = getPosATL _loc;
			_marker setMarkerPos _pos;
		};
		
		_marker setMarkerText format['%1 %2 alive', _count, _what];
		
		sleep 1;
	};
	
	deleteMarker _marker;
};

_marker