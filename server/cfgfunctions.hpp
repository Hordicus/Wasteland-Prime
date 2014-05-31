class cfgFunctions {
	class BL {
		#include "systems\stores\cfgfunctions.hpp"
		#include "systems\adminPanel\cfgfunctions.hpp"
		#include "systems\staticVehicleSpawns\cfgfunctions.hpp"
		#include "systems\weather\cfgfunctions.hpp"

		class Server {
			class serverInit {
				file = "\x\bl_server\addons\init.sqf";
				preInit = 1;
			};
		};
	};
};