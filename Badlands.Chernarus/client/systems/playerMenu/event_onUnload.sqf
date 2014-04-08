// Save all user settings on unload
profileNamespace setVariable ['BL_footViewDistance', BL_footViewDistance];
profileNamespace setVariable ['BL_carViewDistance', BL_carViewDistance];
profileNamespace setVariable ['BL_airViewDistance', BL_airViewDistance];
profileNamespace setVariable ['BL_grass', BL_grass];
profileNamespace setVariable ['BL_enableEnv', BL_enableEnv];

saveProfileNamespace;