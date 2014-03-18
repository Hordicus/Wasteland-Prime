player addEventHandler ['respawn', {
	player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];
}];

player addAction ['Player Menu', "createDialog 'playerMenuDialog';", [], -1];