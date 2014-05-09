/*
	File: fn_halo.sqf
	Version: 2.1
	
	Author(s): cobra4v320 - effects adapted from old halo.sqs, sounds from freesound.org
	
	Description: HALO jumping (works with AI soldiers). Set the altitude of the HALO, add a chemlight,
	auto open your parachute at 150m, and save your backpack with its contents, then attach a backpack
	to the front of your unit.
	
	Parameters:
	0: UNIT - (object) the unit that will be doing the HALO
	1: (optional) ALTITUDE  - (number) the altitude where the HALO will start from
	2: (optional) CHEMLIGHT - (boolean) true if the units will use chemlights
	3: (optional) AUTOOPEN -(boolean) true to auto open parachute at 150m
	4: (optional) SAVELOADOUT - (boolean) true to save backpack and its contents, and add a "fake" backpack to the front of the unit.

	Example(s):
	[this] call COB_fnc_HALO
	[this, 4000, true, true, true] call COB_fnc_HALO
*/

//Parameters
private ["_unit","_altitude","_chemLight","_autoOpen","_saveLoadOut"]; 
_unit 		 = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_altitude 	 = [_this, 1, 3000, [3000]] call BIS_fnc_param;
_chemLight	 = [_this, 2, false, [false]] call BIS_fnc_param;
_autoOpen 	 = [_this, 3, false, [false]] call BIS_fnc_param;
_saveLoadOut = [_this, 4, true, [true]] call BIS_fnc_param;

//Validate parameters
if (isNull _unit) exitWith {"Unit parameter must not be objNull. Accepted: OBJECT" call BIS_fnc_error};

//add a chemlight to helmet
if (_chemLight) then {
	[_chemLight,_unit] spawn {
		private ["_chemlight","_unit","_light"];
		_chemLight = _this select 0;
		_unit	   = _this select 1;
		
		_light = "chemlight_red" createVehicle [0,0,0]; //create the chemlight
		if (headgear _unit != "") then {
			_light attachTo [_unit,[-0.07,0.1,0.25],"head"]; //attach light to helmet
			_light setVectorDirAndUp [[0,1,-1],[0,1,0.6]]; //set vector dir and up
		} else {
			_light attachTo [_unit,[0,-0.07,0.06],"LeftShoulder"];
		};
		
		waitUntil {animationState _unit == "para_pilot"};
		
		if (headgear _unit != "") then {
			_light attachTo [vehicle _unit,[0,0.14,0.84],"head"]; 
			_light setVectorDirAndUp [[0,1,-1],[0,1,0.6]];
		} else {
			_light attachTo [vehicle _unit,[-0.13,-0.09,0.56],"LeftShoulder"];  
			_light setVectorDirAndUp [[0,0,1],[0,1,0]];
		};
		
		waitUntil {isTouchingGround _unit || (getPosATL _unit select 2) < 1};
		detach _light;
		deleteVehicle _light; //delete the chemlight
	};
};

//save the backpack and its contents, also adds fake pack to front of unit
if (_saveLoadOut && !isNull (unitBackpack _unit) && (backpack _unit) != "b_parachute") then {
	private ["_pack","_class","_magazines","_weapons","_items","_helmet"];
	_pack	   = unitBackpack _unit;
	_class	   = typeOf _pack;
	_magazines = getMagazineCargo _pack;
	_weapons   = getWeaponCargo _pack;
	_items	   = getItemCargo _pack;
	_helmet	   = headgear _unit;
 
	removeBackpack _unit; //remove the backpack
	_unit addBackpack "b_parachute"; //add the parachute

	[_unit,_class,_magazines,_weapons,_items,_helmet,_altitude] spawn {
		private ["_unit","_class","_magazines","_weapons","_items","_helmet","_altitude"];
		_unit		= _this select 0;
		_class		= _this select 1;
		_magazines	= _this select 2;
		_weapons 	= _this select 3;
		_items 		= _this select 4;
		_helmet		= _this select 5;
		_altitude   = _this select 6;
		
		private "_packHolder";
		_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"];
		_packHolder addBackpackCargoGlobal [_class, 1];
				
		waitUntil {animationState _unit == "HaloFreeFall_non"};
		_packHolder attachTo [_unit,[-0.12,-0.02,-.74],"pelvis"]; 
		_packHolder setVectorDirAndUp [[0,-1,-0.05],[0,0,-1]];
				
		waitUntil {animationState _unit == "para_pilot"};
		_packHolder attachTo [vehicle _unit,[-0.07,0.67,-0.13],"pelvis"]; 
		_packHolder setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
				
		waitUntil {isTouchingGround _unit || (getPosATL _unit select 2) < 1};
		detach _packHolder;
		deleteVehicle _packHolder; //delete the backpack in front
			
		_unit addBackpack _class; //return the backpack
		clearAllItemsFromBackpack _unit; //clear all gear from new backpack
		if (_altitude > 3040 && _helmet != "" && _helmet != "H_CrewHelmetHeli_B") then {(unitBackpack _unit) addItemCargoGlobal [_helmet, 1]}; //(not complete) do a check to see if there is available space

		for "_i" from 0 to (count (_magazines select 0) - 1) do {
			(unitBackpack _unit) addMagazineCargoGlobal [(_magazines select 0) select _i,(_magazines select 1) select _i]; //return the magazines
		};
		for "_i" from 0 to (count (_weapons select 0) - 1) do {
			(unitBackpack _unit) addWeaponCargoGlobal [(_weapons select 0) select _i,(_weapons select 1) select _i]; //return the weapons
		};
		for "_i" from 0 to (count (_items select 0) - 1) do {
			(unitBackpack _unit) addItemCargoGlobal [(_items select 0) select _i,(_items select 1) select _i]; //return the items
		};
	};
} else {
	if ((backpack _unit) != "b_parachute") then {_unit addBackpack "B_parachute"}; //add the parachute if unit has no backpack
};

_unit setPosATL [(getPosATL _unit select 0), (getPosATL _unit select 1), _altitude]; //Set the altitude of the HALO jump

if (!isPlayer _unit) then {
	_unit switchMove "HaloFreeFall_non"; //place the AI into the free fall animation
	_unit disableAI "ANIM"; //disable the AI animation so they cant switch back to standing
	
	_unit setVariable ['HandleDamageEH', _unit addEventHandler ['HandleDamage', {
		if ( !isPlayer (_this select 3)) then {
			0
		};
	}]];

	_unit spawn {
		waitUntil { (vehicle _this) != _this };
		(vehicle _this) allowDamage false;
		
		waitUntil { (getPosATL _this) select 2 < 5 };
		_this allowDamage false;
		
		waitUntil {isTouchingGround _this};
		_this allowDamage true;
		_this removeEventHandler ['HandleDamage', _this getVariable 'HandleDamageEH'];
	};	
};

[_unit] spawn {
	private "_unit";
	_unit = _this select 0;
			
	waitUntil {isTouchingGround _unit || (getPosATL _unit select 2) < 1 && alive _unit};

	if (!isPlayer _unit) then {
		_unit enableAI "ANIM";  //enable the animations
		_unit setPosATL [(getPosATL _unit select 0), (getPosATL _unit select 1), 0]; //this removes the unit from the parachute
		_unit setVelocity [0,0,0]; //set speed to zero
		_unit setVectorUp [0,0,1]; //set the unit upright
		sleep 1;
		_unit allowDamage TRUE; //allow unit to be damaged again
	};
};

//Return Value
_unit;