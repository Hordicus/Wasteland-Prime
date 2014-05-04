class persistence {
	class persistenceInit {
		file = "\x\bl_server\addons\systems\persistence\init.sqf";
		preInit = 1;
	};
	
	class persistenceConfig {
		file = "\x\bl_server\addons\config\persistence.sqf";
	};

	file = "\x\bl_server\addons\systems\persistence\functions";
	class loadPlayer{};
	class savePlayer{};
	class createPlayer{};
	
	class saveVehicle{};
	class loadVehicle{};
	class vehicleWeapons{};
	class trackVehicle{};
	class deleteVehicleDB{};
	class queueSaveVehicle{};
	class vehicleState{};
	
	class processQueryResult{};
	class MySQLCommand{};
	class MySQLCommandSync{};
	class MySQLProcessQueue{};
	class noEmptyArrayValues{};
	class emptyArrayValues{};
	class floatToString{};
	class allFloatsToStrings{};
	class persistanceEventHandler{};
	class log{};
	class MySQLEscape{};
	
	class persRegisterTypeHandler{};
	class persRunTypeHandler{};
	
	class logUntrackedVehicle{};
};