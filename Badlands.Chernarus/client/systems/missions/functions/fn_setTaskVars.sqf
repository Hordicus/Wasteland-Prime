// We get removed keys this way too. We can delete the missionNamespace variables once they
// have the value "UNDEF"
{
	_value = (BL_PVAR_currentTasks select 2 select _forEachIndex);
	
	if ( typeName _value == "STRING" && {_value == "UNDEF"} ) then {
		_value = nil;
	};
	
	missionNamespace setVariable [_x, _value];
} forEach (BL_PVAR_currentTasks select 1);