execVM 'addons\randomWeather2.sqf';

if ( isDedicated ) exitwith{};
enableSaving [false, false];
execVM "client\init.sqf";