/*
	Description:
	Opens the building store dialog.
	
	Parameter(s):
	_loadingArea - Where to look for containers and spawn objects
	
	Returns:
	None
*/

private ['_buildingStore', '_dialog'];
disableSerialization;
buildingStoreLoadingArea = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;
_buildingStore = 'buildingStore' call BL_fnc_config;

// Set names for building store items
{
	{
		_x set [0, getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")];
	} forEach (_x select 1);
} forEach _buildingStore;

_dialog = [
	"Building Store", // Title
	_buildingStore,
	
	// Show item info
	{
		if ( !isNil "buildingStoreCam" ) then {
			(buildingStoreCam select 0) cameraEffect ["TERMINATE", "BACK"];
			camDestroy (buildingStoreCam select 0);
			deleteVehicle (buildingStoreCam select 1);
			deleteVehicle (buildingStoreCam select 2);
		};
		
		private ['_item'];
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
	
	// Cart update
	{
		private ["_cartItems","_cartInfo","_purchaseBtn","_container","_purchaseTotal","_containerSize","_roomUsed","_cartSize"];
		_cartItems = _this select 0;
		_cartInfo = _this select 1;
		_purchaseBtn = _this select 2;
		
		_purchaseBtn ctrlEnable false;
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
			} forEach _cartItems;
		
			_cartInfo ctrlSetStructuredText parseText format["
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
			
			if ( count (_this select 0) == 1 ) then {
				_purchaseBtn ctrlEnable true;
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
			} forEach _cartItems;
		
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
			
			if ( _containerSize - _roomUsed - _cartSize >= 0 && count _cartItems > 0) then {
				_purchaseBtn ctrlEnable true;
			};
		};
	},
	
	// Purchase
	{
		private ["_container","_cartClasses","_purchaseTotal"];
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

_dialog spawn {
	// Destroy object cam when dialog is closed
	waitUntil { isNull _this };
	
	if ( !isNil "buildingStoreCam" ) then {
		(buildingStoreCam select 0) cameraEffect ["TERMINATE", "BACK"];
		camDestroy (buildingStoreCam select 0);
		deleteVehicle (buildingStoreCam select 1);
		deleteVehicle (buildingStoreCam select 2);
	};
};