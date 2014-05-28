class cfgFunctions {
	class BLCommon {
		tag = "BL";	
		#include "systems\persistence\cfgfunctions.hpp"
		
		class Common {
			class stopPostInit {
				file = "\x\bl_common\addons\stopPostInit.sqf";
				postInit = 1;
			};
		};
	};
};