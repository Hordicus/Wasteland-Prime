#include "functions\macro.sqf"
[] spawn {
	disableSerialization;
	waitUntil {!isNull player};
	waituntil {!(IsNull (findDisplay 46))};
	
	private ['_createHud', '_hud', '_playerInfo', '_serverInfo', '_vehicleInfo', '_friendlyIcon'];
	_hud = objNull;
	showNames = false;
	
	(findDisplay 46) displayAddEventHandler ["KeyDown", {
		if ( (_this select 1) == 219 ) then {
			showNames = true;
		};
	}];
	
	(findDisplay 46) displayAddEventHandler ["KeyUp", {
		if ( (_this select 1) == 219 ) then {
			showNames = false;
		};
	}];
	
	// http://killzonekid.com/arma-scripting-tutorials-mission-root/
	MISSION_ROOT = call {
		private "_arr";
		_arr = toArray str missionConfigFile;
		_arr resize (count _arr - 15);
		toString _arr
	};
	
	friendlyIcon = MISSION_ROOT + "client\systems\hud\icons\friendly.paa";
	sideColor = playerSide call {
		if ( _this == resistance || _this == sideEnemy ) exitwith{ [(profilenamespace getvariable ['Map_Independent_R',0]), (profilenamespace getvariable ['Map_Independent_G',1]), (profilenamespace getvariable ['Map_Independent_B',1]), (profilenamespace getvariable ['Map_Independent_A',0.8])]; };
		if ( _this == east ) exitwith{ [(profilenamespace getvariable ['Map_OPFOR_R',0]), (profilenamespace getvariable ['Map_OPFOR_G',1]), (profilenamespace getvariable ['Map_OPFOR_B',1]), (profilenamespace getvariable ['Map_OPFOR_A',0.8])]; };
		if ( _this == west ) exitwith{ [(profilenamespace getvariable ['Map_BLUFOR_R',0]), (profilenamespace getvariable ['Map_BLUFOR_G',1]), (profilenamespace getvariable ['Map_BLUFOR_B',1]), (profilenamespace getvariable ['Map_BLUFOR_A',0.8])]; };
	};



	_createHud = {
		('Badlands' call BIS_fnc_rscLayer) cutRsc ['HUDRsc', 'PLAIN', 0.01, false];
		
		_hud = uiNamespace getVariable 'HUD';
		_playerInfo  = _hud displayCtrl HUDplayerInfoIDC;
		_serverInfo  = _hud displayCtrl HUDserverInfoIDC;
		_vehicleInfo = _hud displayCtrl HUDvehicleInfoIDC;
		
		if ( ! isStreamFriendlyUIEnabled ) then {
			_serverInfo ctrlSetStructuredText parseText ('HUDServerInfo' call BL_fnc_config);
		};
	};
	
	private ['_hudRsc', '_lineHeight', '_vehicleX', '_vehicleY', '_vehicleW', '_vehicleH'];
	_hudRsc = missionConfigFile >> "RscTitles" >> "HUDRsc";
	_lineHeight = getNumber (_hudRsc >> "controlsBackground" >> "vehicleInfo" >> "sizeEx");
	
	_vehicleX   = getNumber (_hudRsc >> "controlsBackground" >> "vehicleInfo" >> "x");
	_vehicleY   = getNumber (_hudRsc >> "controlsBackground" >> "vehicleInfo" >> "y");
	_vehicleW   = getNumber (_hudRsc >> "controlsBackground" >> "vehicleInfo" >> "w");
	_vehicleH   = getNumber (_hudRsc >> "controlsBackground" >> "vehicleInfo" >> "h");

	private ['_decToHex'];
	_decToHex = {
		private ['_dec','_n','_digits','_rest'];
		_dec = _this;
		_n = (_dec % 16);
		_digits = [48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70]; // toArray "0123456789ABCDEF";
		_rest = floor (_dec / 16);
		if (_rest == 0) then {
			(toString [_digits select _n])
		}
		else {
			(_rest call _decToHex) + (toString [_digits select _n])
		};
	};
	
	addMissionEventHandler ["Draw3D", {
		_vehicles = [];
		{
			if ( _x != player && (_x in (units group player) || ((playerSide in [east,west] && playerSide == side _x) && player distance _x < 2000 ))  ) then {
				if ( vehicle _x != _x ) then {
					if !((vehicle _x) in _vehicles) then {
						_vehicles set [count _vehicles, vehicle _x];
					};
				}
				else {
					_loc = visiblePositionASL _x;
					_loc set [2, ((_x modelToWorld (_x selectionPosition 'pelvis')) select 2)];

					drawIcon3D [
						friendlyIcon,
						sideColor,
						_loc,
						0.3,
						0.3,
						0,
						"",
						0,
						0.03,
						"PuristaMedium"
					];
					
					if ( showNames ) then {
						drawIcon3D [
							"",
							[1,1,1,1],
							_loc,
							0,
							0,
							0,
							format ['%1 (%2m)', name _x, round (player distance _x)],
							2,
							0.03,
							"PuristaMedium"
						];
					};
				};
			};
			true
		} count playableUnits;
		
		{
			_loc = visiblePositionASL _x;
			_loc set [2, ((_x modelToWorld getCenterOfMass _x) select 2)];
			
			drawIcon3D [
				friendlyIcon,
				sideColor,
				_loc,
				0.3,
				0.3,
				0,
				"",
				0,
				0.03,
				"PuristaMedium"
			];
			
			if ( showNames ) then {
				{
					drawIcon3D [
						"",
						[1,1,1,1],
						visiblePosition _x,
						0,
						0,
						0,
						name _x,
						2,
						0.03,
						"PuristaMedium"
					];
					true
				} count (crew _x);
				
				drawIcon3D [
					"",
					[1,1,1,1],
					_loc,
					0,
					0,
					0,
					format['%1m', round(_x distance player)],
					2,
					0.03,
					"PuristaMedium"
				];

			};
			true
		} count _vehicles;
		
		{
			_control = (uavControl _x) select 0;
			if ( _control in (units group player) || (side _x in [east,west] && playerSide == side _x && player distance _x < 2000) ) then {
				drawIcon3D [
					friendlyIcon,
					sideColor,
					_x modelToWorld getCenterOfMass _x,
					0.3,
					0.3,
					0,
					"",
					0,
					0.03,
					"PuristaMedium"
				];
				
				if ( showNames ) then {
					_uavName = "";
					if ( !isNull ((uavControl _x) select 0) ) then {
						_uavName = name ((uavControl _x) select 0);
					};
				
					drawIcon3D [
						"",
						[1,1,1,1],
						visiblePosition _x,
						0,
						0,
						0,
						format ['%1 (%2m)', _uavName, round (player distance _x)],
						2,
						0.03,
						"PuristaMedium"
					];
				};
			};
		} count allUnitsUAV;
	}];
	
	mapCursorTarget = objNull;
	(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseMoving", BL_fnc_trackMapMouse];
	(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", BL_fnc_DrawMapIcons];
		
	private ["_role","_img","_damageColor","_damagePercent","_height"];
	while { true } do {
		if ( isNull _hud ) then {
			[] call _createHud;
		};
	
		_playerInfo ctrlSetStructuredText parseText format['
		<img image="client\systems\hud\icons\health.paa" size="0.8" /> <t shadow="2">%2%1</t><br />
		<img image="client\systems\hud\icons\stamina.paa" size="0.8" /> <t shadow="2">%3%1</t><br />
		<img image="client\systems\hud\icons\compass.paa" size="0.8" /> <t shadow="2">%4°</t><br />
		',
		'%',
		round (100-(damage player)*100),
		round (100-(getFatigue player)*100),
		round ((eyeDirection player) call CBA_fnc_vectDir)
		];
		
		if ( vehicle player != player ) then {
			_vehicleInfo ctrlShow true;
			_vehicleUnits = "";
			{
				_role = (assignedVehicleRole _x);
				_img = "";
				
				if ( count _role > 0 ) then {
					_img = (_role select 0) call {
						if ( _this == "Cargo" ) exitwith{"\a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa"};
						if ( _this == "Driver" ) exitwith{"\a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa"};
						if ( _this == "Turret" ) exitwith{"\a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa"};
						""
					};
				
					_damageColor = "";
					if ( alive _x ) then {
						_damagePercent = round (255 * (1-damage _x));
						_damageColor = format['#FF%1%1', _damagePercent call _decToHex];
					}
					else {
						_damageColor = "#000000";
					};
					
					_vehicleUnits = _vehicleUnits + format['
					<t shadow="2" color="%3">%1</t> <img image="%2" size="0.8" /><br />
					',
					name _x,
					_img,
					_damageColor
					];
				};
			} count (crew vehicle player);
			
			_vehicleInfo ctrlSetStructuredText parseText format['<t align="right">%1</t>', _vehicleUnits];
			_height = _lineHeight * (count crew vehicle player);
			
			_vehicleInfo ctrlSetPosition [
				_vehicleX,
				_vehicleY + (_vehicleH - _height),
				_vehicleW,
				_height
			];
			
			_vehicleInfo ctrlCommit 0;
		}
		else {
			_vehicleInfo ctrlShow false;
		};
		
		sleep 0.05;
	};
};