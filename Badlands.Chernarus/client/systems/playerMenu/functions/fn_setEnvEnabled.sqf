private ['_index'];
_index = [_this, 0, 1, [0]] call BIS_fnc_param;
enableEnvironment (switch _index do {
	case 0: {false};
	case 1: {true};
});