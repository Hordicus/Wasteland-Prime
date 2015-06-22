private ['_loc', '_x1', '_x2'];
_loc = _this select 0;
_x1 = _this select 1;
_x2 = _this select 2;


!(
	((_loc select 0) < (_x1 select 0) || (_loc select 0) > (_x2 select 0)) ||	
	((_loc select 1) < (_x1 select 1) || (_loc select 1) > (_x2 select 1))
)