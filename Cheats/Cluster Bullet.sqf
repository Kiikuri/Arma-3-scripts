this addeventhandler ["fired", { 
	_bullet = nearestObject [_this select 0,_this select 4]; 

	0= [_bullet] spawn {  
		_interval = interval;
		_amount = amount;
		_speed = velo;
		_projectile = projectile;

		_bullet = _this select 0;
		while{alive _bullet} do {
			sleep _interval;
			_bulletpos = getPosATL _bullet; 
			_i = 0;
			while{_i < 360} do {    
				_coord = _bulletpos getPos [1, _i];  
				_rotation = [_coord select 0, _coord select 1, _coord select 2];     
				_o = _projectile createVehicle _coord;   
				_ex = _bulletpos getPos [10, _i];  
				_dir = _coord vectorFromTo _ex;  
				_o setVectorDir _dir;  
				_o setVelocity [  
					(_dir select 0)*_speed,  
					(_dir select 1)*_speed,  
					(_dir select 2)*_speed  
				];  
				_i = _i + (360/_amount);    
			};   	
		};
	};
}];
