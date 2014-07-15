private ['_vehicles'];
_vehicles = [];

// Show mortar shells
{
	(_this select 0) drawIcon [
		MISSION_ROOT + "client\systems\hud\icons\mortar.paa",
		[1,1,1,1],
		getPosATL _x,
		35,
		35,
		0,
		""
	];
	
	nil
} count (allMissionObjects "Sh_82mm_AMOS");

{
	if ( _x in (units group player) || (playerSide in [east,west] && side player == side _x) ) then {
		if ( vehicle _x != _x ) then {
			if !((vehicle _x) in _vehicles) then {
				_vehicles set [count _vehicles, vehicle _x];
			};
		}
		else {
			if ( _x == player ) then {
				_this select 0 drawIcon [
					getText (configFile >> "CfgInGameUI" >> "IslandMap" >> "IconPlayer"),
					getArray (configFile >> "CfgInGameUI" >> "IslandMap" >> "meCircle" >> "color"),
					getPosATL _x,
					24,
					24,
					0,
					"",
					0,
					0.03,
					"PuristaMedium",
					"left"
				];
			};

			_this select 0 drawIcon [
				getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"),
				sideColor,
				getPosATL _x,
				24,
				24,
				getDir _x,
				(if( mapCursorTarget == _x ) then { name mapCursorTarget } else {""}),
				0,
				0.03,
				"PuristaMedium",
				"left"
			];
		};
	};
	true
} count (playableUnits + allUnitsUAV);

{
	_this select 0 drawIcon [
		getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"),
		sideColor,
		getPosATL _x,
		24,
		24,
		getDir _x,
		(if( mapCursorTarget == _x ) then {
			_crew = [];
			{
				_crew set [_forEachIndex, name _x];
			} forEach (crew mapCursorTarget);
			[_crew, ', '] call CBA_fnc_join
		} else {""}),
		0,
		0.03,
		"PuristaMedium",
		"left"
	];
	true
} count _vehicles;