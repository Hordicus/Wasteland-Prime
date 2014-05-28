// Modified from: http://killzonekid.com/arma-scripting-tutorials-float-to-string-position-to-string/
private ['_arr', '_e'];
_arr = toArray str abs (_this % 1);
_e = _arr find 101;

if ( _e >= 0 ) then {
	_arr resize _e;
};
_arr set [0, 'x']; _arr = _arr - ['x'];

if ( _this < 0 ) then {
	"-" + (toString (toArray str ((abs _this) - (abs _this) % 1) + _arr))
}
else {
	toString (toArray str (_this - _this % 1) + _arr)
};