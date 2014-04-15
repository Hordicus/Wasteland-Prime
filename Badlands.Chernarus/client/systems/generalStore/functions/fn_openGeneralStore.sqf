/*
	Description:
	Opens the general store dialog.
	
	Parameter(s):
	None
	
	Returns:
	None
*/

private ['_generalStore'];
_generalStore = 'generalStore' call BL_fnc_config;

[
	"General Store", // Title
	_generalStore,
	
	// Show item info
	{
		private ['_item'];
		_item = _this select 1;
		(_this select 2) ctrlSetStructuredText parseText format ["
			<br />
			<t size='1.2'>%1</t><br />
			<t font='PuristaMedium'>Price:</t> $%2<br />
			<br />
			%3
		", _item select 0, _item select 1, _item select 2];
	},
	
	// Cart update
	{
		private ["_cartItems","_cartInfo","_purchaseBtn","_cartTotal","_money"];
		_cartItems = _this select 0;
		_cartInfo = _this select 1;
		_purchaseBtn = _this select 2;
		
		_cartTotal = 0;
		_money = 0;
		
		{
			_cartTotal = _cartTotal + (_x select 1);
		} forEach _cartItems;
		
		_cartInfo ctrlSetStructuredText parseText format ["
			<br />
			<t font='PuristaMedium'>Money:</t> $%1<br />
			<t font='PuristaMedium'>Total:</t> $%2<br />
		", _money, _cartTotal];
		
		if ( /*_money >= _cartTotal &&*/ count _cartItems > 0) then {
			_purchaseBtn ctrlEnable true;
		}
		else {
			_purchaseBtn ctrlEnable false;
		};
	},
	
	// Purchase
	{
		private ["_cartItems","_cartTotal"];
		_cartItems = _this select 0;		
		_cartTotal = 0;
		
		{
			_cartTotal = _cartTotal + (_x select 1);
			[] call (_x select 3);
		} forEach _cartItems;
		
		// Take money
	}
] call BL_fnc_showStore;