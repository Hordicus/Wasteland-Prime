class missionsServer {
	class missionsServerInit {
		file = "\x\bl_common\addons\systems\missions\init.sqf";
		preInit = 1;
	};
	
	class missionsConfig {
		file = "\x\bl_common\addons\config\missions.sqf";
	};

	file = "\x\bl_common\addons\systems\missions\functions";
	class spawnMission{};
	class missionDone{};
	class nearMissions{};
	class missionRandomField{};
	class spawnMissionVehWithCrew{};
	class failOnKilled{};
	class saveOnGetIn{};
	class lockVehicle{};
	class missionDoneWhenKilled{};
	class statTrackAIUnits{};
	class aliveObjectCounter{};
	
	class particleSourceCreateServer{};
	class particleSourceDeleteServer{};
	class cargoDrop{};
	
	// BIS task functions
	class setTask{};
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