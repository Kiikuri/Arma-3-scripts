// A-10 _ase:
// 1 = GAU-12
// 4 = Rockets
// 5 = AGM
// 6 = GBU-12 Paveway
// 7 = Sidewinder
//_veh = A-10 variable name
//_tar = target variable name
//_ase = weapon to use

0 = thisTrigger spawn { 
	_veh = kone;
 	_tar = laserTarget player;
	_ase = 1;


	_veh commandChat "Target Acquired";
	_spe = (speed _veh)/3.6;
	_ran = _veh distance2D _tar;
	if(_ran < 5000)
	then
	{
		_ran = abs(_ran - 1000);
		_eta = _ran/_spe;
		switch(true) do{
			case(_eta > 60):
			{
				_eta = round(_eta/60);
				_veh commandChat format["ETA %1 minutes", floor _eta];
			};
			case(_ran > 5000):
			{
				_veh commandChat format["ETA %1 seconds", floor _eta];
			};
		};
	};

	while {alive _tar} do { 
		_veh doTarget _tar; 
		_veh selectWeapon((weapons _veh)select _ase);  
		if ((_veh weaponDirection (_veh currentWeaponTurret [-1]) vectorCos ((position _tar) vectorDiff (eyepos driver _veh))) > 0.999) 
		then 
		{ 
			_veh fireAtTarget[_tar];
		} 
		else 
		{ 
			driver _veh lookAt _tar 
		}; 
		sleep .1; 
	}; 
	_veh commandChat "Target Eliminated";
};