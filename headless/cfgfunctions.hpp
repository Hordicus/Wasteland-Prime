class cfgFunctions {
	class BL {
		#include "systems\vehicleTownSpawns\cfgfunctions.hpp"
		#include "systems\rareVehicleSpawns\cfgfunctions.hpp"
		#include "systems\missions\cfgfunctions.hpp"
		class Headless {
			class garbageCollectionInit {
				file = "\x\bl_headless\addons\systems\garbageCollection\init.sqf";
				preInit = 1;
			};
		};
	};
};