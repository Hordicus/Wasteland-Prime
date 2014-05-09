#include "script_macros_common.hpp"
private ["_strar", "_separ", "_countstr", "_countsepstr", "_split", "_curidx", "_curstr", "_char", "_sepidx", "_sephelper", "_newidx", "_cchar", "_schar"];
PARAMS_1(_string);
DEFAULT_PARAM(1,_separator,"");

_strar = toArray _string;
_separ = toArray _separator;
_countstr = count _strar;
_countsepstr = count _separ;
if (_countsepstr > _countstr) exitWith {[]};
_split = [];
if (_separator == "") then {
	{
		PUSH(_split,toString [_x]);
	} forEach _strar;
} else {
	_curidx = 0;
	_curstr = [];
	while {_curidx < _countstr} do {
		_char = _strar select _curidx;
		if (_char != _separ select 0) then {
			PUSH(_curstr,_char);
		} else {
			_sepidx = 0;
			_sephelper = [];
			_newidx = 0;
			for "_i" from _curidx to _curidx + _countsepstr do {
				if (_sepidx >= _countsepstr) exitWith {};
				if (_i >= _countstr) exitWith {};
				_cchar = _strar select _i;
				_schar = _separ select _sepidx;
				if (_cchar != _schar) exitWith {};
				PUSH(_sephelper,_cchar);
				INC(_sepidx);
				_newidx = _i;
			};
			if (count _sephelper == _countsepstr) then { // match
				_curidx = _newidx;
				PUSH(_split,toString _curstr);
				_curstr = [];
			} else {
				PUSH(_curstr,_char);
			};
		};
		INC(_curidx);
	};
	if (count _curstr > 0) then {
		PUSH(_split,toString _curstr);
	} else {
		PUSH(_split,"");
	};
};
_split
