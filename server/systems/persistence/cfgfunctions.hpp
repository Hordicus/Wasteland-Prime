class persistence {
	class persistenceInit {
		file = "\x\bl_server\addons\systems\persistence\init.sqf";
		preInit = 1;
	};

	file = "\x\bl_server\addons\systems\persistence\functions";
	class loadPlayer{};
	class getLoadout{};
	class savePlayer{};
	class createPlayer{};
	
	class saveVehicle{};
	class loadVehicle{};
	class vehicleWeapons{};
	class trackVehicle{};
	
	class processQueryResult{};
	class MySQLCommand{};
	class MySQLProcessQueue{};
	class noEmptyArrayValues{};
	class emptyArrayValues{};
};