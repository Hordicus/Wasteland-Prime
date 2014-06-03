class cfgFunctions {
	class BLCommon {
		tag = "BL";
		class Common {
			class commonInit {
				file = "\x\bl_common\addons\init.sqf";
				preInit = 1;
			};
			
			class stopPostInit {
				file = "\x\bl_common\addons\stopPostInit.sqf";
				postInit = 1;
			};
			
			class systemsConfig {
				file = "\x\bl_common\addons\config\systems.sqf";
			};

			class playerMenuServerInit {
				file = "\x\bl_common\addons\systems\playerMenu\init.sqf";
				preInit = 1;
			};

			class townRadarInit {
				file = "\x\bl_common\addons\systems\townRadar\init.sqf";
				preInit = 1;
			};
			
			file = "\x\bl_common\addons\functions";
			class shouldRun{};
			class hasLOS{};
			class addPublicVariableEventHandler{};
			class publicVariableClient{};
			class pvarEventHandler{};
			class forwardEventToAllHCs{};
		};
		
		#include "systems\radar\cfgfunctions.hpp"
		#include "systems\weaponsCrates\cfgfunctions.hpp"
		#include "systems\playerRespawn\cfgfunctions.hpp"
		#include "systems\baseFlag\cfgfunctions.hpp"
		#include "systems\persistence\cfgfunctions.hpp"
		#include "systems\statTracking\cfgfunctions.hpp"
		#include "systems\donators\cfgfunctions.hpp"		
		#include "systems\stores\cfgfunctions.hpp"
	};
};