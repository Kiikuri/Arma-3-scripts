// Airbust that explodes over target
// range = radius of the target check
// onlyMainGun = use airburst with the main gun. [true/false]
// check = what kind of units to check for
// check for everything:
// _check = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; 

this addeventhandler ["fired", {   

	_eh = [
	_this select 0, 
	_this select 4
	] spawn 
	{
		_range = 10;
		_onlyMainGun = true;
		_check = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; 
		_ex = "Drone_explosive_ammo";

		_veh = _this select 0;
		if(_onlyMainGun && currentWeapon _veh != weapons _veh select 0) exitWith {};
		_type = _this select 1; 
		_crew = crew _veh;
		_bullet = nearestObject [_veh,_type]; 
		waitUntil{
			_no = nearestObjects[getPosATL _bullet, _check, _range, false];
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
		_pos = getPosATL _bullet;
		deleteVehicle _bullet; 
		_o = _ex createVehicle _pos;
		_o setDamage 1;
	};
}]; 