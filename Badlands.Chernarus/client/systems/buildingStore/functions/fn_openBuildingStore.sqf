/*
	Description:
	Opens the building store dialog.
	
	Parameter(s):
	_loadingArea - Where to look for containers and spawn objects
	
	Returns:
	None
*/

private ['_buildingStore', '_dialog'];
buildingStoreLoadingArea = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;
_buildingStore = 'buildingStore' call BL_fnc_config;

// Set names for building store items
{
	{
		if ( _x select 0 == "" ) then {
			_x set [0, getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")];
		};
		true
	} count (_x select 1);
	true
} count _buildingStore;

_dialog = [
	"Building Store", // Title
	_buildingStore,
	
	// Show item info
	{		
		private ['_item'];
		_item = _this select 1;
		[_item select 1, "rendertarget45"] call LOG_fnc_createObjectCam;
		
		(_this select 2) ctrlSetStructuredText parseText format["
			<br />
			<t size='1.2'>%1</t><br />
			<br />
			<t font='PuristaMedium'>Price:</t> %2<br />
			<t font='PuristaMedium'>Size:</t> %3<br />
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
				<t font='PuristaMedium'>Money:</t> $%1<br />
				<t font='PuristaMedium'>Purchase Total:</t> $%2<br />
			",
				[] call BL_fnc_money,
				_purchaseTotal
			];
			
			if ( count (_this select 0) == 1 && ([] call BL_fnc_money) >= _purchaseTotal ) then {
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
				<t font='PuristaMedium'>Container Size:</t> %1<br />
				<t font='PuristaMedium'>Container Room Used:</t> %2<br />
				<br />
				<t font='PuristaMedium'>Cart Item(s) Size:</t> %3<br />
				<t font='PuristaMedium'>Room left:</t> %4<br />
				<br />
				<t font='PuristaMedium'>Money:</t> $%5<br />
				<t font='PuristaMedium'>Purchase Total:</t> $%6<br />
			",
				_containerSize,
				_roomUsed,
				_cartSize,
				_containerSize - _roomUsed - _cartSize,
				[] call BL_fnc_money,
				_purchaseTotal
			];
			
			if ( _containerSize - _roomUsed - _cartSize >= 0 && count _cartItems > 0 && ([] call BL_fnc_money) >= _purchaseTotal) then {
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
			[_cartClasses select 0, buildingStoreLoadingArea, "basePart"] call BL_fnc_createVehicle;
		};
		
		_purchaseTotal call BL_fnc_subMoney;
	}
] call BL_fnc_showStore;

(ctrlIDD _dialog) spawn {
	// Destroy object cam when dialog is closed
	waitUntil { isNull findDisplay _this };
	[] call LOG_fnc_destroyObjectCam;
};