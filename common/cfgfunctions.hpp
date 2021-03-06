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
			
			class objTweaksConfig {
				file = "\x\bl_common\addons\config\objTweaks.sqf";
			};

			class playerMenuServerInit {
				file = "\x\bl_common\addons\systems\playerMenu\init.sqf";
				preInit = 1;
			};

			class townRadarInit {
				file = "\x\bl_common\addons\systems\townRadar\init.sqf";
				preInit = 1;
			};

			class garbageCollectionInit {
				file = "\x\bl_common\addons\systems\garbageCollection\init.sqf";
				preInit = 1;
			};
			
			file = "\x\bl_common\addons\functions";
			class shouldRun{};
			class hasLOS{};
			class addPublicVariableEventHandler{};
			class publicVariableClient{};
			class pvarEventHandler{};
			class forwardEventToAllHCs{};
			class objTweak{};
			class spawnCollection{};
		};
		
		#include "systems\radar\cfgfunctions.hpp"
		#include "systems\weaponsCrates\cfgfunctions.hpp"
		#include "systems\playerRespawn\cfgfunctions.hpp"
		#include "systems\baseFlag\cfgfunctions.hpp"
		#include "systems\persistence\cfgfunctions.hpp"
		#include "systems\statTracking\cfgfunctions.hpp"
		#include "systems\donators\cfgfunctions.hpp"		
		#include "systems\stores\cfgfunctions.hpp"
		#include "systems\adminPanel\cfgfunctions.hpp"
		#include "systems\vehicleTownSpawns\cfgfunctions.hpp"
		#include "systems\rareVehicleSpawns\cfgfunctions.hpp"
		#include "systems\missions\cfgfunctions.hpp"
		#include "systems\staticVehicleSpawns\cfgfunctions.hpp"
		#include "systems\fobs\cfgfunctions.hpp"
	};
};