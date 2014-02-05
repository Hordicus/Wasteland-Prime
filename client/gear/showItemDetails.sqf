#include "dialogs\gear_defines.sqf"
private ["_list", "_index", "_class"];
_list  = _this select 0;
_index = _this select 1;

_class = _list lbData _index;
hint str _class;