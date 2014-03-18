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
	class leaveGroup{};
	
	class inviteToGroup{};
	class acceptGroupInvite{};
	class cancelGroupInvite{};
	class kickFromGroup{};
	class promoteToLeader{};
	
	class flipVehicle{};
	class playerByName{};
};