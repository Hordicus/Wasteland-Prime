['basePart', [
	// Save
	{(_this select 0) getVariable 'objectOwner'},
	
	// Load
	{
		private ['_part'];
		_part = _this select 0;
		_part setVariable ['objectLocked', true, true];
		_part setVariable ['objectOwner', _this select 1, true];
	}
]] call BL_fnc_persRegisterTypeHandler;