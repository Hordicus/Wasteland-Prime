class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredAddons[] = {};
		author[] = {"DJRanger"};
		authorUrl = "http://djranger.com";
	};
};

class Extended_Dammaged_Eventhandlers {
	class All {
		dammaged = "_this call BL_fnc_persistanceEventHandler;";
	};
};

class Extended_Killed_Eventhandlers {
	class All {
		killed = "_this call BL_fnc_persistanceEventHandler;";
	};
};

class Extended_Put_Eventhandlers {
	class AllVehicles;
	class Reammobox_F {
		put = "_this call BL_fnc_persistanceEventHandler;";
	};
};

class Extended_Take_Eventhandlers {
	class AllVehicles;
	class Reammobox_F {
		take = "_this call BL_fnc_persistanceEventHandler;";
	};
};

class Extended_GetIn_Eventhandlers {
	class AllVehicles {
		getin = "_this call BL_fnc_persistanceEventHandler;";
	};
};

class Extended_GetOut_Eventhandlers {
	class AllVehicles {
		getout = "_this call BL_fnc_persistanceEventHandler;";
	};
};

#include "cfgfunctions.hpp"