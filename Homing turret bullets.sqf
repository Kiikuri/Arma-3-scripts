// Bullets fired start homing to target when they get to a specified range. Put into a vehicles init.
// _range = max range from bullet to target
// _speed = speed of the bullet
// check = what kind of units to check for
// check for everything:
// _check = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; 

this addeventhandler ["fired", { 
	_bullet = nearestObject [_this select 0,_this select 4]; 
	_eh = [
	_bullet, _this select 0] spawn 
	{
		_range = 200;
		_speed = 5000;
		_check = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; 

		_bullet = _this select 0;
		_veh = _this select 1;
		_target = objNull;
		_position = getPosATL _bullet;
		_units = allUnits;
		_no = [];
		_i = 0;
		waitUntil{
			_no = nearestObjects[getPosATL _bullet, _check, _range, false];
			_crew = crew _veh;
			_no = (_no - _crew) - [_veh];
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
		systemChat str[_no];
		_target = vehicle (_no select 0);
		while{alive _target && alive _bullet} do {
			_bullet setVelocity [  
				0,
				0,
				0
			];  
			_tarpos = getPosATL _target;
			_h = _tarpos select 2;
			_middle = (boundingBox _target select 1 select 2)/2;
			_tarpos = [_tarpos select 0, _tarpos select 1, _h + _middle];
			_bulpos = getPosATL _bullet;
			_velo = velocity _bullet; 
			_dir = _bulpos vectorFromTo _tarpos; 
			_bullet setVectorDir _dir;  
			_bullet setVelocity [  
				(_velo select 0) + (_dir select 0)*_speed,  
				(_velo select 1) + (_dir select 1)*_speed,  
				(_velo select 2) + (_dir select 2)*_speed  
			];  
			sleep 0.2;
		};
	};
}];