// Ampuu 50. cal luoteja jokaiselle asteelle ympyrässä. tietyllä korkeudella

0= [] spawn {     
	_wep = miina1;        
	_height = 1;           
	_speed = 200;
	_ammo = "B_127x108_Ball";   
	
	_shotup = "GrenadeHand";  
	_position = getPosATL _wep;        
	_wep setDamage 1;
	_wep = _shotup createVehicle _position;          
	_wep setVelocity [     
		0,    
		0,    
		5*_height    
	];        
	waitUntil { getPosATL _wep select 2 >= _height};
	_position = getPosATL _wep;
	deleteVehicle _wep;
	_wep = "Drone_explosive_ammo" createVehicle 
	[
		_position select 0,
		_position select 1,
		_height
	];   
	_position = getPosATL _wep;
	_wep setDamage 1; 

	_i = 0;
	while{_i < 360} do {    
		_coord = _position getPos [0.1, _i];  
		_coord = [_coord select 0, _coord select 1, _height];    
		_ex = _position getPos [10, _i];  
		_ex = [_ex select 0, _ex select 1, _height];   
		_o = _ammo createVehicle _coord;   
		_dir = _coord vectorFromTo _ex;  
		_o setVectorDir _dir;  
		_o setVelocity [  
			(_dir select 0)*_speed,  
			(_dir select 1)*_speed,  
			(_dir select 2)*_speed  
		];  
		_i = _i + 1;    
	};   
};