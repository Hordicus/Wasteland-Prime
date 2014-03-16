#include "macro.sqf"

private ['_index'];
_index = -1;

switch(_this) do {
	case (GEAR_select_uniform_idc): {_index = GEAR_index_uniform; };
	case (GEAR_select_vest_idc): {_index = GEAR_index_vest; };
	case (GEAR_select_backpack_idc): {_index = GEAR_index_backpack; };
	case (GEAR_select_helmet_idc): {_index = GEAR_index_helmet; };
	case (GEAR_select_glasses_idc): {_index = GEAR_index_glasses; };
	case (GEAR_select_nvg_idc): {_index = GEAR_index_nvg; };
	case (GEAR_select_binocular_idc): {_index = GEAR_index_binocular; };
	
	case (GEAR_primary_idc): {_index = GEAR_index_primary; };
	case (GEAR_primary_muzzle_idc): {_index = GEAR_index_primary_muzzle; };
	case (GEAR_primary_acc_idc): {_index = GEAR_index_primary_acc; };
	case (GEAR_primary_optic_idc): {_index = GEAR_index_primary_optic; };
	case (GEAR_primary_mag_idc): {_index = GEAR_index_primary_mag; };
	
	case (GEAR_secondary_idc): {_index = GEAR_index_secondary; };
	case (GEAR_secondary_muzzle_idc): {_index = GEAR_index_secondary_muzzle; };
	case (GEAR_secondary_acc_idc): {_index = GEAR_index_secondary_acc; };
	case (GEAR_secondary_optic_idc): {_index = GEAR_index_secondary_optic; };
	case (GEAR_secondary_mag_idc): {_index = GEAR_index_secondary_mag; };
	
	case (GEAR_pistol_idc): {_index = GEAR_index_pistol; };
	case (GEAR_pistol_muzzle_idc): {_index = GEAR_index_pistol_muzzle; };
	case (GEAR_pistol_acc_idc): {_index = GEAR_index_pistol_acc; };
	case (GEAR_pistol_optic_idc): {_index = GEAR_index_pistol_optic; };
	case (GEAR_pistol_mag_idc): {_index = GEAR_index_pistol_mag; };
	
	case (GEAR_item_map_idc): {_index = GEAR_index_map; };
	case (GEAR_item_gps_idc): {_index = GEAR_index_gps; };
	case (GEAR_item_radio_idc): {_index = GEAR_index_radio; };
	case (GEAR_item_compass_idc): {_index = GEAR_index_compass; };
	case (GEAR_item_watch_idc): {_index = GEAR_index_watch; };
};

_index