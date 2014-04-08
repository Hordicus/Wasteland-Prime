private ['_rating'];
_rating = [_this, 0, -100000, [0]] call BIS_fnc_param;

// Reset rating to 0
if ( rating player > 0 ) then {
	player addRating -(rating player);
}
else {
	player addRating abs(rating player);
};

if ( _rating != 0 ) then {
	player addRating _rating;
};

_rating