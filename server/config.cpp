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

class Extended_Init_Eventhandlers
{
    class AllVehicles
    {
		init = "_this call BL_fnc_simulationManager;";
    };
};

#include "cfgfunctions.hpp"