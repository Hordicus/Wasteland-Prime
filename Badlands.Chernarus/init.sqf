execVM 'addons\randomWeather2.sqf';

if ( !hasInterface ) exitwith{};
enableSaving [false, false];
execVM "client\init.sqf";
