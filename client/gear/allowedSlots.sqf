private ['_cfg', '_allowedSlots'];
_cfg = _this call GEAR_getConfig;
_allowedSlots = getArray (_cfg >> 'allowedSlots');

_allowedSlots