if ( !isNil "BL_animDoWorkInProgress" && { BL_animDoWorkInProgress } ) exitwith {
	hint 'Please wait until the current action is finished';
};

BL_animDoWorkInProgress = true;
_this spawn {
	private ['_duration', '_doAfter', '_player'];
	_validAnimations = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic0s", "amovpercmstpslowwrfldnon_amovpknlmstpslowwrfldnon", "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon"];
	
	_duration = [_this, 0, 5, [1]] call BIS_fnc_param;
	_params   = [_this, 1, [], [[]]] call BIS_fnc_param;
	_doAfter  = [_this, 2, {}, [{}]] call BIS_fnc_param;
	_player   = [_this, 3, player, [player]] call BIS_fnc_param;

	_player playAction "medicStart";
	_eh = _validAnimations spawn {
		waitUntil { !((animationState player) in _this) };
		titleText ['Action Interrupted', 'PLAIN', 1];
		titleFadeOut 5;
		BL_animDoWorkInProgress = false;
	};
	
	sleep _duration;
	if !( scriptDone _eh ) then {
		terminate _eh;
		_player playAction "medicStop";
		_params call _doAfter;
		BL_animDoWorkInProgress = false;
	};
};