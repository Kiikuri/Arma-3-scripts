"Controls with default values";
"Mode select";
mode = 1;

"Multiple";
projectile = "Sh_155mm_AMOS";
TarCrit = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"]; "Homing target criteria";

"Impact";
ImpktInt = 0.001; "Impact interval between checks";
ImpktInc = 3; "Impact increment";

"AirBurst overall";
ABElev = 10; "Airburst Elevation";
ABEx = "Drone_explosive_ammo";

"AirburstOver Target";
ABoTMG = true;

"Homing";
HSR = 1000; "Homing scan range";
HMaR = 3000; "Homing max range";
HCBTProj = true; "Homing change bullet to projectile";
HCR = 30; "Homing projectile change range";

"Cluster";
CluInt = 1; "Cluster interval";
CluAm = 6; "Cluster amount";


this addeventhandler ["fired", { 
	_bullet = nearestObject [_this select 0,_this select 4]; 
	_veh = _this select 0;

	0= [_bullet, _veh] spawn {  
		switch (mode) do{
			case 1: {[_this select 0, projectile] call fnc_Switch;};
			case 2: {[_this select 0, projectile, ImpktInt, ImpktInc] call fnc_Impact;};
			case 3: {[_this select 0, ABEx, ABElev] call fnc_Airburst;};
			case 4: {[_this select 0, _this select 1, ABElev, ABoTMG, TarCrit, ABEx] call fnc_AirburstOverTarget;};
			case 5: {[_this select 0, _this select 1, HSR, HMaR, TarCrit, projectile, HCBTProj, HCR] call fnc_Homing;};
			case 6: {[_this select 0, projectile, CluInt, CluAm] call fnc_Cluster;}; 
			case (-1): {call fnc_ResetValues;};
			default break;
		};
	};
}];

fnc_ResetValues = {
	mode = 1;
	projectile = "Sh_155mm_AMOS";
	ImpktInt = 0.001;
	ImpktInc = 3;
	ABElev = 10;
	ABEx = "Drone_explosive_ammo";
	ABoTMG = true;
	HSR = 1000;
	HMaR = 3000;
	HCBTProj = true; 
	HCR = 30;
	TarCrit = ["Man", "LandVehicle", "Helicopter", "Plane", "Ship", "StaticWeapon", "Submarine", "Mine", "Parachute"];
	CluInt = 1;
	CluAm = 6;
};

fnc_Switch = {
	_bullet = _this select 0;
	_projectile = _this select 1;
	_velo = velocity _bullet;
	_o = _projectile createVehicle getPosATL _bullet;
	_o setVelocity _velo;
	deleteVehicle _bullet;
};

fnc_Impact = {
	_bullet = _this select 0;
	_projectile = _this select 1;
	_ImpktInt = _this select 2;
	_ImpktInc = _this select 3;

	_velo = velocity _bullet;
	_positions = [];
	_i = 0;
	while{alive _bullet} do {
		sleep _ImpktInt;
		_bulletpos = getPosATL _bullet;
		_positions pushBack _bulletpos;
		_i = _i + 1;
	};
	_pos = _positions select _i - _ImpktInc;
	_o = _projectile createVehicle _pos;
	_o setVelocity _velo;
};

fnc_Airburst = {
	_bullet = _this select 0;
	_projectile = _this select 1;
	_ABElev = _this select 2;

	waitUntil{getPos _bullet select 2 <= _ABElev};
	_o = _projectile createVehicle getPosATL _bullet;
	deleteVehicle _bullet;
	_o setDamage 1;
};

fnc_Homing = {
	_bullet = _this select 0;
	_veh = _this select 1;
	_HSR = _this select 2;
	_HMaR = _this select 3;
	_TarCrit = _this select 4;
	_projectile = _this select 5;
	_change = _this select 6;
	_HCR = _this select 7;
	_changed = false;
	_target = objNull;
	_position = getPosATL _bullet;
	_units = allUnits;
	_no = [];
	_i = 0;
	waitUntil{
		_no = nearestObjects[getPosATL _bullet, _TarCrit, _HSR, false];
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
	while{alive _target && alive _bullet && getPosATL _veh distance getPosATL _bullet < _HMaR} do {
		_tarpos = getPosATL _target;
		if(_tarpos distance _bullet < _HCR && _change && !_changed) then {
				_o = _projectile createVehicle getPosATL _bullet;
				_o setVelocity velocity _bullet;
				deleteVehicle _bullet;
				_o = _bullet;
		};
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

fnc_Cluster = {
	_bullet = _this select 0;
	_projectile = _this select 1;
	_interval = _this select 2;
	_amount = _this select 3;

	_speed = speed _bullet;

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

fnc_AirburstOverTarget = {
	_bullet = _this select 0;
	_veh = _this select 1;
	_range = _this select 2;
	_onlyMainGun = _this select 3;
	_check = _this select 4;
	_ex = _this select 5;

	
	if(_onlyMainGun && currentWeapon _veh != weapons _veh select 0) exitWith {};
	
	_crew = crew _veh;
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