// Reference: https://board.nitrado.net/support-de-german-only/support-gameserver/dayz/59259/commander-channel-kicken-wenn-man-redet/
// Keys: https://community.bistudio.com/wiki/ArmA_2:_CfgDefaultKeysMapping

monitorVon_firstCheck = true;
monitorVon_DisallowedChannels = [
	// localize "STR_CHANNEL_DIRECT",
	// localize "STR_CHANNEL_GROUP",
	// localize "STR_CHANNEL_SIDE",
	localize "STR_CHANNEL_GLOBAL",
	localize "STR_CHANNEL_COMMAND"
];

monitorVon_BlockedBinds = [
	// "PushToTalk",
	"PushToTalkCommand",
	"PushToTalkAll"
	// "PushToTalkDirect",
	// "PushToTalkGroup",
	// "PushToTalkSide",
	// "PushToTalkVehicle",
];

monitorVon_Messages = [
	["PushToTalkCommand", localize "STR_CHANNEL_COMMAND", format["%1 VON is not allowed.", localize "STR_CHANNEL_COMMAND"]],
	["PushToTalkAll", localize "STR_CHANNEL_GLOBAL", format["%1 VON is not allowed.", localize "STR_CHANNEL_GLOBAL"]]
];

if ( playerSide == resistance ) then {
	monitorVon_DisallowedChannels = monitorVon_DisallowedChannels + [localize "STR_CHANNEL_SIDE"];
	monitorVon_BlockedBinds = monitorVon_BlockedBinds + ["PushToTalkSide"];
	monitorVon_Messages = monitorVon_Messages + [
		["PushToTalkSide", localize "STR_CHANNEL_SIDE", format["%1 VON not allowed on Independent", localize "STR_CHANNEL_SIDE"]]
	];
};

monitorVon_CurrentChannel = localize "STR_CHANNEL_GROUP";

monitorVon_KeyDown = {
	private ["_result","_key","_bind","_blockedKeys","_pushToTalk","_displayChannel","_displayChannelName","_channel"];
	_result = false;
	_key = _this select 1;
	_bind = "";
	_blockedKeys = [];
	_pushToTalk = _key in actionKeys "PushToTalk";
	
	// Get keys every time so changing binds doesn't help them.
	{
		_blockedKeys = _blockedKeys + (actionKeys _x);
		true
	} count monitorVon_BlockedBinds;
	
	_result = _key in _blockedKeys || {(_pushToTalk && monitorVon_CurrentChannel in monitorVon_DisallowedChannels)};
	
	if ( _result ) then {
		_key spawn monitorVon_ShowMessage;
	}
	else { if (monitorVon_firstCheck && _pushToTalk) then {
		_displayChannel = getNumber (configFile >> "RscDisplayChannel" >> "idd");
		_displayChannelName =  getNumber (configFile >> "RscDisplayChannel" >> "controls" >> "CA_Channel" >> "idc");
		_channel = ctrlText ((findDisplay _displayChannel) displayCtrl _displayChannelName);
		
		if ( _channel in monitorVon_DisallowedChannels ) then {
			monitorVon_CurrentChannel = _channel;
			_key spawn monitorVon_ShowMessage;
			_result = true;
		};
		
		monitorVon_firstCheck = false;
	}};
	
	_result
};

monitorVon_ShowMessage = {
	private ['_msg'];
	_msg = "";

	{
		if ( _this in (actionKeys (_x select 0)) ) then {
			_msg = _x select 2;
		}
		else { if ( monitorVon_CurrentChannel == (_x select 1)) then {
			_msg = _x select 2;
		}};
		
		true
	} count monitorVon_Messages;
	
	titleText [_msg, 'BLACK', 0.01];
	
	sleep 2;
	titleFadeOut 0;
};

monitorVon_TrackChannel = {
	private ["_key","_changeChannel","_displayChannel","_displayChannelName"];
	_key = _this select 1;
	_changeChannel = (actionKeys "NextChannel") + (actionKeys "PrevChannel");
	
	_displayChannel = getNumber (configFile >> "RscDisplayChannel" >> "idd");
	_displayChannelName =  getNumber (configFile >> "RscDisplayChannel" >> "controls" >> "CA_Channel" >> "idc");
	
	if ( _key in _changeChannel ) then {
		monitorVon_CurrentChannel = ctrlText ((findDisplay _displayChannel) displayCtrl _displayChannelName);
	};
};

if ( count monitorVon_DisallowedChannels > 0 || count monitorVon_BlockedBinds > 0 ) then {
	(findDisplay 46) displayAddEventHandler ["KeyUp", "_this call monitorVon_TrackChannel"];
	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call monitorVon_KeyDown"];
};