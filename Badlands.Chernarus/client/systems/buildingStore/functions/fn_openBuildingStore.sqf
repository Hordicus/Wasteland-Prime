buildingStoreLoadingArea = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;

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
			<t font='Zeppelin33'>Size:</t> %3<br />
			<br />
			<br />
			<img image='#(argb,256,256,1)r2t(rendertarget45,1.0)' size='13'/>
		", _item select 0, _item select 2, (_item select 1) call LOG_fnc_objectSize];
	},
	
	{
		(_this select 2) ctrlEnable true;
		_container = [buildingStoreLoadingArea] call BL_fnc_findContainerInArea;
		
		{
			if ( _x call LOG_fnc_containerSize > 0 ) exitwith {
				_container = _x;
			};
		} forEach (nearestObjects [buildingStoreLoadingArea, ["All"], 5]);
		
		if ( isNull _container ) then {
			_purchaseTotal = 0;
			{
				_purchaseTotal = _purchaseTotal + (_x select 2);
			} forEach (_this select 0);
		
			(_this select 1) ctrlSetStructuredText parseText format["
				<br />
				No container found in the loading<br />
				area. You will only be able to<br />
				purchase one item at a time.<br />
				<br />
				<t font='Zeppelin33'>Money:</t> $%1<br />
				<t font='Zeppelin33'>Purchase Total:</t> $%2<br />
			",
				0,
				_purchaseTotal
			];
			
			if ( count (_this select 0) > 1 ) then {
				(_this select 2) ctrlEnable false;
			};
		}
		else {
			_containerSize = _container call LOG_fnc_containerSize;
			_roomUsed = _container call LOG_fnc_roomUsed;
			
			_cartSize = 0;
			_purchaseTotal = 0;
			{
				_cartSize = _cartSize + ((_x select 1) call LOG_fnc_objectSize);
				_purchaseTotal = _purchaseTotal + (_x select 2);
			} forEach (_this select 0);
		
			(_this select 1) ctrlSetStructuredText parseText format["
				<br />
				<t font='Zeppelin33'>Container Size:</t> %1<br />
				<t font='Zeppelin33'>Container Room Used:</t> %2<br />
				<br />
				<t font='Zeppelin33'>Cart Item(s) Size:</t> %3<br />
				<t font='Zeppelin33'>Room left:</t> %4<br />
				<br />
				<t font='Zeppelin33'>Money:</t> $%5<br />
				<t font='Zeppelin33'>Purchase Total:</t> $%6<br />
			",
				_containerSize,
				_roomUsed,
				_cartSize,
				_containerSize - _roomUsed - _cartSize,
				0,
				_purchaseTotal
			];
			
			if ( _containerSize - _roomUsed - _cartSize < 0 ) then {
				(_this select 2) ctrlEnable false;
			};
		};
	},
	
	{
		_container = [buildingStoreLoadingArea] call BL_fnc_findContainerInArea;
		_cartClasses = [];
		_purchaseTotal = 0;
		
		{
			_cartClasses set [_forEachIndex, _x select 1];
			_purchaseTotal = _purchaseTotal + (_x select 2);
		} forEach (_this select 0);
		
		if ( !isNull _container ) then {
			[_cartClasses, _container] call LOG_fnc_loadInObject;
		}
		else {
			// TODO: Create obj on server
			createVehicle [(_cartClasses select 0), buildingStoreLoadingArea, [], 0, "CAN_COLLIDE"];
		};
	}
] call BL_Store_fnc_showStore;
