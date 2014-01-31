// findDisplay 12 displayCtrl 51 ctrlRemoveAllEventHandlers "Draw";
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
	_map = _this select 0;
	{
		_icon  = getText ( configFile >> "CfgVehicles" >> (typeOf _x) >> "icon" );
		_dmg   = damage _x;
		_color = [1, 1-_dmg, 1-_dmg, 1];
		
		_map drawIcon [ _icon, _color, getPos _x, 20, 20, 0];
	} forEach ((entities "Car") + (entities "Air"));
}];