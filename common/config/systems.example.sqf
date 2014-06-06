private ['_config'];
_config = [[], ""] call CBA_fnc_hashCreate;

[_config, 'objectLoad',           'uid'] call CBA_fnc_hashSet;
[_config, 'weaponsCrates',        'uid'] call CBA_fnc_hashSet;
[_config, 'radar',                'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_createVehicle',   'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_deleteVehicle',   'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_loadPlayer',      ''] call CBA_fnc_hashSet;
[_config, 'PVAR_requestSave',     ''] call CBA_fnc_hashSet;
[_config, 'createSpawnBeacon',    'uid'] call CBA_fnc_hashSet;
[_config, 'destroySpawnBeacon',   'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_createBaseFlag',  'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_destroyBaseFlag', 'uid'] call CBA_fnc_hashSet;
[_config, 'PVAR_trackVehicle',    'uid'] call CBA_fnc_hashSet;
[_config, 'adminPanel',           ''] call CBA_fnc_hashSet;

_config