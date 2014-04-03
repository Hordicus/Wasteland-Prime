if ( typeName (_this select 5) == "CODE" ) then {
	(_this select 2) call (_info select 4);
}
else {
	[5, _this, {
		private ['_1mInfront'];
		_1mInfront = [getPosATL player, 1, getDir player] call BIS_fnc_relPos;
		[(_this select 2), _1mInfront, 'invItem', [_this select 0], {
			(_this select 0) setVariable ['BL_invDroppedItem', true, true];
			(_this select 0) setVariable ['BL_invDroppedType', (_this select 1 select 0), true];
		}] call BL_fnc_createVehicle;
		(_this select 0) call BL_fnc_removeInventoryItem;
	}] call BL_fnc_animDoWork;
};