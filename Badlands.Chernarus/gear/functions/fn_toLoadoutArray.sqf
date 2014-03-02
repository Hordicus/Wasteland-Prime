#include "macro.sqf"
/*
 Target output:
 [
	 ["Items"],
	 "primaryWeapon", ["muzzle", "acc", "optic"],
	 "handgun", ["muzzle", "acc", "optic"],
	 "secondary", ["muzzle", "acc", "optic"],
	 "Uniform", ["Uniform Contents"],
	 "Vest", ["Vest contents"],
	 "Backpack", ["Backpack contents"],
	 
	 // Loaded magazines
	 [["PrimaryMag"], ["hgunMag"], ["secondaryMag"], ["batteries"]],
	 
	 // Optional
	 "selectedWeapon",
	 "fireMode"
*/

_loadout = _this;
_output  = [];

_get_item = {
	private ['_class'];
	_class = "";
	
	// Indexes that should return an array not a string
	if ( _this in [GEAR_index_uniform_contents, GEAR_index_vest_contents, GEAR_index_backpack_contents] ) then {
		_class = [];
	};
	
	if ( count GEAR_activeLoadout > _this && { !isNil { GEAR_activeLoadout select _this } }) then {
		_class = GEAR_activeLoadout select _this;
	};
	
	_class
};

// Items
_items = [];
{
	_class = _x call _get_item;
	if ( _class != "" ) then {
		_items set [count _items, _class];
	};
} count [ GEAR_index_helmet, GEAR_index_glasses, GEAR_index_nvg, GEAR_index_binocular, GEAR_index_map, GEAR_index_gps, GEAR_index_radio, GEAR_index_compass, GEAR_index_watch ];

_output set [0, _items];

// Weapons
{
	_from = _x select 0;
	_to   = _x select 1;
	
	_weapon = _from call _get_item;
	_attachments = [ (_from + 1) call _get_item, (_from + 2) call _get_item, (_from + 3) call _get_item ];
	
	_output set [_to, _weapon];
	_output set [_to+1, _attachments];
} count [[GEAR_index_primary, 1], [GEAR_index_pistol, 3], [GEAR_index_secondary, 5]];

_output set [7, GEAR_index_uniform call _get_item];
_output set [8, GEAR_index_uniform_contents call _get_item];

_output set [9, GEAR_index_vest call _get_item];
_output set [10, GEAR_index_vest_contents call _get_item];

_output set [11, GEAR_index_backpack call _get_item];
_output set [12, GEAR_index_backpack_contents call _get_item];

_output set [13, [
	[GEAR_index_primary_mag call _get_item],
	[GEAR_index_pistol_mag call _get_item],
	[GEAR_index_secondary_mag call _get_item],
	[""]
]];

_output