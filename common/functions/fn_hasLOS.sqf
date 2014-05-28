private ["_players","_LOSTo","_eyeDV","_eyeD","_dirTo","_eyePb","_LOSPos"];
_players = [_this, 0, [], [[], objNull]] call BIS_fnc_param;
_LOSTo = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

if ( typeName _players == "OBJECT" ) then {
	_players = [_players];
};

({
	_eyeDV = eyeDirection _x;
	_eyeD = ((_eyeDV select 0) atan2 (_eyeDV select 1));

	if (_eyeD < 0) then {_eyeD = 360 + _eyeD};

	_dirTo = [_x, _LOSTo] call BIS_fnc_dirTo;

	_eyePb = eyePos _x;
	_LOSPos = getPosASL _LOSTo;

	(!(abs(_dirTo - _eyeD) >= 90 && (abs(_dirTo - _eyeD) <= 270)) && {!(
		lineIntersects [_eyePb, _LOSPos, _x, _LOSTo] ||
		terrainIntersectASL [_eyePb, _LOSPos]
	)})
} count _players) > 0