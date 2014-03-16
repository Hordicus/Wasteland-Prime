private ['_config', '_key', '_return'];
_key = [_this, 0, '', ['']] call BIS_fnc_param;
_config = [] call CBA_fnc_hashCreate;

[_config, 'airBeaconModel', 'Land_SatellitePhone_F'] call CBA_fnc_hashSet;
[_config, 'groundBeaconModel', 'Land_SurvivalRadio_F'] call CBA_fnc_hashSet;

_return = '';
if ( _key == '' ) then {
	_return = _config;
}
else {
	_return = [_config, _key] call CBA_fnc_hashGet;
};

_return