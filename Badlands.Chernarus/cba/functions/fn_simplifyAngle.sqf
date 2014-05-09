#include "script_macros_common.hpp"
PARAMS_1(_angle);

while {_angle < 0} do
{
      // Angle is negative, so convert it to the equivalent positive angle.
      _angle = _angle + 360;
};

// Make sure it is within the range [0,360].
if (_angle > 360) then {
	_angle = _angle mod 360;
};

// return value
_angle;