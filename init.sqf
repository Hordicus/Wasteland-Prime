enableSaving [false, false];

_h = execVM "common\functions\compile.sqf";
waituntil { scriptDone _h };

if ( !isServer || !isDedicated ) then {
	// Client
	execVM "client\init.sqf";
};

if ( isServer ) then {
	// Server
	execVM "server\init.sqf";
};