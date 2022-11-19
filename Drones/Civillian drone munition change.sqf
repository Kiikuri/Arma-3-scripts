"Used with civillian drones with droppable bombs. Replaces the drones munitions with 82mm mortar shells"

this addeventhandler ["fired", { 
  	_bullet = nearestObject [_this select 0,_this select 4]; 
  	_bulletpos = getPosASL _bullet; 
  	_up = vectorUp _bullet; 
  	_bulletVelo = velocity _bullet;  
  	_bulletDir = vectorDir _bullet;
  	deleteVehicle _bullet;

 	_o = "Sh_82mm_AMOS" createVehicle _bulletpos; 
   	_o setPosASL [ 
    	(_bulletpos select 0), 
   		(_bulletpos select 1), 
   		(_bulletpos select 2) - 0.1 
  	]; 
  	_o setVectorDirAndUp[_bulletDir,_up];
  	_o setVelocity _bulletVelo;
}];