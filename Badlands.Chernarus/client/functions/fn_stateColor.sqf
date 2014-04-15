private ['_state'];
_state = [_this, 0, "EMPTY", [""]] call BIS_fnc_param;
_state call {
	if ( _this == "FRIENDLY" ) exitwith {"ColorGreen"};
	if ( _this == "ENEMY" ) exitwith {"ColorRed"};
	if ( _this == "MIXED" ) exitwith {"ColorOrange"};
	"ColorBlack"
}