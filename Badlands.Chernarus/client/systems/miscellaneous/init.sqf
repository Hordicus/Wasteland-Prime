if ( !hasInterface ) exitwith{};
[] spawn {
	waitUntil {!isNull player && player == player};
	waitUntil{!isNil "BIS_fnc_init"};
	waitUntil {!(isNull (findDisplay 46))};

	
	execVM 'client\systems\miscellaneous\saveBeforeAbort.sqf';
	//execVM 'client\systems\miscellaneous\noThermals.sqf';
	execVM 'client\systems\miscellaneous\noFriendlyFire.sqf';
	execVM 'client\systems\miscellaneous\playerSaveLoop.sqf';
	execVM 'client\systems\miscellaneous\jump.sqf';
	execVM 'client\systems\miscellaneous\monitorVON.sqf';
	execVM 'client\systems\miscellaneous\mapMarkerTitling.sqf';
	execVM 'client\systems\miscellaneous\extendedParachuteOptions.sqf';
	execVM 'client\systems\miscellaneous\safezones.sqf';
	execVM 'client\systems\miscellaneous\protect.sqf';
	execVM 'client\systems\miscellaneous\playArea.sqf';
};