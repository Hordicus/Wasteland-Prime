"BL_HC_call" addPublicVariableEventHandler {
	_return  = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_args    = [_this select 1, 1, [], [[]]] call BIS_fnc_param;
	_fnc     = [_this select 1, 2, "", [""]] call BIS_fnc_param;
	_resCode = [_this select 1, 3, "", [""]] call BIS_fnc_param;
	
	_result = _args call (missionNamespace getVariable [_fnc, {}]);
	
	if ( _resCode != "" ) then {
		BL_HC_callRes = [_resCode, _result];
		(owner _return) publicVariableClient "BL_HC_callRes";
	};
};