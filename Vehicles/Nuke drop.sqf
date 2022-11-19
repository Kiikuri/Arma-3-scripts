// vehicle z = 1000m
// pylon = B83 Nuclear Bomb
// other pylons = empty

0= [] spawn { 
_veh = kone;
_tar = kohde;

_veh doMove getPosATL _tar;
_veh doWatch _tar;
_veh doTarget _tar;
waitUntil{_veh distance _tar < 6500};
_veh fireAtTarget[_tar, ((weapons _veh) select 3)];
sleep 2;
deleteVehicle _veh;
}