"Aimbot fire at laser target. Only works with drones with a laser, i.e darter";
"place in any init field along with the function";
"the script can be controlled with the 3 global variables.";
0= [] spawn{
	interval = 0.1;
	adminWeapon = 0;
	heigth = 200;

	while{true}
	do{
		waitUntil{sleep 0.1; !isNull laserTarget getConnectedUAV player};
		while{!isNull laserTarget getConnectedUAV player}
		do{
			call Drone_fnc_AdminFireAtTarget;
			sleep interval;
		};
	};
};


Drone_fnc_AdminFireAtTarget =
{
	_drone = getConnectedUAV player; 
	_munition = "Sh_82mm_AMOS";
	switch (adminWeapon) do
	{
		default { _munition = "Sh_82mm_AMOS"; hint str["82mm Mortar HE"];};
		case 1: { _munition = "Smoke_82mm_AMOS_White"; hint str["82mm Mortar Smoke"];};
		case 2: { _munition = "Sh_155mm_AMOS"; hint str["155mm HE"];};
		case 3: { _munition = "grenadeHand"; hint str["Hand Grenade"];};
		case 4: { _munition = "B_127x99_Ball_Tracer_Red"; hint str[".50Cal US Red Tracer"];};
		case 5: { _munition = "B_127x108_Ball"; hint str[".50Cal Russian"];};
		case 6: { _munition = "B_127x108_APDS"; hint str[".50Cal Russian APDS"];};
		case 7: { _munition = "ammo_Fighter01_Gun20mm_AA"; hint str["20mm HE"];};
		case 8: { _munition = "ammo_Fighter02_Gun30mm_AA"; hint str["30mm HE"];};
		case 9: { _munition = "B_30mm_HE_Tracer_Red"; hint str["30mm HE Red Tracer"];};
		case 10: { _munition = "B_30mm_AP"; hint str["30mm AP"];};
		case 11: { _munition = "G_40mm_HEDP"; hint str["40mm HEDP Grenade"];};
		case 12: { _munitiox = "ammo_ShipCannon_120mm_HE"; hint str["120mm HE"];};
		case 13: { _munition = "ammo_ShipCannon_120mm_HE_cluster"; hint str["120mm HE Cluster"];};
		case 14: { _munition = "ammo_Bomb_SDB"; hint str["250lb HE GBU SDB"];};
		case 15: { _munition = "Bomb_03_F"; hint str["565lb HE KAB 250 LGB"];};
		case 16: { _munition = "BombCluster_02_Ammo_F"; hint str["1100lb Cluster RBK-500F"];};
		case 17: { _munition = "USAF_Bo_B61"; hint str["B61 Nuclear Bomb"];};
	};
	_laserPos = getPosASL laserTarget _drone; 
	_tarPos = [
		_laserPos select 0,
		_laserPos select 1,
		(_laserPos select 2) + heigth
	];
	_bullet = _munition createVehicle _tarPos;
	_bullet setVectorUp [0,1,0];
	_bullet setVelocity
	[
		0,
		0,
		-200
	];
};
