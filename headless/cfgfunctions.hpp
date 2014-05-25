class cfgFunctions {
	class BL {
		#include "systems\vehicleTownSpawns\cfgfunctions.hpp"
		#include "systems\persistence\cfgfunctions.hpp"
		class Headless {
			class HeadlessInit {
				file = "\x\bl_headless\addons\init.sqf";
				preInit = 1;
			};
			
			file = "\x\bl_headless\addons\functions";
			class call{};
		};
	};
};