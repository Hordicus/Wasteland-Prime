{
	if ( typeName _x == "SCALAR" ) then {
		CBA_e = _this;
		_x publicVariableClient "CBA_e";
	};
} count (BL_HCs select 2);