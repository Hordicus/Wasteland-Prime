#include "macro.sqf"

private ['_img'];
_img = "";

switch(_this) do {
	case (GEAR_select_uniform_idc): { _img = GEAR_uniform_icon; };
	case (GEAR_select_vest_idc): { _img = GEAR_vest_icon; };
	case (GEAR_select_backpack_idc): { _img = GEAR_backpack_icon; };
	case (GEAR_select_helmet_idc): { _img = GEAR_helmet_icon; };
	case (GEAR_select_glasses_idc): { _img = GEAR_glasses_icon; };
	case (GEAR_select_nvg_idc): { _img = GEAR_nvg_icon; };
	case (GEAR_select_binocular_idc): { _img = GEAR_binocular_icon; };
	
	case (GEAR_primary_idc): { _img = GEAR_primary_icon; };
	case (GEAR_secondary_idc): { _img = GEAR_secondary_icon; };
	case (GEAR_pistol_idc): { _img = GEAR_pistol_icon; };
	
	case (GEAR_primary_muzzle_idc);
	case (GEAR_secondary_muzzle_idc);
	case (GEAR_pistol_muzzle_idc): { _img = GEAR_muzzle_icon; };

	case (GEAR_primary_acc_idc);
	case (GEAR_secondary_acc_idc);
	case (GEAR_pistol_acc_idc): { _img = GEAR_acc_icon; };

	case (GEAR_primary_optic_idc);
	case (GEAR_secondary_optic_idc);
	case (GEAR_pistol_optic_idc): { _img = GEAR_optic_icon; };

	case (GEAR_primary_mag_idc);
	case (GEAR_secondary_mag_idc);
	case (GEAR_pistol_mag_idc): { _img = GEAR_mag_icon; };
	
	case (GEAR_item_map_idc): { _img = GEAR_map_icon; };
	case (GEAR_item_gps_idc): { _img = GEAR_gps_icon; };
	case (GEAR_item_radio_idc): { _img = GEAR_radio_icon; };
	case (GEAR_item_compass_idc): { _img = GEAR_compass_icon; };
	case (GEAR_item_watch_idc): { _img = GEAR_watch_icon; };
};

_img