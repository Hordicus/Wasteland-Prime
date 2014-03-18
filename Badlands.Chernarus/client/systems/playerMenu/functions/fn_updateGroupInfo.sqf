#include "macro.sqf"

_display = [_this, 0, (findDisplay playerMenuDialogIDD), [displayNull]] call BIS_fnc_param;

_allPlayers = _display displayCtrl allPlayersIDC;
_groupPlayers = _display displayCtrl groupPlayersIDC;
lbClear _allPlayers;
lbClear _groupPlayers;

_leaveGrp = _display displayCtrl groupLeaveIDC;
_leaveGrp ctrlShow false;

[[], _display] call BL_fnc_setGroupButtons;

{
	if ( count units group _x == 1 && _x != player ) then {
		_allPlayers lbAdd (name _x);
	};
} forEach allUnits;

if ( count units group player > 1 ) then {
	_leaveGrp ctrlShow true;

	{
		_groupPlayers lbAdd (name _x);
	} forEach units group player;
};