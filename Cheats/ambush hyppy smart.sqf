0= [] spawn {
	tela1 setDamage 1; 
	sleep 10;



	//hyppypanosten laukaisu
	_name = "hyppy_";   
	_lkm = 4; 
	
	_numero = 0;   
	while{_numero < _lkm}  
	do  
	{  
		_numero = _numero +1;  
		_numb = str _numero;  
		_nimi = _name + _numb; 
		_obj = call compile _nimi; 
		
		_wep = _obj;      
		_max = 1000; 
		_ammo = "B_127x108_Ball";       
		_r = 50;    
		_height = 10;         
		_speed = 200;   
		_shotup = "GrenadeHand"; 

		_position = getPosATL _wep; 
		_i = 0;
		_trig = createTrigger["EmptyDetector", _position];
		_trig setTriggerArea [_r, _r, 0, false, _height];
		_units = allUnits;
		_targets = [];
		_i = 0;
		while{_i < (count _units)} do {
			if(_units select _i inArea _trig) then {
				_targets append [_units select _i];
			};
			_i = _i + 1; 
		};
		_i = 0;
		deleteVehicle _trig;  
	
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
	
		if(count _targets > 0) then{
			_l = 0;
			while{_i < _max} do { 
				if(_l >= (count _targets))  then{
					_l = 0;
				};
				_coord = getPosATL (_targets select _l);

				_ex = getPosATL _wep;  
				_val = _coord select 2;  
				_val = _val + 1;  
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
				_l = _l + 1;    
			};   
		}
		else{
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
	};




	// sotilaiden hyökkäys
	_name = "soldier_";   
	_lkm = 34; 
	
	_numero = 0;   
	while{_numero < _lkm}  
	do  
	{  
		_numero = _numero +1;  
		_numb = str _numero;  
		_nimi = _name + _numb; 
		_obj = call compile _nimi; 
		_obj enableSimulationGlobal true;
	};
	auto_1 enableSimulationGlobal true;
	auto_1D enableSimulationGlobal true;
	auto_1G enableSimulationGlobal true;
};