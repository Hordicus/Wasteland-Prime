if ( !isNil "BL_animDoWorkInProgress" && { BL_animDoWorkInProgress } ) exitwith {
	hint 'Please wait until the current action is finished';
};

BL_animDoWorkInProgress = true;
_this spawn {
	private ["_validAnimations","_step","_time","_minTime","_healingTarget","_action","_itemName","_eh"];
	_validAnimations = ["ainvpknlmstpsnonwrfldnon_ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic","ainvpknlmstpsnonwrfldnon_medic0s"];
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
	
	BL_animDoWorkAnimLoop = [] spawn {
		while { BL_animDoWorkInProgress } do {
			player switchMove "ainvpknlmstpslaywrfldnon_medic";
			waitUntil {animationState player != "ainvpknlmstpslaywrfldnon_medic"};
		};
	};
	
	BL_animDoWorkKeyDown = (findDisplay 46) displayAddEventHandler ['KeyDown', {
		if ( (_this select 1) in ((actionKeys 'MoveForward') + (actionKeys 'TurnLeft') + (actionKeys 'TurnRight') + (actionKeys 'MoveBack')) ) then {
			terminate BL_animDoWorkAnimLoop;
		};
	}];
	
	while { damage _healingTarget > 0 && !scriptDone BL_animDoWorkAnimLoop && alive player && vehicle player == player && player distance _healingTarget < 5 && alive _healingTarget} do {
		format['%1 %2 %3%4', _action, _itemName, round((1-damage _healingTarget)*100), '%'] call BL_fnc_actionText;
		sleep (_minTime max ((_time * (1-damage _healingTarget))));
		_healingTarget setDamage ((damage _healingTarget) - _step);
	};

	BL_animDoWorkInProgress = false;
	(findDisplay 46) displayRemoveEventHandler ['KeyDown', BL_animDoWorkKeyDown];
	
	if ( !scriptDone BL_animDoWorkAnimLoop && alive player && vehicle player == player && player distance _healingTarget < 5 && alive _healingTarget) then {
		[format['%1 %2 100%3', _action, _itemName, '%'], 3] call BL_fnc_actionText;
		player switchMove "amovpknlmstpsraswrfldnon"; // Crouch
	}
	else {
		[] call {
			if ( !alive player ) exitwith {
				['', 0] call BL_fnc_actionText;
			};
			
			if ( vehicle player != player ) exitwith {
				['Action interrupted', 3] call BL_fnc_actionText;
				
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
			player switchMove "amovpknlmstpsraswrfldnon"; // Crouch
		};
	};
};