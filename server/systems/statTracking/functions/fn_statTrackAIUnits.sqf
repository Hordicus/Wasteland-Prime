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
			private ['_killer'];
			_killer = _this select 1;
			if ( isPlayer _killer ) then {
				[_killer, [call BL_fnc_statTrackingConfig, 'aiKillScore'] call CBA_fnc_hashGet] call BL_fnc_addScore;
			};
		}];
	};
	true
} count _units;

nil