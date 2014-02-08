#include "dialogs\gear_defines.sqf"
disableSerialization;

_target       = ctrlIDC (_this select 0);
_dropped      = _this select 4 select 0;
_class        = _dropped select 2;
_type         = _class call GEAR_getType;
_allowedSlots = _class call GEAR_allowedSlots;
_valid        = false;

_idcs = [
	GEAR_select_uniform_idc, GEAR_select_vest_idc, GEAR_select_helmet_idc, GEAR_select_glasses_idc, GEAR_select_nvg_idc, GEAR_select_binocular_idc,
	GEAR_item_map_idc, GEAR_item_gps_idc, GEAR_item_radio_idc, GEAR_item_compass_idc, GEAR_item_watch_idc, GEAR_primary_idc,
	GEAR_secondary_idc, GEAR_pistol_idc
];

_types = [
	GEAR_type_uniform, GEAR_type_vest, GEAR_type_helmet, GEAR_type_glasses, GEAR_type_nvg, GEAR_type_binocular,
	GEAR_type_map, GEAR_type_gps, GEAR_type_radio, GEAR_type_compass, GEAR_type_watch, GEAR_type_primary,
	GEAR_type_launcher, GEAR_type_pistol
];

_target_type = _types select (_idcs find _target);
_valid = _type == _target_type;


if ( _valid ) then {
	_img = _class call GEAR_itemImg;
	(_this select 0) ctrlSetText _img;
};