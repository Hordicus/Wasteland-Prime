private ['_amount', '_player', '_current'];
_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
_player = [_this, 1, player, [objNull]] call BIS_fnc_param;

([-_amount, _player] call BL_fnc_addMoney)