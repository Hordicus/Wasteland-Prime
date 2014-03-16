private ['_total'];
_total    = 0;

{
	_total = _total + ( _x call GEAR_fnc_getMass );
} count _this;

_total