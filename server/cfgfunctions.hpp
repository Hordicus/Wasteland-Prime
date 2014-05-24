class cfgFunctions {
	class BL {
		#include "systems\radar\cfgfunctions.hpp"
		#include "systems\rareVehicleSpawns\cfgfunctions.hpp"
		#include "systems\weaponsCrates\cfgfunctions.hpp"
		#include "systems\persistence\cfgfunctions.hpp"
		#include "systems\playerRespawn\cfgfunctions.hpp"
		#include "systems\weather\cfgfunctions.hpp"
		#include "systems\missions\cfgfunctions.hpp"
		#include "systems\baseFlag\cfgfunctions.hpp"
		#include "systems\stores\cfgfunctions.hpp"
		#include "systems\statTracking\cfgfunctions.hpp"
		#include "systems\adminPanel\cfgfunctions.hpp"
		#include "systems\staticVehicleSpawns\cfgfunctions.hpp"
		#include "systems\donators\cfgfunctions.hpp"

		class Server {
			class serverInit {
				file = "\x\bl_server\addons\init.sqf";
				preInit = 1;
			};
			file = "\x\bl_server\addons\functions";
			class safeVehicleSpawn{};
			class safeVehicleSetPos{};
			class selectRandom{};
			class hasLOS{};
			
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