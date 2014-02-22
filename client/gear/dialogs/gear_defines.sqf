#define GEAR_idc_base 2000
#define GEAR_dialog_idc GEAR_idc_base

// Left buttons
#define GEAR_select_guns_bg_idc GEAR_idc_base + 1
#define GEAR_select_guns_idc GEAR_idc_base + 2
#define GEAR_select_launchers_bg_idc GEAR_idc_base + 3
#define GEAR_select_launchers_idc GEAR_idc_base + 4
#define GEAR_select_items_bg_idc GEAR_idc_base + 5
#define GEAR_select_items_idc GEAR_idc_base + 6
#define GEAR_select_wearables_bg_idc GEAR_idc_base + 7
#define GEAR_select_wearables_idc GEAR_idc_base + 8
#define GEAR_select_ammo_bg_idc GEAR_idc_base + 9
#define GEAR_select_ammo_idc GEAR_idc_base + 10
#define GEAR_select_attachments_bg_idc GEAR_idc_base + 11
#define GEAR_select_attachments_idc GEAR_idc_base + 12
// Lists
#define GEAR_itemslist_idc GEAR_idc_base + 13
#define GEAR_items_attachments_ammo_idc GEAR_idc_base + 14
#define GEAR_selected_inv_idc GEAR_idc_base + 15

// Gear
#define GEAR_select_uniform_bg_idc GEAR_idc_base + 16
#define GEAR_select_uniform_idc GEAR_idc_base + 17
#define GEAR_uniform_load_idc GEAR_idc_base + 18

#define GEAR_select_vest_bg_idc GEAR_idc_base + 19
#define GEAR_select_vest_idc GEAR_idc_base + 20
#define GEAR_vest_load_idc GEAR_idc_base + 21

#define GEAR_select_backpack_bg_idc GEAR_idc_base + 22
#define GEAR_select_backpack_idc GEAR_idc_base + 23
#define GEAR_backpack_load_idc GEAR_idc_base + 24

#define GEAR_primary_bg_idc GEAR_idc_base + 25
#define GEAR_primary_idc GEAR_idc_base + 26
#define GEAR_primary_muzzle_bg_idc GEAR_idc_base + 27
#define GEAR_primary_muzzle_idc GEAR_idc_base + 28
#define GEAR_primary_acc_bg_idc GEAR_idc_base + 29
#define GEAR_primary_acc_idc GEAR_idc_base + 30
#define GEAR_primary_optic_bg_idc GEAR_idc_base + 31
#define GEAR_primary_optic_idc GEAR_idc_base + 32
#define GEAR_primary_mag_bg_idc GEAR_idc_base + 33
#define GEAR_primary_mag_idc GEAR_idc_base + 34

#define GEAR_secondary_bg_idc GEAR_idc_base + 35
#define GEAR_secondary_idc GEAR_idc_base + 36
#define GEAR_secondary_muzzle_bg_idc GEAR_idc_base + 37
#define GEAR_secondary_muzzle_idc GEAR_idc_base + 38
#define GEAR_secondary_acc_bg_idc GEAR_idc_base + 39
#define GEAR_secondary_acc_idc GEAR_idc_base + 40
#define GEAR_secondary_optic_bg_idc GEAR_idc_base + 41
#define GEAR_secondary_optic_idc GEAR_idc_base + 42
#define GEAR_secondary_mag_bg_idc GEAR_idc_base + 43
#define GEAR_secondary_mag_idc GEAR_idc_base + 44

#define GEAR_pistol_bg_idc GEAR_idc_base + 45
#define GEAR_pistol_idc GEAR_idc_base + 46
#define GEAR_pistol_muzzle_bg_idc GEAR_idc_base + 47
#define GEAR_pistol_muzzle_idc GEAR_idc_base + 48
#define GEAR_pistol_acc_bg_idc GEAR_idc_base + 49
#define GEAR_pistol_acc_idc GEAR_idc_base + 50
#define GEAR_pistol_optic_bg_idc GEAR_idc_base + 51
#define GEAR_pistol_optic_idc GEAR_idc_base + 52
#define GEAR_pistol_mag_bg_idc GEAR_idc_base + 53
#define GEAR_pistol_mag_idc GEAR_idc_base + 54

#define GEAR_select_helmet_bg_idc GEAR_idc_base + 55
#define GEAR_select_helmet_idc GEAR_idc_base + 56

#define GEAR_select_glasses_bg_idc GEAR_idc_base + 57
#define GEAR_select_glasses_idc GEAR_idc_base + 58

#define GEAR_select_nvg_bg_idc GEAR_idc_base + 59
#define GEAR_select_nvg_idc GEAR_idc_base + 60

#define GEAR_select_binocular_bg_idc GEAR_idc_base + 61
#define GEAR_select_binocular_idc GEAR_idc_base + 62

// Items
#define GEAR_item_map_bg_idc GEAR_idc_base + 63
#define GEAR_item_map_idc GEAR_idc_base + 64
#define GEAR_item_gps_bg_idc GEAR_idc_base + 65
#define GEAR_item_gps_idc GEAR_idc_base + 66
#define GEAR_item_radio_bg_idc GEAR_idc_base + 67
#define GEAR_item_radio_idc GEAR_idc_base + 68
#define GEAR_item_compass_bg_idc GEAR_idc_base + 69
#define GEAR_item_compass_idc GEAR_idc_base + 70
#define GEAR_item_watch_bg_idc GEAR_idc_base + 71
#define GEAR_item_watch_idc GEAR_idc_base + 72

#define GEAR_purchase_info_idc GEAR_idc_base + 73
#define GEAR_save_loadout_idc GEAR_idc_base + 74
#define GEAR_save_preset_idc GEAR_idc_base + 75

#define GEAR_select_presets_bg_idc GEAR_idc_base + 76
#define GEAR_select_presets_idc GEAR_idc_base + 77

#define GEAR_preset_name_idc GEAR_idc_base + 78

#define GET(ARRAY, INDEX, DEFAULT) if ( count ARRAY < INDEX || { isNil { ARRAY select INDEX } } ) then { DEFAULT } else { ARRAY select INDEX }


// Images
// Guns
#define GEAR_primary_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_primary_gs.paa"
#define GEAR_muzzle_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa"
#define GEAR_acc_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa"
#define GEAR_optic_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa"
#define GEAR_mag_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa"
#define GEAR_secondary_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_secondary_gs.paa"
#define GEAR_pistol_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_hgun_gs.paa"

// Items
#define GEAR_map_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_map_gs.paa"
#define GEAR_gps_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_gps_gs.paa"
#define GEAR_radio_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_radio_gs.paa"
#define GEAR_compass_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_compass_gs.paa"
#define GEAR_watch_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_watch_gs.paa"

// Gear
#define GEAR_uniform_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_uniform_gs.paa"
#define GEAR_vest_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_vest_gs.paa"
#define GEAR_backpack_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_backpack_gs.paa"
#define GEAR_helmet_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_helmet_gs.paa"
#define GEAR_glasses_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_glasses_gs.paa"
#define GEAR_nvg_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_nvg_gs.paa"
#define GEAR_binocular_icon "\A3\Ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_binocular_gs.paa"

// Cfg types
#define GEAR_type_uniform 801
#define GEAR_type_vest 701
#define GEAR_type_backpack 901
#define GEAR_type_helmet 605
#define GEAR_type_glasses 603
#define GEAR_type_muzzle 101
#define GEAR_type_optic 201
#define GEAR_type_acc 301
#define GEAR_type_nvg 616
#define GEAR_type_binocular 4096
#define GEAR_type_map 131072
#define GEAR_type_gps 131073
#define GEAR_type_radio 131074
#define GEAR_type_compass 131075
#define GEAR_type_watch 131076
#define GEAR_type_primary 1
#define GEAR_type_pistol 2
#define GEAR_type_secondary 4

#define GEAR_index_uniform 0
#define GEAR_index_uniform_contents 1
#define GEAR_index_vest 2
#define GEAR_index_vest_contents 3
#define GEAR_index_backpack 4
#define GEAR_index_backpack_contents 5
#define GEAR_index_helmet 6
#define GEAR_index_glasses 7
#define GEAR_index_nvg 8
#define GEAR_index_binocular 9

#define GEAR_index_primary 10
#define GEAR_index_primary_muzzle 11
#define GEAR_index_primary_acc 12
#define GEAR_index_primary_optic 13
#define GEAR_index_primary_mag 14

#define GEAR_index_secondary 15
#define GEAR_index_secondary_muzzle 16
#define GEAR_index_secondary_acc 17
#define GEAR_index_secondary_optic 18
#define GEAR_index_secondary_mag 19

#define GEAR_index_pistol 20
#define GEAR_index_pistol_muzzle 21
#define GEAR_index_pistol_acc 22
#define GEAR_index_pistol_optic 23
#define GEAR_index_pistol_mag 24

#define GEAR_index_map 25
#define GEAR_index_gps 26
#define GEAR_index_radio 27
#define GEAR_index_compass 28
#define GEAR_index_watch 29
