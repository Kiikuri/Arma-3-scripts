"Function to drop munitions from a drone";
Drone_fnc_dropMunition =
{
	_munition = "Sh_82mm_AMOS";		"dropped munition's cfg name";

	_drone = getConnectedUAV player;
	_dronePos = getPosASL _drone; 
	_droneVelo = velocity _drone;
	_o = _munition createVehicle _dronepos; 
	_o setPosASL [  
		(_dronePos select 0),  
		(_dronePos select 1),  
		(_dronePos select 2) - 0.3
	]; 
	_o setVectorUp [0,0,-1];
	_o setVelocity [
		_droneVelo select 0,
		_droneVelo select 1,
		-0.2
	];
};


"Drop munitions. Only works with drones with a laser, i.e darter";
"place in any init field along with the function";
0= [] spawn{
	while{true}
	do{
		waitUntil{sleep 0.1; !isNull laserTarget getConnectedUAV player};
		call Drone_fnc_dropMunition;
		waitUntil{sleep 0.1; isNull laserTarget getConnectedUAV player};
		call Drone_fnc_dropMunition;
	};
};

"Used with civillian drones without droppable munitions or lasers. Creates an 82mm mortar shell that drops from the drone.";
"place the function in any init field to call it";
call Drone_fnc_dropMunition;