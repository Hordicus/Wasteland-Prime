class playerMenu {
	file = "client\systems\playerMenu\functions";
	
	class playerMenuInit{
		file = "client\systems\playerMenu\init.sqf";
		postInit = 1;
	};
	
	class setViewDistance{};
	class monitorViewDistance{
		postInit = 1;
	};
	
	class setGroupButtons{};
	class updateGroupInfo{};
	class updateInfoText{};
	class leaveGroup{};
	
	class sendGroupInvite{};
	class acceptGroupInvite{};
	class cancelGroupInvite{};
	class rejectGroupInvite{};
	
	class kickFromGroup{};
	class promoteToLeader{};
	
	class flipVehicle{};
	class playerByName{};
	
	class addInventoryType{};
	class removeInventoryType{};
	class addInventoryItem{};
	class removeInventoryItem{};
	class updatePlayerInv{};
};