#include "script_macros_common.hpp"
PARAMS_2(_haystack,_needle);
DEFAULT_PARAM(2,_initialIndex,0);

private ["_haystackCount", "_needleCount", "_foundPos",
	"_needleIndex", "_doexit", "_notfound"];

if (typeName _haystack == "STRING") then {
	_haystack = toArray _haystack;
};

if (typeName _needle == "STRING") then {
	_needle = toArray _needle;
};

_haystackCount = count _haystack;
_needleCount = count _needle;
_foundPos = -1;

if ((_haystackCount - _initialIndex) < _needleCount) exitWith {_foundPos};

_needleIndex = 0;
_doexit = false;
for "_i" from _initialIndex to (_haystackCount - 1) do {
	if (_haystack select _i == _needle select _needleIndex) then {
		if (_needleCount == 1) exitWith {
			_foundPos = _i;
			_doexit = true;
		};
		if (_haystackCount - _i < _needleCount) exitWith {_doexit = true};
		INC(_needleIndex);
		_notfound = false;
		for "_j" from (_i + 1) to (_i + _needleCount - 1) do {
			if (_haystack select _j != _needle select _needleIndex) exitWith {
				_notfound = true;
			};
			INC(_needleIndex);
		};
		if (_notfound) then {
			_needleIndex = 0;
		} else {
			_foundPos = _i;
			_doexit = true;
		};
	};
	if (_doexit) exitWith {};
};

_foundPos