this addeventhandler ["fired", { 
	_bullet = nearestObject [_this select 0,_this select 4]; 
	_eh = [_bullet, _this select 0] spawn 
	{
		_bullet = _this select 0;
		_veh = _this select 1;
		_speed = speed _bullet;
		systemChat str[velocity _bullet select 2];
		waitUntil{getPosATL ABTar distance getPosATL _bullet < 500};
		while{alive _bullet} do {
			_tarpos = getPosATL ABTar;
			systemChat str[velocity _bullet select 2];
			_bulpos = getPosATL _bullet;
			_dir = _bulpos vectorFromTo _tarpos; 	
			_pos = _dir vectorMultiply _speed;
			_head = _bullet getDir ABTar;
			_bullet setDir _head;
			_bullet setVelocity [  
				_pos select 0,
				_pos select 1,
				_pos select 2
			];  
			sleep 0.01;
		};	
	};
}];