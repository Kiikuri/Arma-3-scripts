this addeventhandler ["fired", {  
	_eh = [
	_this select 0, 
	_this select 4] spawn 
	{
		_minDist = 100;
		_tHeight = 4;
		_ex = "Drone_explosive_ammo";
		
		_veh = _this select 0; 
		_type = _this select 1; 
		_bullet = nearestObject [_veh,_type]; 
		waitUntil{_veh distance _bullet > _minDist}; 
		waitUntil{getPosATL _bullet select 2 <= _tHeight}; 
		_pos = getPosATL _bullet;
		deleteVehicle _bullet; 
		_o = _ex createVehicle _pos;
		_o setDamage 1;
	};
}]; 