class CBA {
	file = "cba\functions";
	class Events {
		class InitEvents {
			preInit = 1;
			file = "cba\functions\InitEvents.sqf";
		};
	
		class addEventHandler{};
		class addLocalEventHandler{};
		class globalEvent{};
		class localEvent{};
		class remoteEvent{};
		class remoteLocalEvent{};
		class removeLocalEventHandler{};
		class whereLocalEvent{};
	};
	
	class Hashes {
		class hashCreate{};
		class hashEachPair{};
		class hashGet{};
		class hashHasKey{};
		class hashRem{};
		class hashSet{};
	};
	
	class Vectors {
		class simplifyAngle{};
		class vectDir{};
	};
	
	class Strings {
		class find{};
		class split{};
	};
	
	class Arrays {
		class join{};
	};
	
	class Misc {
		class defaultParam{};
	};
};