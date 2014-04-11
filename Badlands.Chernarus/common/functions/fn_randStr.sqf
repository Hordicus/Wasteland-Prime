private ['_len', '_rand'];
_len = [_this, 0, 10, [0]] call BIS_fnc_param;
_rand = "";
for "_i" from 1 to _len do {
	_rand = _rand + str (floor random 10);
};

_rand