_dialog = _this select 0;
(_this select 0) displayAddEventHandler ['KeyDown', {
	if ( (_this select 1) == 1 ) then {
		createDialog "abortConfirm";
		true // Stops user from closing dialog
	};
}];