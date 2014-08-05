[] spawn {
	waitUntil { !isNil "PERS_init_done" };
	
	"LOG_PVAR_SETVECTORDIRANDUP" addPublicVariableEventHandler {
		if ( isServer ) then {
			if ( !local (_this select 1 select 0) ) then {
				(owner (_this select 1 select 0)) publicVariableClient "LOG_PVAR_SETVECTORDIRANDUP";
			}
			else {
				(_this select 1 select 0) setVectorDirAndUp (_this select 1 select 1);
			};
		}
		else {
			(_this select 1 select 0) setVectorDirAndUp (_this select 1 select 1)
		};
	};
};