0= [] spawn { 
" 	Script for an artillery barrage.
	Assuming more than 2 shots / artillery piece has been requested:
	1. 	All of the units fire at once to open the barrage
	2. 	All units start firing after a set interval. 1st starts firing, a second passes,
		2nd starts firing, a second passes, 3rd fires and so on.
	3.	After the main barrage, all units fire at once again after a set amount of seconds
		to end the barrage.";

	_veh = arty;  		" any artillery unit in a battery";
    _tar = tar;			" target";

    _shots = 15;			" number of shots fired";
    _interval = 2;		" time between shots in seconds";
	_endTime = 30;		" time to wait before the ending volley in seconds";
    _magazineSlot = 0;	" type of ammunition used";
	_spread = 100;		" radius of the target area in meters";




	" declaring required variables";
	fired = [];
	_barrages = 1;
	if(_shots > 2)
	then
	{
		_barrages = 2;
	};

	" getting all units within a battery";
	_units = units group _veh; 
	_i = 0; 
	_vehicles = []; 
	while{_i < count _units} 
	do 
	{ 
		if(!(vehicle (_units select _i) in _vehicles)) 
		then  
		{ 
			_unit = vehicle (_units select _i);
			_vehicles =  _vehicles + [_unit];
			_direction = _unit getDir _tar;
			_unit setDir _direction;
		}; 
		_i = _i + 1; 
	}; 
	doStop _vehicles;


	" 1st volley";
	_i = 0;
	while{_i < count _vehicles}
	do
	{
		_obj = (_vehicles select _i);
		_obj removeAllEventHandlers "fired";
		_obj addEventHandler ["fired", {fired = fired + [_this # 0]}];
		_finaltar = _tar getPos [_spread * sqrt random 1, random 360];
		_obj doArtilleryFire[_finaltar, ((magazines _obj) select _MagazineSlot), 1];
		_i = _i + 1;
	};
	" check if fired";
	waitUntil
	{ 
		sleep 1;
		count fired >= count _vehicles
	};

	" resetting variables and stopping if only a single volley has been requested";
	_i = 0;
	fired = [];
	if(_shots <= 1) exitWith{};


	" the main barrage";
	while{_i < count _vehicles}
	do
	{
		sleep _interval;
		_obj = (_vehicles select _i);
		_finaltar = _tar getPos [_spread * sqrt random 1, random 360];  
		_obj doArtilleryFire[_finaltar, ((magazines _obj) select _MagazineSlot), _shots - _barrages];
		_i = _i + 1;
	};
	" check if all round have been fired";
	waitUntil
	{
		sleep 10;
		count fired >= ((count _vehicles)*(_shots - _barrages))
	};
	fired = [];

	" ending volley. Only if more than 2 shots / arty unit has been requested";
	sleep _endTime;
	if(_barrages == 2)
	then
	{
		_i = 0;
		while{_i < count _vehicles}
		do
		{
			_obj = (_vehicles select _i);
			_finaltar = _tar getPos [_spread * sqrt random 1, random 360];  
			_obj doArtilleryFire[_finaltar, ((magazines _obj) select _MagazineSlot), 1];
			_i = _i + 1;
		};
	};
}