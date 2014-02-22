_config = [] call CBA_fnc_hashCreate;

[_config, "guns", [
	["hgun_PDW2000_F", 100],
	["arifle_TRG20_F", 100],
	["arifle_Mk20_F", 100],
	["arifle_Mk20_F", 100],
	["arifle_Mk20C_F", 100],
	["arifle_Mk20_plain_F", 100],
	["SMG_02_F", 100],
	["SMG_01_F", 100],
	["arifle_SDAR_F", 100],
	["arifle_Mk20_GL_F", 100],
	["srifle_GM6_F", 100],
	["arifle_Katiba_F", 100],
	["arifle_Katiba_GL_F", 100],
	["arifle_Katiba_C_F", 100],
	["srifle_LRR_F", 100],
	["srifle_EBR_F", 100],
	["LMG_Mk200_F", 100],
	["arifle_MX_F", 100],
	["arifle_MX_GL_F", 100],
	["arifle_MX_GL_Black_F", 100],
	["arifle_MX_Black_F", 100],
	["arifle_MX_SW_F", 100],
	["arifle_MX_SW_Black_F", 100],
	["arifle_MXC_F", 100],
	["arifle_MXC_Black_F", 100],
	["arifle_MXM_F", 100],
	["arifle_MXM_Black_F", 100],
	["LMG_Zafir_F", 100],
	["srifle_DMR_01_F", 100],
	["arifle_TRG21_F", 100],
	["arifle_TRG21_GL_F", 100],
	["hgun_Pistol_heavy_01_F", 100],
	["hgun_ACPC2_F", 100],
	["hgun_Rook40_F", 100],
	["hgun_P07_F", 100],
	["hgun_Pistol_heavy_02_F", 100]
]] call CBA_fnc_hashSet;

[_config, "ammo", [
	["30Rnd_9x21_Mag", 10],
	["30Rnd_556x45_Stanag", 10],
	["30Rnd_556x45_Stanag_Tracer_Red", 10],
	["30Rnd_556x45_Stanag_Tracer_Green", 10],
	["30Rnd_556x45_Stanag_Tracer_Yellow", 10],
	["30Rnd_9x21_Mag", 10],
	["30Rnd_45ACP_Mag_SMG_01", 10],
	["30Rnd_45ACP_Mag_SMG_01_Tracer_Green", 10],
	["20Rnd_556x45_UW_mag", 10],
	["30Rnd_556x45_Stanag", 10],
	["30Rnd_556x45_Stanag_Tracer_Red", 10],
	["30Rnd_556x45_Stanag_Tracer_Green", 10],
	["30Rnd_556x45_Stanag_Tracer_Yellow", 10],
	["5Rnd_127x108_Mag", 10],
	["5Rnd_127x108_APDS_Mag", 10],
	["30Rnd_65x39_caseless_green", 10],
	["30Rnd_65x39_caseless_green_mag_Tracer", 10],
	["1Rnd_HE_Grenade_shell", 10],
	["UGL_FlareWhite_F", 10],
	["UGL_FlareGreen_F", 10],
	["UGL_FlareRed_F", 10],
	["UGL_FlareYellow_F", 10],
	["UGL_FlareCIR_F", 10],
	["1Rnd_Smoke_Grenade_shell", 10],
	["1Rnd_SmokeRed_Grenade_shell", 10],
	["1Rnd_SmokeGreen_Grenade_shell", 10],
	["1Rnd_SmokeYellow_Grenade_shell", 10],
	["1Rnd_SmokePurple_Grenade_shell", 10],
	["1Rnd_SmokeBlue_Grenade_shell", 10],
	["1Rnd_SmokeOrange_Grenade_shell", 10],
	["7Rnd_408_Mag", 10],
	["20Rnd_762x51_Mag", 10],
	["200Rnd_65x39_cased_Box", 10],
	["200Rnd_65x39_cased_Box_Tracer", 10],
	["30Rnd_65x39_caseless_mag", 10],
	["30Rnd_65x39_caseless_mag_Tracer", 10],
	["100Rnd_65x39_caseless_mag", 10],
	["100Rnd_65x39_caseless_mag_Tracer", 10],
	["150Rnd_762x51_Box", 10],
	["150Rnd_762x51_Box_Tracer", 10],
	["10Rnd_762x51_Mag", 10],
	["11Rnd_45ACP_Mag", 10],
	["9Rnd_45ACP_Mag", 10],
	["16Rnd_9x21_Mag", 10],
	["16Rnd_9x21_Mag", 10],
	["6Rnd_45ACP_Cylinder", 10],
	["NLAW_F", 10],
	["TMR_NLAW_MPV_F", 10],
	["RPG32_F", 10],
	["RPG32_HE_F", 10],
	["TMR_RPG32_Smoke_F", 10],
	["TMR_RPG32_TB_F", 10],
	["Titan_AT", 10],
	["Titan_AP", 10],
	["Titan_AA", 10],
	["Laserbatteries", 10]
]] call CBA_fnc_hashSet;

[_config, "launchers", [
	["launch_NLAW_F", 100],
	["TMR_launch_NLAW_MPV_F", 100],
	["launch_RPG32_F", 100],
	["launch_B_Titan_short_F", 100],
	["launch_O_Titan_F", 100],
	
	["HandGrenade", 10],
	["MiniGrenade", 10],
	["SmokeShell", 10],
	["SmokeShellYellow", 10],
	["SmokeShellGreen", 10],
	["SmokeShellRed", 10],
	["SmokeShellPurple", 10],
	["SmokeShellOrange", 10],
	["SmokeShellBlue", 10],
	["Chemlight_green", 10],
	["Chemlight_red", 10],
	["Chemlight_yellow", 10],
	["Chemlight_blue", 10],
	["B_IR_Grenade", 10],
	["O_IR_Grenade", 10],
	["I_IR_Grenade", 10],
	
	["DemoCharge_Remote_Mag", 10],
	["SatchelCharge_Remote_Mag", 10],
	["ATMine_Range_Mag", 10],
	["ClaymoreDirectionalMine_Remote_Mag", 10],
	["APERSMine_Range_Mag", 10],
	["APERSBoundingMine_Range_Mag", 10],
	["SLAMDirectionalMine_Wire_Mag", 10],
	["APERSTripMine_Wire_Mag", 10]	
]] call CBA_fnc_hashSet;

[_config, "items", [
	["Binocular", 25],
	["Laserdesignator", 25],
	["NVGoggles", 25],
	["Rangefinder", 25],
	["FirstAidKit", 25],
	["ToolKit", 25],
	["Medikit", 25],
	["ItemCompass", 25],
	["ItemGPS", 25],
	["ItemMap", 25],
	["ItemRadio", 25],
	["ItemWatch", 25]
]] call CBA_fnc_hashSet;

[_config, "wearables", [
	["U_BasicBody",10],
	["U_B_CombatUniform_mcam",10],
	["U_B_CombatUniform_mcam_tshirt",10],
	["U_B_CombatUniform_mcam_vest",10],
	["U_B_GhillieSuit",10],
	["U_B_HeliPilotCoveralls",10],
	["U_B_Wetsuit",10],
	["U_O_CombatUniform_ocamo",10],
	["U_O_GhillieSuit",10],
	["U_O_PilotCoveralls",10],
	["U_O_Wetsuit",10],
	["U_C_Poloshirt_blue",10],
	["U_C_Poloshirt_burgundy",10],
	["U_C_Poloshirt_stripped",10],
	["U_C_Poloshirt_tricolour",10],
	["U_C_Poloshirt_salmon",10],
	["U_C_Poloshirt_redwhite",10],
	["U_C_Commoner1_1",10],
	["U_C_Commoner1_2",10],
	["U_C_Commoner1_3",10],
	["U_Rangemaster",10],
	["U_B_CombatUniform_mcam_worn",10],
	["U_B_CombatUniform_wdl",10],
	["U_B_CombatUniform_wdl_tshirt",10],
	["U_B_CombatUniform_wdl_vest",10],
	["U_B_CombatUniform_sgg",10],
	["U_B_CombatUniform_sgg_tshirt",10],
	["U_B_CombatUniform_sgg_vest",10],
	["U_B_SpecopsUniform_sgg",10],
	["U_B_PilotCoveralls",10],
	["U_O_CombatUniform_oucamo",10],
	["U_O_SpecopsUniform_ocamo",10],
	["U_O_SpecopsUniform_blk",10],
	["U_O_OfficerUniform_ocamo",10],
	["U_I_CombatUniform",10],
	["U_I_CombatUniform_tshirt",10],
	["U_I_CombatUniform_shortsleeve",10],
	["U_I_pilotCoveralls",10],
	["U_I_HeliPilotCoveralls",10],
	["U_I_GhillieSuit",10],
	["U_I_OfficerUniform",10],
	["U_I_Wetsuit",10],
	["U_Competitor",10],
	["U_NikosBody",10],
	["U_MillerBody",10],
	["U_KerryBody",10],
	["U_OrestesBody",10],
	["U_AttisBody",10],
	["U_AntigonaBody",10],
	["U_IG_Menelaos",10],
	["U_C_Novak",10],
	["U_OI_Scientist",10],
	["U_IG_Guerilla1_1",10],
	["U_IG_Guerilla2_1",10],
	["U_IG_Guerilla2_2",10],
	["U_IG_Guerilla2_3",10],
	["U_IG_Guerilla3_1",10],
	["U_IG_Guerilla3_2",10],
	["U_IG_leader",10],
	["U_BG_Guerilla1_1",10],
	["U_BG_Guerilla2_1",10],
	["U_BG_Guerilla2_2",10],
	["U_BG_Guerilla2_3",10],
	["U_BG_Guerilla3_1",10],
	["U_BG_Guerilla3_2",10],
	["U_BG_leader",10],
	["U_OG_Guerilla1_1",10],
	["U_OG_Guerilla2_1",10],
	["U_OG_Guerilla2_2",10],
	["U_OG_Guerilla2_3",10],
	["U_OG_Guerilla3_1",10],
	["U_OG_Guerilla3_2",10],
	["U_OG_leader",10],
	["U_C_Poor_1",10],
	["U_C_Poor_2",10],
	["U_C_Scavenger_1",10],
	["U_C_Scavenger_2",10],
	["U_C_Farmer",10],
	["U_C_Fisherman",10],
	["U_C_WorkerOveralls",10],
	["U_C_FishermanOveralls",10],
	["U_C_WorkerCoveralls",10],
	["U_C_HunterBody_grn",10],
	["U_C_HunterBody_brn",10],
	["U_C_Commoner2_1",10],
	["U_C_Commoner2_2",10],
	["U_C_Commoner2_3",10],
	["U_C_PriestBody",10],
	["U_C_Poor_shorts_1",10],
	["U_C_Poor_shorts_2",10],
	["U_C_Commoner_shorts",10],
	["U_C_ShirtSurfer_shorts",10],
	["U_C_TeeSurfer_shorts_1",10],
	["U_C_TeeSurfer_shorts_2",10],
	["U_B_CTRG_1",10],
	["U_B_CTRG_2",10],
	["U_B_CTRG_3",10],
	["U_B_survival_uniform",10],
	["U_I_G_Story_Protagonist_F",10],
	["U_I_G_resistanceLeader_F",10],
	["Vest_Camo_Base",10],
	["Vest_NoCamo_Base",10],
	["V_Rangemaster_belt",10],
	["V_BandollierB_khk",10],
	["V_BandollierB_cbr",10],
	["V_BandollierB_rgr",10],
	["V_BandollierB_blk",10],
	["V_PlateCarrier1_rgr",10],
	["V_PlateCarrier2_rgr",10],
	["V_PlateCarrier3_rgr",10],
	["V_PlateCarrierGL_rgr",10],
	["V_Chestrig_khk",10],
	["V_Chestrig_rgr",10],
	["V_Chestrig_blk",10],
	["V_TacVest_khk",10],
	["V_TacVest_brn",10],
	["V_TacVest_oli",10],
	["V_TacVest_blk",10],
	["V_HarnessO_brn",10],
	["V_HarnessOGL_brn",10],
	["V_RebreatherB",10],
	["V_RebreatherIR",10],
	["V_BandollierB_oli",10],
	["V_PlateCarrier1_blk",10],
	["V_PlateCarrierSpec_rgr",10],
	["V_Chestrig_oli",10],
	["V_TacVest_camo",10],
	["V_TacVest_blk_POLICE",10],
	["V_TacVestIR_blk",10],
	["V_TacVestCamo_khk",10],
	["V_HarnessO_gry",10],
	["V_HarnessOGL_gry",10],
	["V_HarnessOSpec_brn",10],
	["V_HarnessOSpec_gry",10],
	["V_PlateCarrierIA1_dgtl",10],
	["V_PlateCarrierIA2_dgtl",10],
	["V_PlateCarrierIAGL_dgtl",10],
	["V_RebreatherIA",10],
	["V_PlateCarrier_Kerry",10],
	["V_PlateCarrierL_CTRG",10],
	["V_PlateCarrierH_CTRG",10],
	["V_I_G_resistanceLeader_F",10],
	["B_AssaultPack_Base",10],
	["B_AssaultPack_khk",10],
	["B_AssaultPack_dgtl",10],
	["B_AssaultPack_rgr",10],
	["B_AssaultPack_sgg",10],
	["B_AssaultPack_blk",10],
	["B_AssaultPack_cbr",10],
	["B_AssaultPack_mcamo",10],
	["B_AssaultPack_ocamo",10],
	["B_Kitbag_Base",10],
	["B_Kitbag_rgr",10],
	["B_Kitbag_mcamo",10],
	["B_Kitbag_sgg",10],
	["B_Kitbag_cbr",10],
	["B_TacticalPack_Base",10],
	["B_TacticalPack_rgr",10],
	["B_TacticalPack_mcamo",10],
	["B_TacticalPack_ocamo",10],
	["B_TacticalPack_blk",10],
	["B_TacticalPack_oli",10],
	["B_FieldPack_Base",10],
	["B_FieldPack_khk",10],
	["B_FieldPack_ocamo",10],
	["B_FieldPack_oucamo",10],
	["B_FieldPack_cbr",10],
	["B_FieldPack_blk",10],
	["B_Carryall_Base",10],
	["B_Carryall_ocamo",10],
	["B_Carryall_oucamo",10],
	["B_Carryall_mcamo",10],
	["B_Carryall_khk",10],
	["B_Carryall_cbr",10],
	["B_Bergen_Base",10],
	["B_Bergen_sgg",10],
	["B_Bergen_mcamo",10],
	["B_Bergen_rgr",10],
	["B_Bergen_blk",10],
	["B_OutdoorPack_Base",10],
	["B_OutdoorPack_blk",10],
	["B_OutdoorPack_tan",10],
	["B_OutdoorPack_blu",10],
	["B_HuntingBackpack",10],
	["B_AssaultPackG",10],
	["B_BergenG",10],
	["B_BergenC_Base",10],
	["B_BergenC_red",10],
	["B_BergenC_grn",10],
	["B_BergenC_blu",10],
	["B_AssaultPack_rgr_LAT",10],
	["B_AssaultPack_rgr_Medic",10],
	["B_AssaultPack_rgr_Repair",10],
	["B_Assault_Diver",10],
	["B_AssaultPack_blk_DiverExp",10],
	["B_Kitbag_rgr_Exp",10],
	["B_FieldPack_blk_DiverExp",10],
	["O_Assault_Diver",10],
	["B_FieldPack_ocamo_Medic",10],
	["B_FieldPack_cbr_LAT",10],
	["B_FieldPack_cbr_Repair",10],
	["B_Carryall_ocamo_Exp",10],
	["B_FieldPack_oli",10],
	["B_Carryall_oli",10],
	["G_AssaultPack",10],
	["G_Bergen",10],
	["C_Bergen_Base",10],
	["C_Bergen_red",10],
	["C_Bergen_grn",10],
	["C_Bergen_blu",10],
	["B_AssaultPack_mcamo_AT",10],
	["B_AssaultPack_rgr_ReconMedic",10],
	["B_AssaultPack_rgr_ReconExp",10],
	["B_AssaultPack_rgr_ReconLAT",10],
	["B_AssaultPack_mcamo_AA",10],
	["B_AssaultPack_mcamo_AAR",10],
	["B_AssaultPack_mcamo_Ammo",10],
	["B_Kitbag_mcamo_Eng",10],
	["B_Carryall_mcamo_AAA",10],
	["B_Carryall_mcamo_AAT",10],
	["B_FieldPack_ocamo_AA",10],
	["B_FieldPack_ocamo_AAR",10],
	["B_FieldPack_ocamo_ReconMedic",10],
	["B_FieldPack_cbr_AT",10],
	["B_FieldPack_cbr_AAT",10],
	["B_FieldPack_cbr_AA",10],
	["B_FieldPack_cbr_AAA",10],
	["B_FieldPack_cbr_Medic",10],
	["B_FieldPack_ocamo_ReconExp",10],
	["B_FieldPack_cbr_Ammo",10],
	["B_FieldPack_cbr_RPG_AT",10],
	["B_Carryall_ocamo_AAA",10],
	["B_Carryall_ocamo_Eng",10],
	["B_Carryall_cbr_AAT",10],
	["B_FieldPack_oucamo_AT",10],
	["B_FieldPack_oucamo_LAT",10],
	["B_Carryall_oucamo_AAT",10],
	["B_FieldPack_oucamo_AA",10],
	["B_Carryall_oucamo_AAA",10],
	["B_FieldPack_oucamo_AAR",10],
	["B_FieldPack_oucamo_Medic",10],
	["B_FieldPack_oucamo_Ammo",10],
	["B_FieldPack_oucamo_Repair",10],
	["B_Carryall_oucamo_Exp",10],
	["B_Carryall_oucamo_Eng",10],
	["I_Fieldpack_oli_AA",10],
	["I_Assault_Diver",10],
	["I_Fieldpack_oli_Ammo",10],
	["I_Fieldpack_oli_Medic",10],
	["I_Fieldpack_oli_Repair",10],
	["I_Fieldpack_oli_LAT",10],
	["I_Fieldpack_oli_AT",10],
	["I_Fieldpack_oli_AAR",10],
	["I_Carryall_oli_AAT",10],
	["I_Carryall_oli_Exp",10],
	["I_Carryall_oli_AAA",10],
	["I_Carryall_oli_Eng",10],
	["G_TacticalPack_Eng",10],
	["G_FieldPack_Medic",10],
	["G_FieldPack_LAT",10],
	["G_Carryall_Ammo",10],
	["G_Carryall_Exp",10],
	["B_BergenG_TEST_B_Soldier_overloaded",10],
	["B_AssaultPack_Kerry",10],
	["B_Fieldpack_oli_LAT",10],
	["H_HelmetB",10],
	["H_HelmetB_camo",10],
	["H_HelmetB_paint",10],
	["H_HelmetB_light",10],
	["H_Booniehat_khk",10],
	["H_Booniehat_indp",10],
	["H_Booniehat_mcamo",10],
	["H_Cap_red",10],
	["H_Cap_blu",10],
	["H_Cap_oli",10],
	["H_Cap_headphones",10],
	["H_PilotHelmetHeli_B",10],
	["H_PilotHelmetHeli_O",10],
	["H_HelmetO_ocamo",10],
	["H_HelmetLeaderO_ocamo",10],
	["H_MilCap_ocamo",10],
	["H_MilCap_mcamo",10],
	["H_Booniehat_grn",10],
	["H_Booniehat_tan",10],
	["H_Booniehat_dirty",10],
	["H_Booniehat_dgtl",10],
	["H_HelmetB_plain_mcamo",10],
	["H_HelmetB_plain_blk",10],
	["H_HelmetSpecB",10],
	["H_HelmetSpecB_paint1",10],
	["H_HelmetSpecB_paint2",10],
	["H_HelmetSpecB_blk",10],
	["H_HelmetIA",10],
	["H_HelmetIA_net",10],
	["H_HelmetIA_camo",10],
	["H_Cap_tan",10],
	["H_Cap_blk",10],
	["H_Cap_blk_CMMG",10],
	["H_Cap_brn_SPECOPS",10],
	["H_Cap_tan_specops_US",10],
	["H_Cap_khaki_specops_UK",10],
	["H_Cap_grn",10],
	["H_Cap_grn_BI",10],
	["H_Cap_blk_Raven",10],
	["H_Cap_blk_ION",10],
	["H_HelmetCrew_B",10],
	["H_HelmetCrew_O",10],
	["H_HelmetCrew_I",10],
	["H_PilotHelmetFighter_B",10],
	["H_PilotHelmetFighter_O",10],
	["H_PilotHelmetFighter_I",10],
	["H_PilotHelmetHeli_I",10],
	["H_CrewHelmetHeli_B",10],
	["H_CrewHelmetHeli_O",10],
	["H_CrewHelmetHeli_I",10],
	["H_BandMask_blk",10],
	["H_BandMask_khk",10],
	["H_BandMask_reaper",10],
	["H_BandMask_demon",10],
	["H_HelmetO_oucamo",10],
	["H_HelmetLeaderO_oucamo",10],
	["H_HelmetSpecO_ocamo",10],
	["H_HelmetSpecO_blk",10],
	["H_MilCap_oucamo",10],
	["H_MilCap_rucamo",10],
	["H_MilCap_gry",10],
	["H_MilCap_dgtl",10],
	["H_MilCap_blue",10],
	["H_Bandanna_surfer",10],
	["H_Bandanna_khk",10],
	["H_Bandanna_cbr",10],
	["H_Bandanna_sgg",10],
	["H_Bandanna_gry",10],
	["H_Bandanna_camo",10],
	["H_Bandanna_mcamo",10],
	["H_Shemag_khk",10],
	["H_Shemag_tan",10],
	["H_Shemag_olive",10],
	["H_ShemagOpen_khk",10],
	["H_ShemagOpen_tan",10],
	["H_Beret_blk",10],
	["H_Beret_blk_POLICE",10],
	["H_Beret_red",10],
	["H_Beret_grn",10],
	["H_Beret_grn_SF",10],
	["H_Beret_brn_SF",10],
	["H_Beret_ocamo",10],
	["H_Watchcap_blk",10],
	["H_Watchcap_khk",10],
	["H_Watchcap_camo",10],
	["H_Watchcap_sgg",10],
	["H_TurbanO_blk",10],
	["H_StrawHat",10],
	["H_StrawHat_dark",10],
	["H_Hat_blue",10],
	["H_Hat_brown",10],
	["H_Hat_camo",10],
	["H_Hat_grey",10],
	["H_Hat_checker",10],
	["H_Hat_tan",10],
	["H_Helmet_Kerry",10],
	["H_HelmetB_grass",10],
	["H_HelmetB_snakeskin",10],
	["H_HelmetB_desert",10],
	["H_HelmetB_black",10],
	["H_HelmetB_sand",10],
	["H_HelmetB_light_grass",10],
	["H_HelmetB_light_snakeskin",10],
	["H_HelmetB_light_desert",10],
	["H_HelmetB_light_black",10],
	["H_HelmetB_light_sand",10],
	["H_Beret_02",10],
	["H_Shemag_olive_hs",10],
	["H_Cap_oli_hs",10],
	["H_Bandanna_khk_hs",10],
	["H_Booniehat_khk_hs",10],
	["G_Diving",10],
	["G_Shades_Black",10],
	["G_Shades_Blue",10],
	["G_Sport_Blackred",10],
	["G_Tactical_Clear",10],
	["G_Spectacles",10],
	["G_Spectacles_Tinted",10],
	["G_Combat",10],
	["G_Lowprofile",10],
	["G_Shades_Green",10],
	["G_Shades_Red",10],
	["G_Squares",10],
	["G_Squares_Tinted",10],
	["G_Sport_BlackWhite",10],
	["G_Sport_Blackyellow",10],
	["G_Sport_Greenblack",10],
	["G_Sport_Checkered",10],
	["G_Sport_Red",10],
	["G_Tactical_Black",10],
	["G_Aviator",10],
	["G_Lady_Mirror",10],
	["G_Lady_Dark",10],
	["G_Lady_Red",10],
	["G_Lady_Blue",10],
	["G_B_Diving",10],
	["G_O_Diving",10],
	["G_I_Diving",10]	
]] call CBA_fnc_hashSet;

[_config, "attachments", [
	["muzzle_snds_H",10],
	["muzzle_snds_L",10],
	["muzzle_snds_M",10],
	["muzzle_snds_B",10],
	["muzzle_snds_H_MG",10],
	["muzzle_snds_acp",10],
	["tmr_muzzle_snds_H_katiba",10],
	["tmr_muzzle_snds_L_smg",10],
	["tmr_muzzle_snds_acp_smg",10],
	["acc_flashlight",10],
	["acc_pointer_IR",10],
	["TMR_acc_bipod",10],
	["optic_Arco",10],
	["optic_Hamr",10],
	["optic_Aco",10],
	["optic_ACO_grn",10],
	["optic_Aco_smg",10],
	["optic_ACO_grn_smg",10],
	["optic_Holosight",10],
	["optic_Holosight_smg",10],
	["optic_SOS",10],
	["optic_MRCO",10],
	["optic_DMS",10],
	["optic_Yorris",10],
	["optic_MRD",10],
	["optic_LRPS",10],
	["optic_NVS",10],
	["optic_Nightstalker",10],
	["optic_tws",10],
	["optic_tws_mg",10]
]] call CBA_fnc_hashSet;

_config