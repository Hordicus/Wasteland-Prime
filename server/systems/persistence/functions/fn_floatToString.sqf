// Modified from: http://killzonekid.com/arma-scripting-tutorials-float-to-string-position-to-string/
private ['_arr'];
_arr = toArray str (_this % 1);
_e = _arr find 101;

if ( _e >= 0 ) then {
	_arr resize _e;
};
_arr set [0, 'x']; _arr = _arr - ['x'];
toString (toArray str (_this - _this % 1) + _arr)