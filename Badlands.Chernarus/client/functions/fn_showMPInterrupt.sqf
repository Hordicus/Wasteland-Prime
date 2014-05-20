private ['_saveIDC'];
_saveIDC = getNumber (configFile >> "RscDisplayMPInterrupt" >> "controls" >> "ButtonSAVE" >> "idc");

createDialog "RscDisplayMPInterrupt";
((uiNamespace getVariable "RscDisplayMPInterrupt") displayCtrl _saveIDC) ctrlEnable savingEnabled;