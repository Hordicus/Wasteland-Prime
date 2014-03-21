_class  = [_this, 0, "", [""]] call BIS_fnc_param;
_renderTarget = [_this, 1, "rendertarget45", [""]] call BIS_fnc_param;
_objPos = [_this, 2, [10,10,10000], [[]], [3]] call BIS_fnc_param;


_obj = _class createVehicleLocal _objPos;
_obj enableSimulation false;
_obj setPosATL _objPos;
_obj setDir 90;

_objSize = sizeOf _class;

_cam = "camera" camCreate (position _obj);
_cam cameraEffect ["EXTERNAL", "BACK", _renderTarget];
_cam camSetTarget _obj;
_cam camSetRelPos [4, 5, _objSize];
_cam camCommit 0;

[_cam, _obj]