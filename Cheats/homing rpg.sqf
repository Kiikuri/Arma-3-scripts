this addeventhandler ["fired", { 
	_bullet = nearestObject [_this select 0,_this select 4]; 
	_eh = [_bullet, _this select 0] spawn 
	{
		_scanRange = 1000;
		_maxRange = 3000
		_check = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; 

		_bullet = _this select 0;
		_veh = _this select 1;
		_target = objNull;
		_position = getPosATL _bullet;
		_units = allUnits;
		_no = [];
		_i = 0;
		waitUntil{
			_no = nearestObjects[getPosATL _bullet, _check, _scanRange, false];
			_crew = crew _veh;
			_no = (_no - _crew) - [_veh] - units group _veh;
			_i = 0;
			while{ _i < count _no} do {
				_cu = _no select _i;
				if((".p3d" in str(_cu)) || ("Agent" in str(_cu)) || !alive _cu) then{
					_no deleteAt _i;
					continue;
				};
				_i = _i + 1;
			};
			if (count _no < 1) exitWith { false };
			{alive _x} forEach _no
		}; 
		_target = vehicle (_no select 0);
		_speed = speed _bullet;
		while{alive _target && alive _bullet && getPosATL _veh distance getPosATL _bullet < _maxRange} do {
			_tarpos = getPosATL _target;
			_h = _tarpos select 2;
			_middle = (boundingBox _target select 1 select 2)/2;
			_tarpos = [_tarpos select 0, _tarpos select 1, _h + _middle];
			_bulpos = getPosATL _bullet;
			_dir = _bulpos vectorFromTo _tarpos; 	
			_pos = _dir vectorMultiply _speed;
			_head = _bullet getDir _target;
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