#include "macro.sqf"
disableSerialization;
_display = [_this, 0, (findDisplay playerMenuDialogIDD), [displayNull]] call BIS_fnc_param;

_allPlayers = _display displayCtrl allPlayersIDC;
_groupPlayers = _display displayCtrl groupPlayersIDC;
lbClear _allPlayers;
lbClear _groupPlayers;

_leaveGrp = _display displayCtrl groupLeaveIDC;
_leaveGrp ctrlShow false;

_players = [playableUnits, [], {
	_x call {
		if ( (name _x) in BL_groupInvites ) exitwith { 2 };
		if ( (name _x) in BL_groupSentInvites ) exitwith { 1 };
		0
	};
}, "DESCEND"] call BIS_fnc_sortBy;

{
	if ( !(_x in units group player) && (side _x == side player || side _x == playerSide)) then {
		_index = _allPlayers lbAdd (name _x);
		
		if ( (name _x) in BL_groupSentInvites ) then {
			_allPlayers lbSetPicture [_index, "client\systems\playerMenu\icons\inviteSent.paa"];
		};
		
		if ( (name _x) in BL_groupInvites ) then {
			_allPlayers lbSetPicture [_index, "client\systems\playerMenu\icons\inviteReceived.paa"];
		};
	};
} forEach _players;

if ( count units group player > 1 ) then {
	_leaveGrp ctrlShow true;

	{
		_groupPlayers lbAdd (name _x);
	} forEach units group player;
};

if ( BL_groupLastClicked < 0 ) then {
	[[], _display] call BL_fnc_setGroupButtons;
}
else {
	lbSetCurSel [BL_groupLastClicked, lbCurSel BL_groupLastClicked];
};