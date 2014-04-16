private ['_config'];
_config = [] call CBA_fnc_hashCreate;

/*
Store creation file, Action text, Action, [
	// locations
	// [loc, dir, radarSize],
]
*/

[_config, 'generalStore', ['General Store', {[] call BL_fnc_openGeneralStore}, [
	[[6016.13,7814.4,0.0171509], 45], // Stary
	[[2585.12,5063.25,0.0602875], 155], // Zeleno
	[[10426.5,2365.59,0.0646248], 60], // Elektro
	[[11247.1,12209.3,0.063446], 215], // Krasno
	[[10637.9,8022.46,0.061554], 309] // Polana
]]] call CBA_fnc_hashSet;

[_config, 'buildingStore', ['Building Store', { [getPosATL ((getPosATL player) nearestObject 'Land_JumpTarget_F')] call BL_fnc_openBuildingStore }, [
	[[5801.53,6915.45,0.0015564], 228, 100],
	[[2808.37,2316.3,0.0014801], 30, 100],
	[[2241.56,8106.97,0.00140381], 40, 100],
	[[9660.1,11721.6,0.00125122], 15, 100],
	[[13129.3,6923.98,0.00167656], 343, 100]
]]] call CBA_fnc_hashSet;

_config