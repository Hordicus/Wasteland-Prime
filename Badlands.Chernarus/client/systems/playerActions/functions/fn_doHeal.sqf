if ( !isNil "BL_animDoWorkInProgress" && { BL_animDoWorkInProgress } ) exitwith {
	hint 'Please wait until the current action is finished';
};

BL_animDoWorkInProgress = true;

_this spawn {
	private ["_validAnimations","_step","_time","_minTime","_healingTarget","_action","_itemName","_eh"];
	_validAnimations = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic0s", "amovpercmstpslowwrfldnon_amovpknlmstpslowwrfldnon", "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon"];
	_step = 0.01;
	_time = 0.35;
	_minTime = 0.05;
	
	_healingTarget = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

	_action = "";
	_itemName = "";
	if ( _healingTarget isKindOf "Man" ) then {
		_action = "Healing";
		_itemName = name _healingTarget;
	}
	else {
		_action = "Repairing";
		_itemName = getText (configFile >> "CfgVehicles" >> (typeOf _healingTarget) >> "displayName");
	};

	player playAction "medicStart";
	_eh = _validAnimations spawn {
		waitUntil { !((animationState player) in _this) };
		['Action Interrupted', 2] call BL_fnc_actionText;
		BL_animDoWorkInProgress = false;
	};

	while { damage _healingTarget > 0 && !scriptDone _eh} do {
		format['%1 %2 %3%4', _action, _itemName, round((1-damage _healingTarget)*100), '%'] call BL_fnc_actionText;
		sleep (_minTime max ((_time * (1-damage _healingTarget))));
		_healingTarget setDamage ((damage _healingTarget) - _step);
	};

	if !( scriptDone _eh ) then {
		terminate _eh;
		[format['Done %1 %2', _action, _itemName], 2] call BL_fnc_actionText;
		player playAction "medicStop";
		BL_animDoWorkInProgress = false;
	};
};