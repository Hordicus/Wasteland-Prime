{
	(_this select 0) drawIcon [
		MISSION_ROOT + 'client\systems\baseFlag\icons\base.paa',
		[1,1,1,1],
		_x select 2,
		24,
		24,
		0,
		'',
		0,
		0.03,
		"PuristaMedium"
	];
	true
} count BL_PVAR_baseFlags;