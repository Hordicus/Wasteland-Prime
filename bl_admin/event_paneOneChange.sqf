#include "functions\macro.sqf"
disableSerialization;
_dialog = uiNamespace getVariable 'adminPanel';
_dialog call BLAdmin_fnc_hideCtrls;
_data = (_this select 0) lbData (_this select 1);

_paneTwo = _dialog displayCtrl paneTwoIDC;
lbClear _paneTwo;

// Non player action
if ( { _data == _x select 1 } count BLAdmin_actions == 1 ) then {
	BL_adminPlayer = _data;
	
	_data call {
		if ( _this == "delete" ) exitwith {
			["Start Delete Cam", {
				closeDialog 0;
				[] call BLAdmin_fnc_deleteCam;
			}] call BLAdmin_fnc_setButton;		
		};
		
		if ( _this == "reveal" ) exitwith {
			{
				_index = _paneTwo lbAdd (_x select 0);
				_paneTwo lbSetData [_index, _x select 1];
				
				true
			} count [
				['Players', 'Man'],
				['Vehicles', 'AllVehicles'],
				['Base Parts', 'Static'],
				['Ammo Boxes', 'Reammobox_F'],
				['Show All', 'All'],
				['Hide All', '']
			];
		};
	};
}
else {
	BL_adminPlayer = [_data] call BL_fnc_playerByUID;

	{
		_index = _paneTwo lbAdd (_x select 0);
		_paneTwo lbSetData [_index, _x select 1];
		
		true
	} count BLAdmin_actions;
};