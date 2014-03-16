#include "macro.sqf"

private ['_idc'];
_idc = -1;

switch(_this) do {
	case GEAR_index_uniform: { _idc = GEAR_select_uniform_idc; };
	case GEAR_index_vest: { _idc = GEAR_select_vest_idc; };
	case GEAR_index_backpack: { _idc = GEAR_select_backpack_idc; };
	case GEAR_index_helmet: { _idc = GEAR_select_helmet_idc; };
	case GEAR_index_glasses: { _idc = GEAR_select_glasses_idc; };
	case GEAR_index_nvg: { _idc = GEAR_select_nvg_idc; };
	case GEAR_index_binocular: { _idc = GEAR_select_binocular_idc; };
	
	case GEAR_index_primary: { _idc = GEAR_primary_idc; };
	case GEAR_index_primary_muzzle: { _idc = GEAR_primary_muzzle_idc; };
	case GEAR_index_primary_acc: { _idc = GEAR_primary_acc_idc; };
	case GEAR_index_primary_optic: { _idc = GEAR_primary_optic_idc; };
	case GEAR_index_primary_mag: { _idc = GEAR_primary_mag_idc; };
	
	case GEAR_index_secondary: { _idc = GEAR_secondary_idc; };
	case GEAR_index_secondary_muzzle: { _idc = GEAR_secondary_muzzle_idc; };
	case GEAR_index_secondary_acc: { _idc = GEAR_secondary_acc_idc; };
	case GEAR_index_secondary_optic: { _idc = GEAR_secondary_optic_idc; };
	case GEAR_index_secondary_mag: { _idc = GEAR_secondary_mag_idc; };
	
	case GEAR_index_pistol: { _idc = GEAR_pistol_idc; };
	case GEAR_index_pistol_muzzle: { _idc = GEAR_pistol_muzzle_idc; };
	case GEAR_index_pistol_acc: { _idc = GEAR_pistol_acc_idc; };
	case GEAR_index_pistol_optic: { _idc = GEAR_pistol_optic_idc; };
	case GEAR_index_pistol_mag: { _idc = GEAR_pistol_mag_idc; };
	
	case GEAR_index_map: { _idc = GEAR_item_map_idc; };
	case GEAR_index_gps: { _idc = GEAR_item_gps_idc; };
	case GEAR_index_radio: { _idc = GEAR_item_radio_idc; };
	case GEAR_index_compass: { _idc = GEAR_item_compass_idc; };
	case GEAR_index_watch: { _idc = GEAR_item_watch_idc; };
};

_idc