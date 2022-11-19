// Jump mine. An explosive which shoots another explosive into the air, which detonates at a given altitude and
// peppers the area below with a set amount of shrapnel.
// variables:
// _wep = variable name of the explosive
// _max = amount of shrapnel
// _ammo = cfg file name of the projectiles
// _r = radius of the kill zone
// _height = height at which the secondary explosive explodes in meters
// _speed = speed of the projectiles
// _shotup = secondary explosive cfg name

// works well with:     
// _max = 1000;
// _ammo = "B_762x39_Ball_F" / "B_127x108_Ball";      
// _r = 50;   
// _height = 10;        
// _speed = 100;  
// _shotup = "GrenadeHand";

0= [] spawn {     
	_wep = miina1_1;      
	_max = 1000; 
	_ammo = "B_127x108_Ball";       
	_r = 50;    
	_height = 10;         
	_speed = 200;   
	_shotup = "GrenadeHand"; 



  
	_i = 0;      
	_position = getPosATL _wep;   
	_val = _position select 2;    
	_des = _val + _height;   
	_val = _val + 0.5;    
	_position = [_position select 0, _position select 1, _val];    
	_wep setDamage 1;   
	_wep = _shotup createVehicle _position;  
	_wep setVectorDir [0,0,1];     
	_wep setVelocity [    
	0,   
	0,   
	2*_height   
	];     
	waitUntil { getPosATL _wep select 2 >= _height};  
	_position = getPosASL _wep;
	_position = [_position select 0, _position select 1, _height];  
	deleteVehicle _wep;  
	_wep = "Drone_explosive_ammo" createVehicle _position; 
	_wep setDamage 1;      
 
	while{_i < _max} do {    
		_coord = _wep getPos [(2*_r) * sqrt random 1, random 360];  
		_ex = getPosATL _wep;  
		_val = _coord select 2;  
		_val = _val - _height;  
		_coord = [_coord select 0, _coord select 1, _val];  
		_o = _ammo createVehicle _ex;   
		_velo = velocity _o;  
		_dir = _ex vectorFromTo _coord;  
		_o setVectorDir _dir;  
		_o setVelocity [  
			(_velo select 0) + (_dir select 0)*_speed,  
			(_velo select 1) + (_dir select 1)*_speed,  
			(_velo select 2) + (_dir select 2)*_speed  
		];  
		_i = _i + 1;    
	};   
};


// original secondary charge: "Drone_explosive_ammo"