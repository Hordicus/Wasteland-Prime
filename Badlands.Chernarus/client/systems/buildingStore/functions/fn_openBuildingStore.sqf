_buildingStore = [
	["Concrete", [
		["", "Land_CncBarrier_F", 100],
		["", "Land_CncWall1_F", 100],
		["", "BlockConcrete_F", 100],
		["", "Land_RampConcrete_F", 100],
		["", "Land_RampConcreteHigh_F", 100]
	]],
	["Sandbags", [
		["", "Land_BagBunker_Small_F", 100],
		["", "Land_BagFence_Long_F", 100],
		["", "Land_BagFence_Round_F", 100]
	]]
];

// Set names for building store items
{
	{
		_x set [0, getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")];
	} forEach (_x select 1);
} forEach _buildingStore;

[
	"Building Store", // Title
	_buildingStore,
	{
		if ( !isNil "buildingStoreCam" ) then {
			(buildingStoreCam select 0) cameraEffect ["TERMINATE", "BACK"];
			camDestroy (buildingStoreCam select 0);
			deleteVehicle (buildingStoreCam select 1);
			deleteVehicle (buildingStoreCam select 2);
		};
		
		_item = _this select 1;
		buildingStoreCam = [_item select 1, "rendertarget45"] call BL_fnc_createObjectCam;
		
		(_this select 2) ctrlSetStructuredText parseText format["
			<br />
			<t size='1.2'>%1</t><br />
			<br />
			<t font='Zeppelin33'>Price:</t> %2<br />
			<br />
			<br />
			<br />
			<img image='#(argb,256,256,1)r2t(rendertarget45,1.0)' size='13'/>
		", _item select 0, _item select 2];
	},
	
	{

	},
	
	{
		// Give player item
	}
] call BL_Store_fnc_showStore;
