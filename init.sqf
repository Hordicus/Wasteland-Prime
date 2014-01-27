enableSaving [false, false];

if ( !isServer || !isDedicated ) then {
	// Client
	execVM "client\init.sqf";
};

if ( isServer ) then {
	// Server
	execVM "server\init.sqf";
};