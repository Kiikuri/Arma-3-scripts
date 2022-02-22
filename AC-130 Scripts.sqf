// AGM    ((weapons _veh)select 0)
// Laser  ((weapons _veh)select 1)
// 105 AP ((weapons _veh)select 2)
// 105 HE ((weapons _veh)select 3)
// 40 AP  ((weapons _veh)select 4)
// 40 HE  ((weapons _veh)select 5)
// 20     ((weapons _veh)select 6)

// Burst (Shoots n times)
// sleep intervalls:
// 105mm (2-3) = 4.5 
// 40mm  (4-5) = 0.3
// 20mm  (6)   = 0.0006
// AGM   (0)   = 2
0=[] spawn
{
_veh = kone;
_cal = 6;
_interval = 0.0006;
_n = 100;

_tar = laserTarget player;
_veh lockCameraTo [getPosASL _tar, [0]];
_veh fireAtTarget [_tar, ((weapons _veh)select 1)];
_i = 0;
sleep 2;
_ase = ((weapons _veh)select _cal);
while{_i < _n} do{
    _veh fireAtTarget [laserTarget _veh, _ase];
    _i = _i +1;
    sleep _interval;
};
_veh lockCameraTo [objNull,[0]];
};

// HitScan (Into AC-130 init)
this addeventhandler ["fired", {  
  _bullet = nearestObject [_this select 0,_this select 4];  
  _bulletpos = getPosASL _bullet;    
  _weapdir = kone weaponDirection currentWeapon kone;  
  _dist = 10;  
  _BulletSpeed = 20000; 
  _bullet setPosASL [  
    (_bulletpos select 0) + (_weapdir select 0)*_dist,  
    (_bulletpos select 1) + (_weapdir select 1)*_dist,  
    (_bulletpos select 2) + (_weapdir select 2)*_dist  
  ];  
  _up = vectorUp _bullet;  
  _bullet setVectorDirAndUp[_weapdir,_up]; 
  _bulletVelo = velocity _bullet;   
  _bulletDir = direction _bullet; 
  _bullet setVelocity [ 
    (_bulletVelo select 0) + (_weapdir select 0)*_BulletSpeed, 
    (_bulletVelo select 1) + (_weapdir select 1)*_BulletSpeed, 
    (_bulletVelo select 2) + (_weapdir select 2)*_BulletSpeed 
    ]; 
}];


// cluster strike for fun
this addeventhandler ["fired", {  
  _bullet = nearestObject [_this select 0,_this select 4];  
  _bulletpos = getPosASL _bullet;    
  _o = "BombCluster_02_Ammo_F" createVehicle _bulletpos; 
  _weapdir = kone weaponDirection currentWeapon kone;  
  _dist = 10;  
  _BulletSpeed = 20000; 
  _o setPosASL [  
    (_bulletpos select 0) + (_weapdir select 0)*_dist,  
    (_bulletpos select 1) + (_weapdir select 1)*_dist,  
    (_bulletpos select 2) + (_weapdir select 2)*_dist  
  ];  
  _up = vectorUp _bullet;  
  _o setVectorDirAndUp[_weapdir,_up]; 
  _bulletVelo = velocity _bullet;   
  _bulletDir = direction _bullet; 
  _o setVelocity [ 
    (_bulletVelo select 0) + (_weapdir select 0)*_BulletSpeed, 
    (_bulletVelo select 1) + (_weapdir select 1)*_BulletSpeed, 
    (_bulletVelo select 2) + (_weapdir select 2)*_BulletSpeed 
    ]; 
	deleteVehicle _bullet;
}];