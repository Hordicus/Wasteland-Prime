if !( 'statTracking' call BL_fnc_shouldRun ) exitwith{};

#include "macro.sqf"
private ['_player', '_killer', '_playerData', '_playerVehicle'];
_player = _this select 0;
_killer = [_this select 1] call BL_fnc_getKiller;

_playerVehicle = typeOf vehicle _player;
_playerData = _player call BL_fnc_getPlayerScore;

if ( isPlayer _player ) then {
	[_player, _killer, _playerData select INDEX_BOUNTY] call BL_fnc_sendKillMsg;
}
else {
	[_player, _killer, _player getVariable ['bounty', BL_aiBountyAmount]] call BL_fnc_sendKillMsg;
};

if ( isPlayer _player ) then {
	// Update player bounty
	if ( _player != _killer ) then {
		_playerData set [INDEX_BOUNTY, 0];
	};
	
	_playerData set [INDEX_DEATHS, (_playerData select INDEX_DEATHS) + 1];

	// Add to players score
	[_player, "death"] call BL_fnc_addPoints;
	
	[_player, _playerData] call BL_fnc_setPlayerScore;
};

if ( _killer != _player && isPlayer _killer ) then {
	if ( isPlayer _player ) then {
		private ['_data'];
		_data = _killer call BL_fnc_getPlayerScore;

		// Add one to killers' kills
		_data set [INDEX_KILLS, (_data select INDEX_KILLS) + 1];
		[_killer, _data] call BL_fnc_setPlayerScore;
	
		// Add to killer score
		[_killer, 'playerKill'] call BL_fnc_addPoints;
	}
	else {
		[_killer, 'aiKill'] call BL_fnc_addPoints;
	};
	
	// Bonus points for killing player in vehicle
	if !( _playerVehicle isKindOf "Man" ) then {
		private ['_vehicles', '_bonus', '_parent'];
		_vehicles = [call BL_fnc_statTrackingConfig, 'vehicleBonus'] call CBA_fnc_hashGet;
		_bonus = 0;
	
		if ( !isNil { [_vehicles, _playerVehicle] call CBA_fnc_hashGet } ) then {
			_bonus = [_vehicles, _playerVehicle] call CBA_fnc_hashGet;
		}
		else {
			_parent = _playerVehicle;
			while { _parent != "All" } do {
				_parent = configName inheritsFrom (configFile >> "CfgVehicles" >> _parent);

				if ( !isNil {[_vehicles, _parent] call CBA_fnc_hashGet} ) exitwith {
					_bonus = [_vehicles, _parent] call CBA_fnc_hashGet;
				};
			};
		};

		[_killer, _bonus, "vehicleBonus"] call BL_fnc_addPoints;
	};
};
