class missionsServer {
	class missionsServerInit {
		file = "\x\bl_server\addons\systems\missions\init.sqf";
		preInit = 1;
	};
	
	class missionsConfig {
		file = "\x\bl_server\addons\config\missions.sqf";
	};

	file = "\x\bl_server\addons\systems\missions\functions";
	class spawnMission{};
	class missionDone{};
	class nearMissions{};
	class missionRandomField{};
	
	// BIS task functions
	class deleteTask{};
	class setTask{};
	class setTaskLocal{};
	class taskChildren{};
	class taskCompleted{};
	class taskCreate{};
	class taskCurrent{};
	class taskDescription{};
	class taskDestination{};
	class taskExists{};
	class taskHint{};
	class taskParent{};
	class taskReal{};
	class taskSetCurrent{};
	class taskSetDescription{};
	class taskSetDestination{};
	class taskSetState{};
	class taskState{};
	class taskVar{};
};