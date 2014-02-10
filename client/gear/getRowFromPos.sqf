disableSerialization;
_ctrl = _this select 0;
_click_pos = _this select 1;
_ctrl_pos = ctrlPosition _ctrl;
_rowHeight = 0.045;

floor( ((_click_pos select 1) - (_ctrl_pos select 1)) / _rowHeight )