if ( !isNil "BL_animDoWorkInProgress" && { BL_animDoWorkInProgress } ) exitwith {
	hint 'Please wait until the current action is finished';
};

BL_animDoWorkInProgress = true;
_this spawn {
	private ['_duration', '_doAfter', '_player'];
	_validAnimations = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic0s", "amovpercmstpslowwrfldnon_amovpknlmstpslowwrfldnon", "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon", "amovppnemstpsraswrfldnon_amovpknlmstpsraswrfldnon"];
	
	_duration = [_this, 0, 5, [1]] call BIS_fnc_param;
	_message  = [_this, 1, "", [""]] call BIS_fnc_param;
	_params   = [_this, 2, [], [[]]] call BIS_fnc_param;
	_doAfter  = [_this, 3, {}, [{}]] call BIS_fnc_param;
	_player   = [_this, 4, player, [player]] call BIS_fnc_param;

	_player playAction "medicStart";
	_eh = _validAnimations spawn {
		waitUntil { !((animationState player) in _this) };
		['Action Interrupted', 3] call BL_fnc_actionText;
		BL_animDoWorkInProgress = false;
	};

	_step = (_duration/100);
	for "_i" from 1 to 100 do {
		[format [_message, (str _i) + '%']] call BL_fnc_actionText;
		sleep _step;
		if ( scriptDone _eh ) exitwith{};
	};

	if !( scriptDone _eh ) then {
		terminate _eh;
		[format[_message, '100%'], 1] call BL_fnc_actionText;
		_player playAction "medicStop";
		_params call _doAfter;
		BL_animDoWorkInProgress = false;
	};
};