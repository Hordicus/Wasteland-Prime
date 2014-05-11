if ( !isNil "BL_animDoWorkInProgress" && { BL_animDoWorkInProgress } ) exitwith {
	hint 'Please wait until the current action is finished';
};

BL_animDoWorkInProgress = true;
_this spawn {
	private ["_duration","_message","_params","_doAfter","_onCancel","_player","_step","_i","_position","_veh"];
	_validAnimations = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic0s", "amovpercmstpslowwrfldnon_amovpknlmstpslowwrfldnon", "amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon", "amovppnemstpsraswrfldnon_amovpknlmstpsraswrfldnon"];
	
	_duration = [_this, 0, 5, [1]] call BIS_fnc_param;
	_message  = [_this, 1, "", [""]] call BIS_fnc_param;
	_params   = [_this, 2, [], [[]]] call BIS_fnc_param;
	_doAfter  = [_this, 3, {}, [{}]] call BIS_fnc_param;
	_onCancel = [_this, 4, {}, [{}]] call BIS_fnc_param;
	_player   = [_this, 5, player, [player]] call BIS_fnc_param;

	BL_animDoWorkAnimLoop = [] spawn {
		while { BL_animDoWorkInProgress } do {
			"ainvpknlmstpslaywrfldnon_medic" call BL_fnc_switchMove;
			waitUntil {animationState player != "ainvpknlmstpslaywrfldnon_medic"};
		};
	};
	
	BL_animDoWorkKeyDown = (findDisplay 46) displayAddEventHandler ['KeyDown', {
		if ( (_this select 1) in ((actionKeys 'MoveForward') + (actionKeys 'TurnLeft') + (actionKeys 'TurnRight') + (actionKeys 'MoveBack')) ) then {
			terminate BL_animDoWorkAnimLoop;
		};
	}];

	_step = (_duration/100);
	for "_i" from 1 to 100 do {
		[format [_message, (str _i) + '%']] call BL_fnc_actionText;
		sleep _step;
		if (  scriptDone BL_animDoWorkAnimLoop || !alive player || vehicle player != player ) exitwith{};
	};

	BL_animDoWorkInProgress = false;
	(findDisplay 46) displayRemoveEventHandler ['KeyDown', BL_animDoWorkKeyDown];
	
	if ( !scriptDone BL_animDoWorkAnimLoop && alive player && vehicle player == player ) then {
		"amovpknlmstpsraswrfldnon" call BL_fnc_switchMove; // Crouch
		[format[_message, '100%'], 1] call BL_fnc_actionText;
		_params call _doAfter;
	}
	else {
		[] call {
			if ( !alive player ) exitwith {
				['', 0] call BL_fnc_actionText;
			};
			
			if ( vehicle player != player ) exitwith {
				['Action interrupted', 3] call BL_fnc_actionText;
				_params call _onCancel;
				
				// Animation will be glitch out. Get out/back in
				_position = assignedVehicleRole player;
				_veh = vehicle player;

				player setPosATL getPosATL player; // Will move them out of vehicle without anim
				[] call {
					if ( _position select 0 == "Driver" ) exitwith{
						player moveInDriver _veh;
					};
					if ( _position select 0 == "Cargo" ) exitwith{
						player moveInCargo _veh;
					};
					if ( _position select 0 == "Turret" ) exitwith{
						player moveInTurret [_veh, _position select 1];
					};
					if ( _position select 0 == "Commander" ) exitwith{
						player moveInCommander _veh;
					};
				};
			};
			
			['Action interrupted', 3] call BL_fnc_actionText;
			_params call _onCancel;
			"amovpknlmstpsraswrfldnon" call BL_fnc_switchMove; // Crouch
		};
	};
};