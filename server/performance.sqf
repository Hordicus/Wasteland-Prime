#include "debug_console.hpp"
#define PERF_START(NAME) PERFS = missionNamespace getVariable ['PERFS', [] call CBA_fnc_hashCreate]; [PERFS, NAME, diag_tickTime] call CBA_fnc_hashSet;
#define PERF_STOP(NAME, LOG) \
	PERF_HISTORY  = missionNamespace getVariable ['PERF_HISTORY', [[], []] call CBA_fnc_hashCreate]; \
	private "_perf_history"; \
	_perf_history = [PERF_HISTORY, NAME] call CBA_fnc_hashGet; \
	_perf_history set [count _perf_history, diag_tickTime - ([PERFS, NAME] call CBA_fnc_hashGet)]; \
	[PERF_HISTORY, NAME, _perf_history] call CBA_fnc_hashSet; \
	if ( LOG ) then { \
		PERF_LOG(NAME) \
	};
	
#define PERF_LOG(NAME) \
	private ['_max', '_sum', '_min', '_perf_history', '_msg']; \
	_perf_history = [PERF_HISTORY, NAME] call CBA_fnc_hashGet; \
	_max = 0; \
	_sum = 0; \
	_min = 99999999999999999; \
	{ \
		if ( _x > _max ) then { _max = _x; }; \
		if ( _x < _min ) then { _min = _x; }; \
		_sum = _sum + _x; \
	} count _perf_history; \
	_msg = format['%1: Perf time: %2, Max: %3, Avg: %4, Min: %5, Sum: %6', NAME, _perf_history select ((count _perf_history)-1), _max, _sum/count _perf_history, _min, _sum]; \
	conFileTime(_msg);