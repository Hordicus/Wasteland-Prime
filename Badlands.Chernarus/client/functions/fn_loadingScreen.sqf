disableSerialization;
private ['_msg', '_progress'];
_msg = [_this, 0, "", ["", 0]] call BIS_fnc_param;
_progress = [_this, 1, 0, [0]] call BIS_fnc_param;

_loadingScreen = uiNamespace getVariable ['loadingScreen', displayNull];

if ( typeName _msg == "SCALAR" ) then {
	_progress = _msg;
	_msg = ctrlText (_loadingScreen displayCtrl 101);
};

if ( _msg == "" ) then {
	closeDialog 0;
}
else {
	if ( isNull _loadingScreen ) then {
		createDialog 'BLLoadingScreen';
		_loadingScreen = uiNamespace getVariable ['loadingScreen', displayNull];
	};
	
	_msgCtrl = _loadingScreen displayCtrl 101;
	_progressCtrl = _loadingScreen displayCtrl 104;
	
	_msgCtrl ctrlSetText _msg;
	_progressCtrl progressSetPosition _progress;
};
