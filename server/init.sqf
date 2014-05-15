#include "\x\bl_server\addons\performance.sqf"
BL_sessionStart = call compile ("Arma2Net.Unmanaged" callExtension "DateTime ['now', 'yyyy-MM-dd HH:mm:ss']");

[] spawn {
	PERF_HISTORY  = missionNamespace getVariable ['PERF_HISTORY', [[], []] call CBA_fnc_hashCreate];
	
	while { true } do {
		sleep (60 * 5);
		conFileTime("==== Start Dump ====");
		[PERF_HISTORY, {
			_perf_history = _value;
			_max = 0;
			_sum = 0;
			_min = 99999999999999999;
			{
				if ( _x > _max ) then { _max = _x; };
				if ( _x < _min ) then { _min = _x; };
				_sum = _sum + _x;
			} count _perf_history;
			_msg = format['%1: Perf time: %2, Max: %3, Avg: %4, Min: %5, Sum: %6, Count: %7', _key, _perf_history select ((count _perf_history)-1), _max, _sum/count _perf_history, _min, _sum, count _perf_history];
			conFileTime(_msg)
		}] call CBA_fnc_hashEachPair;
		conFileTime("==== End Dump ====");
	};
};