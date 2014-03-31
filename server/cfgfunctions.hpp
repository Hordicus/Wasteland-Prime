class cfgFunctions {
	class BL {
		#include "systems\playerMoney\cfgfunctions.hpp"
		#include "systems\radar\cfgfunctions.hpp"
		#include "systems\vehicleTownSpawns\cfgfunctions.hpp"
		#include "systems\rareVehicleSpawns\cfgfunctions.hpp"
		#include "systems\weaponsCrates\cfgfunctions.hpp"
		#include "systems\persistence\cfgfunctions.hpp"
		#include "systems\playerRespawn\cfgfunctions.hpp"

		class Server {
			file = "\x\bl_server\addons\functions";
			class nearUnits{};
			class safeVehicleSpawn{};
			class selectRandom{};
			
			class playerMenuServerInit {
				file = "\x\bl_server\addons\systems\playerMenu\init.sqf";
				preInit = 1;
			};

			class townRadarInit {
				file = "\x\bl_server\addons\systems\townRadar\init.sqf";
				preInit = 1;
			};
			
			class garbageCollectionInit {
				file = "\x\bl_server\addons\systems\garbageCollection\init.sqf";
				preInit = 1;
			};
		};
	};
};