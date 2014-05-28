class cfgFunctions {
	class BLCommon {
		tag = "BL";	
		#include "systems\persistence\cfgfunctions.hpp"
		
		class Common {
			class stopPostInit {
				file = "\x\bl_common\addons\stopPostInit.sqf";
				postInit = 1;
			};
			
			class systemsConfig {
				file = "\x\bl_common\addons\config\systems.sqf";
			};
			
			file = "\x\bl_common\addons\functions";
			class shouldRun{};
		};
	};
};