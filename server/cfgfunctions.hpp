class cfgFunctions {
	class BL {
		#include "systems\playerMoney\cfgfunctions.hpp"
		#include "systems\radar\cfgfunctions.hpp"
		#include "systems\vehicleTownSpawns\cfgfunctions.hpp"
		#include "systems\rareVehicleSpawns\cfgfunctions.hpp"

		class Server {
			file = "\x\bl_server\addons\functions";
			class nearUnits{};
			class safeVehicleSpawn{};
			
			class playerMenuServerInit {
				file = "\x\bl_server\addons\systems\playerMenu\init.sqf";
				preInit = 1;
			};
			
			class playerRespawnInit {
				file = "\x\bl_server\addons\systems\playerRespawn\init.sqf";
				preInit = 1;
			};
			
			class townRadarInit {
				file = "\x\bl_server\addons\systems\townRadar\init.sqf";
				postInit = 1;
			};
		};
	};
};